import os
import psycopg2
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Allow requests from your frontend (CORS)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/health")
def health_check():
    return {"status": "Backend is running!", "message": "Connected to dummy frontend"}

@app.get("/api/db-test")
def db_test():
    try:
        conn = psycopg2.connect(
            dbname=os.getenv("POSTGRES_DB", "postgres"),
            user=os.getenv("POSTGRES_USER", "postgres"),
            password=os.getenv("POSTGRES_PASSWORD", "secret"),
            host=os.getenv("DB_HOST", "db"),
            port=5432
        )
        cur = conn.cursor()
        cur.execute("SELECT 'Database is reachable!' as message;")
        result = cur.fetchone()[0]
        cur.close()
        conn.close()
        return {"db_status": result}
    except Exception as e:
        return {"db_status": f"Error: {str(e)}"}

@app.get("/api/")
def root():
    return {"message": "FastAPI SaaS backend is live"}
