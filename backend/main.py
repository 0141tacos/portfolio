import os
from contextlib import contextmanager

import psycopg2
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from psycopg2 import pool

app = FastAPI()

# CORSの設定
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],  # Vue.jsのURL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# アプリ起動時にコネクションプールを作成
connection_pool = pool.ThreadedConnectionPool(
    minconn=1,
    maxconn=10,
    host="db",
    dsn=os.getenv("DATABASE_URL"),
)


@contextmanager
def get_cursor():
    conn = connection_pool.getconn()  # コネクションプールからコネクションを1つ取得する
    try:
        cursor = conn.cursor()
        yield cursor
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        cursor.close()
        connection_pool.putconn(conn)  # コネクションプールにコネクションを戻す


@app.get("/")
def read_root():
    return {"message": "Hello World"}


# careersテーブルから全ての情報を取得する
@app.get("/careers")
def read_careers():
    sql = """
        SELECT
            id,
            TO_CHAR(period_from, 'YYYY/FMMM') as period_from,
            TO_CHAR(period_to, 'YYYY/FMMM') as period_to,
            position
        FROM careers
        """
    try:
        with get_cursor() as cursor:
            cursor.execute(sql)
            rows = cursor.fetchall()
            # 以下はリスト内包表記で短く記載している
            columns = [desc[0] for desc in cursor.description]
            return [dict(zip(columns, row)) for row in rows]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
