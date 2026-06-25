from contextlib import asynccontextmanager
from fastapi import FastAPI

from app.api.v1.router import router as v1_router
from app.core.database import engine, Base

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: Create tables (optional, you already have them from init-db)
    # async with engine.begin() as conn:
    #     await conn.run_sync(Base.metadata.create_all)
    yield
    # Shutdown: dispose engine
    await engine.dispose()


app = FastAPI(
        title="Auto Repair Shop API",
        version="1.0.0",
        lifespan=lifespan
        )


app.include_router(v1_router, prefix="/api")
