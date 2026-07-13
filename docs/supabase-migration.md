# Supabase 移行ロードマップ

**ゴール:** FastAPI を廃止し、**Vercel（フロント） + Supabase（Postgres + PostgREST + RLS）** 構成へ移行する。

**現在地:** フェーズ3（フロント連携）着手前。フェーズ2完了、次は `supabase-js` 導入。

最終更新: 2026-07-13

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

- [ ] `supabase-js` 導入 ◀ 今ここ
- [ ] 各 store の `fetch` → supabase 呼び出しに置換
- [ ] Supabase Auth（blog投稿機能の認証）

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
