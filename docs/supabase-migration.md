# Supabase 移行ロードマップ

**ゴール:** FastAPI を廃止し、**Vercel（フロント） + Supabase（Postgres + PostgREST + RLS）** 構成へ移行する。

**現在地:** フェーズ3（フロント連携）進行中。`supabase-js` 導入・`skillStore` の疎通確認まで完了。次は残りの読み取り系store（career/hobby/certification/blog閲覧）の置換確認。

最終更新: 2026-07-15

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
- [ ] 各 store の `fetch` → supabase 呼び出しに置換（読み取り系から先に）
  - [x] skillStore（疎通確認済み）
  - [ ] careerStore / hobbyStore / certificationStore / blog閲覧 ◀ 今ここ
- [x] ~~Supabase Auth（blog投稿機能の認証）~~ → blog投稿はSupabase管理画面（Table Editor）で運用する方針に変更（判断ログ参照）。ポートフォリオアプリ側に投稿UI・認証は実装しない

## フェーズ4：旧構成の撤去 & デプロイ

- [ ] FastAPI / docker-compose 撤去、環境変数整理
- [ ] Vercel デプロイ + 環境変数設定
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
