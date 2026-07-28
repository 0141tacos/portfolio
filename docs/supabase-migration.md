# Supabase 移行ロードマップ

**ゴール:** FastAPI を廃止し、**Vercel（フロント） + Supabase（Postgres + PostgREST + RLS）** 構成へ移行する。

**現在地:** フェーズ4進行中。Vercelデプロイ + 環境変数設定、FastAPI / docker-compose撤去が完了。残りはCI/CD（GitHub Actions）のみ。

最終更新: 2026-07-28

---

## フェーズ0：準備

- [x] Supabase CLI インストール
- [x] `supabase init`（`config.toml` 生成）

## フェーズ1：スキーマ移行

- [x] スキーマをマイグレーション化（`supabase/migrations/*_initial_schema.sql` 作成・レビュー完了）
  - `bigint generated always as identity` / `timestamptz` / `moddatetime` 拡張を採用
- [x] ローカル適用で検証（`supabase start` → `supabase migration up`）
  - テーブル5・トリガー5・moddatetime拡張 すべて反映を確認済み
- [x] RLSポリシーのマイグレーション（アクセス制御）
  - 閲覧: 全テーブル anon 可 / 書き込み: 認証済みのみ（authenticated ロール）
  - 全5テーブルで `rowsecurity: true` 確認済み

## フェーズ2：クラウド反映

- [x] Supabaseクラウドプロジェクト作成 & `supabase link`
- [x] `supabase db push`（リモートDBへスキーマ反映）
- [x] 既存データの投入（旧FastAPI用DBからpg_dump→ローカル→クラウドの順で投入完了）

## フェーズ3：フロント連携

- [x] `supabase-js` 導入
- [x] 各 store の `fetch` → supabase 呼び出しに置換（読み取り系から先に）
  - [x] skillStore / careerStore / hobbyStore / certificationStore（置換・疎通確認・レビュー済み。エラーハンドリングは`throw error`で統一）
  - [x] blog閲覧（`Blog.vue`、同パターンで置換・レビュー済み）
  - [x] `BlogPost.vue` 削除、`router/index.js` から `/blogPost` ルート除去（投稿UIはSupabase管理画面運用の方針のため不要に）
- [x] ~~Supabase Auth（blog投稿機能の認証）~~ → blog投稿はSupabase管理画面（Table Editor）で運用する方針に変更（判断ログ参照）。ポートフォリオアプリ側に投稿UI・認証は実装しない

## フェーズ4：旧構成の撤去 & デプロイ

- [x] FastAPI / docker-compose 撤去、環境変数整理
- [x] Vercel デプロイ + 環境変数設定
- [ ] CI/CD（GitHub Actions）

---

## メモ / 判断ログ

- **API構成:** FastAPI廃止 → PostgREST直叩き。anon key は公開前提、DBの防御は **RLS** が担う。
- **スキーマ方針:** `SERIAL`→`identity`、`timestamp`→`timestamptz`、`updated_at` は `moddatetime` 拡張で自動更新（自作関数は不要）。
- **決定:** `skills.is_active` に `DEFAULT TRUE` を付与（2026-07-10 対応済み）。
- **データ投入方針:** 新スキーマは `id` が `GENERATED ALWAYS AS IDENTITY` のため、旧DBから`pg_dump --data-only --column-inserts`で抜いたデータは `id` 列を除去し再採番する方針とした。旧idの欠番（削除履歴）は引き継がない。
- **投入手順:** `supabase db psql`はCLI 2.108.0に未実装だったため、素の`psql`でpostgresロール直結（ローカル: `postgresql://postgres:postgres@127.0.0.1:54322/postgres`）→クラウドの順に同一`dump.sql`を流し込んで対応。
- **フェーズ3進め方:** RLSで書き込みは`authenticated`のみのため、`supabase-js`への置換は読み取り系store（skills/career/hobby/certification/blog閲覧）を先に進め、blog投稿（書き込み）は後回しにする方針とした（2026-07-15）。
- **blog投稿機能の扱い:** 投稿UIの置き場所として①同一アプリ内の隠しルート（`/admin`等）②別アプリ・別ドメインの管理画面③Supabase管理画面（Table Editor）で直接運用、の3案を検討。
  - ①は却下：VueのSPAはルート定義がビルド時にバンドルへ含まれるため、リンクを出さなくても devtools のチャンク名や履歴、robots.txt未設定時のクローラ経由で訪問者に発見されるリスクがある。
  - 当面は③で運用することに決定。投稿者は本人のみで十分機能し、デプロイを急ぎたいため移行のクリティカルパスから外した。既存の`BlogPost.vue`（投稿フォーム）は今後不要になる見込み。
  - ②（別アプリとしての管理画面）は学習目的の将来プロジェクトとして保留。フェーズ4完了後、余裕があれば着手を検討する。
- **ハマりどころ：docker-composeでnpmパッケージ追加後にimport解決エラー:** `frontend`サービスは `volumes: - ./frontend:/app - /app/node_modules` という構成で、`/app/node_modules` が無名ボリュームとしてbind mountを上書きしている。そのため `package.json` にパッケージを追加して `docker-compose up --build` しても、古い無名ボリュームの`node_modules`がそのまま使われて新パッケージが反映されないことがあった。`docker-compose down` でコンテナ・無名ボリュームごと削除してから `--build` で作り直すことで解決。今後パッケージを追加する際は同様の手順を踏む。
- **ルーティング方針（フェーズ4）:** vue-routerは`createWebHistory`（history mode）のままとし、Vercel側で`vercel.json`にrewrite設定を入れて直リンク404を回避する方針とした。hash modeへの変更は却下：ポートフォリオとして共有するURLの見た目やSEOを優先し、rewrite設定自体はVercelで数行足すだけで済むため（2026-07-22）。
- **`vercel.json`の配置場所:** `frontend`配下に置く方針。VercelのRoot Directoryを`frontend`に設定する前提のため、リポジトリルートではなく`frontend`配下に置かないと認識されない（2026-07-22）。
- **デプロイ方式:** Vercel×GitHub連携（Git Integration）で自動デプロイする方針。PRごとにPreviewデプロイ、mainマージでProductionデプロイが自動発行される。既存のPRベースの開発フローと相性が良く、CLIでの手動デプロイは不採用とした（2026-07-22）。
- **CI/CDの役割分担:** GitHub Actionsはlint/テスト実行専用とし、デプロイ自体はVercelのGit連携に任せる方針とした（2026-07-22）。
- **Vercelデプロイ完了:** Root Directory設定・環境変数登録・`frontend/vercel.json`のrewrite設定・GitHub連携を実施し、初回デプロイに成功。スマホからのアクセスでもSPAルーティングが正しく機能することを確認済み（2026-07-22）。
- **FastAPI / docker-compose撤去完了:** `backend/`一式（Dockerfile, main.py, requirements.txt, sql/init.sql）、`docker-compose.yaml`、`.env.example`、`frontend/Dockerfile`、`.gitignore`のPythonセクションを削除（コミット`5f23c71`）。Vercelのビルドはこれらを参照していないため撤去の影響なしを確認済み（2026-07-23）。

---

## セキュリティレビュー（2026-07-23 実施 / 2026-07-28 対応完了）

全ファイル + Git履歴 + 本番Supabase設定を対象にレビューを実施。以下は指摘事項と対応状況。

**ステータス:** 🔴重大・🟡依存パッケージは対応完了。🟡セキュリティヘッダは**意図的に保留**（前提が変わったため。再評価の条件は該当セクション参照）。

### 🔴 重大：誰でもサインアップしてDBを書き換えられる → ✅ 対応完了（2026-07-28）

2つの設定の組み合わせで、anonキーを持つ第三者が全テーブルを改竄・削除できる状態。

- **RLS書き込みポリシーが緩い**（`20260707231029_enable_rls.sql`）：`FOR ALL TO authenticated USING (auth.uid() IS NOT NULL)` は「ログイン済みの誰か」を再確認しているだけで、所有者チェックが無い。ログインさえ通れば全行を書き換え・削除可能。5テーブル全部が同形。
- **本番でサインアップが開いている**：`/auth/v1/settings` を確認したところ `disable_signup: false` かつ email 有効。anonキー（公開値）を持つ第三者が任意のメアドでサインアップ→`authenticated` JWT取得→`DELETE /rest/v1/blogs` 等が可能。`mailer_autoconfirm: false`（メール確認要）は自分の受信可能なアドレスで容易に突破できるため障壁にならない。
- **背景:** アプリ側に `supabase.auth.*` の呼び出しは一切なく、投稿はSupabase管理画面（Table Editor / service_role）で運用する方針（フェーズ3判断ログ参照）。つまり一般ユーザーがサインアップ・書き込みする経路は本来不要。
- **対応（多層防御として両方実施）:**
  - [x] **サインアップ無効化:** Supabaseダッシュボードで Email のサインアップをオフ。ローカルの `config.toml` も `[auth]` / `[auth.email]` の `enable_signup` を `false` に揃えた。
  - [x] **書き込みポリシーの削除:** `20260727210411_drop_authenticated_write_policies.sql` を追加し、`authenticated can write *` 5件を `DROP POLICY IF EXISTS` で削除。読み取り専用化した。
  - [x] **既存ユーザーの確認:** サインアップを閉じても既存アカウントは残るため Authentication → Users を確認。不審なユーザーは無し。

- **設計判断:** 「特定ユーザーのみ許可」ではなく**書き込みポリシー自体を削除**する方針を採用。フェーズ3の判断（投稿はSupabase管理画面で運用）により `authenticated` の書き込み経路は誰も使っておらず、攻撃面だけを提供していたため。**`service_role` はRLSをバイパスする**ので Table Editor からの投稿・編集は従来どおり動作する。将来 `/admin` 等の管理UIを作る際に、その時点で適切なスコープのポリシーを追加する。

- **`config.toml` の反映方法:** `supabase config push` は使わず、ダッシュボードで本番を変更 + ローカルファイルを手修正とした。`config push` は `[auth]` ブロック全体を送るため、ローカル用の `site_url = "http://127.0.0.1:3000"` で**本番設定を上書きしてしまう**ため。

- **検証記録:**
  - ローカル（`supabase db reset --local`）: マイグレーション3件がエラーなく適用。`pg_policies` の残存は5件で全て `cmd = SELECT`（`public can read *`）。`pg_class.relrowsecurity` は全テーブル `t` で **RLS有効かつ書き込みポリシー不在＝デフォルト拒否**を確認。
  - 本番（`supabase db push` 後）: `supabase migration list --linked` で Local / Remote が3件とも一致。`/rest/v1/{blogs,careers,skills,certifications,hobbies}` の読み取りが全て `200`（サイト表示に影響なし）。`/auth/v1/settings` が `disable_signup: true`（レビュー時は `false`）。
  - ※ 本番への書き込みテストは、設定不備時に実データが入る恐れがあるため実施せず、非破壊の確認手段に限定した。

### 🟡 中：セキュリティヘッダ未設定 → ⏸ 保留（2026-07-28 判断、優先度を下げた）

- `frontend/vercel.json` はSPA rewriteのみ。当初は多層防御としてヘッダ追加を検討していた。
  - [ ] `Content-Security-Policy`（`script-src 'self'` / `connect-src` を自Supabase URLに限定 / `font-src`・`style-src` にGoogle Fonts）
  - [ ] `X-Content-Type-Options: nosniff` / `Referrer-Policy: strict-origin-when-cross-origin` / `X-Frame-Options: DENY`

- **保留とした理由:** この項目を🟡中としたのは、`blogs.content` が**第三者に書き込まれうる値**だった（＝上記🔴の穴が開いていた）ことが前提だった。その前提が2点で崩れたため、優先度を下げた。
  1. **注入経路が消えた:** 書き込みポリシー削除により、コンテンツを入れられるのは `service_role`（本人）のみ。第三者由来の危険なデータがDBに入らない。
  2. **そもそもXSSが成立しない:** 全テンプレートが `{{ }}` 補間で `v-html` は0件。悪意あるデータがDBにあってもHTMLとして解釈されず文字列として表示される。

- **個別ヘッダの評価:**

  | ヘッダ | 守る対象 | 現状の評価 |
  |---|---|---|
  | CSP | XSSの被害軽減 | XSSの成立経路が無い |
  | `X-Frame-Options` | クリックジャッキング | ログイン・フォーム・状態変更UIが皆無で、騙してクリックさせる価値のある操作が存在しない |
  | `nosniff` | MIMEスニッフィング | Vercelが正しいContent-Typeを返す |
  | `Referrer-Policy` | リファラ漏洩 | 外部リンクはX1件のみ |

- **追加コストがゼロではない点も判断材料にした:** CSPは設定を誤るとサイトが壊れる。最低限 `connect-src` にSupabase（漏れるとデータ取得が全滅）、`style-src`/`font-src` にGoogle Fonts（漏れるとフォント未読込）を通す必要があり、適用後の動作確認が必須。「効果が薄いのに壊すリスクだけある」状態のため急がない。

- **⚠️ 優先度を戻す条件（以下のいずれかを行う時点で再評価すること）:**
  - **`v-html` を使う** — ブログでMarkdown/HTMLをレンダリングしたくなった場合。**その瞬間にXSSの経路が開く**。最も現実的かつ要注意のトリガー
  - **アプリにログイン機能を追加する** — 認証状態を持つとセッション奪取に価値が生まれる
  - **フォーム等ユーザー入力を受け付ける** — 問い合わせフォームなど
  - **サードパーティのスクリプトを入れる** — アナリティクス、埋め込みなど
  - **書き込みポリシーを再度開ける** — 管理UI（`/admin`）を作るとき
  - 要するに「**静的な自己所有コンテンツを表示するだけ**」という現在の性質が保たれている限り、優先度は低いままでよい。

### 🟡 中〜低：依存パッケージ → ✅ 対応完了（2026-07-28）

- `npm audit` で high 1件：**immutable 5.0.0-beta.1〜5.1.7**（DoS系 2件。`sass`＝devDependencyの間接依存で、ビルド時のみ動作・攻撃入力の経路なし → 実害ほぼ無し）。
  - [x] `npm audit fix` で解消。現在 `found 0 vulnerabilities`。
- `frontend/package.json` の `dependencies` に dev相当が混入：`prettier`（→devへ）、`list`（ソース内でimport無し → 未使用）。
  - [x] `list` を削除。`import`/`require` が0件、`npm ls` でもトップレベル直下の直接依存であることを確認済み（`src/` の `list-none` はTailwindのCSSクラスで無関係）。`package.json` に `postinstall` 等のインストール時スクリプトは無く、Viteのツリーシェイキングでバンドルにも含まれていなかったため、**実リスクは無く純粋な整理目的**の削除。
  - [x] `prettier` を `devDependencies` へ移動。Viteはimportされたものしかバンドルしないため成果物への影響は無く、**依存分類の正確さのための整理**（脆弱性対応ではない）。

- **`npm audit fix` 後の確認メモ:** `brace-expansion` が 5.0.8 に上がった件は問題なし。`minimatch@10.2.5` の宣言は `"brace-expansion": "^5.0.5"` で、`^5.0.5` は「5.0.5まで」ではなく `>=5.0.5 <6.0.0` を意味するため範囲内。npm auditが表示する `<=5.0.5` 等は「脆弱なバージョンの範囲」であり依存要求範囲ではない（読み違えやすい点）。

### ✅ 問題なしと確認した項目

- **anonキーの露出（`.env.development`）:** `sb_publishable_...` は公開前提のキー。RLSが防御を担う設計で、露出自体は問題ではない。危険な `sb_secret_...` / `service_role` はコード・履歴のどこにも無し。
- **Git履歴の秘密情報:** 全blobを走査。過去にコミットされていた `.env.development` の中身は `VITE_API_URL=http://localhost:8000` のみ。削除済み `docker-compose.yaml` も `${POSTGRES_PASSWORD}` と環境変数参照で値の直書きゼロ。
- **XSS:** 全テンプレートが `{{ }}` 補間のみ。`v-html`/`innerHTML`/`eval` は1件も無し。外部リンクは `rel="noopener noreferrer"` 付き。
- **SQLインジェクション:** 全クエリがパラメータなしの `.from().select()`。ユーザー入力がクエリに入る箇所自体が無い。
- **`supabase/.temp/`:** `project-ref`・プーラーURL等を含むが `supabase/.gitignore` で除外済み。いずれもパスワードを含まない公開相当の値。

### 残作業

- **なし（今回のレビュー分は対応完了）。**
- `vercel.json` のセキュリティヘッダのみ ⏸保留。**着手条件は「🟡中：セキュリティヘッダ未設定」セクションの「優先度を戻す条件」を参照**。特に `v-html` を導入する場合は先にCSPを入れること。

### 公開リポジトリでの取り扱いについて

本リポジトリは公開のため、**脆弱性の詳細を書いたこのドキュメントは「穴を塞いでからコミットする」順序**とした。未修正の状態で攻撃手順を公開リポジトリに載せると、攻撃者の調査コストを下げてしまうため。修正完了後の記録として残す分には問題なく、対応の経緯としてむしろ有用と判断した。

なお本文中の Supabase URL / `sb_publishable_*` キーは公開前提の値（Viteがビルド時にJSへ埋め込むため本番バンドルから誰でも取得可能）であり、記載しても新たな露出は生じない。**`sb_secret_*` / `service_role` キーは全く別物**なので、ドキュメント・コミット・コマンド履歴のいずれにも記載しないこと。
