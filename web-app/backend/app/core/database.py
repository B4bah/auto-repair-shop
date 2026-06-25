from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker, AsyncSession
from sqlalchemy.orm import declarative_base
from app.core.config import settings

# Create engine with asyncpg driver
engine = create_async_engine(
        settings.DATABASE_URL,
        echo=True,
        future=True
)

# Session factory
AsyncSessionLocal = async_sessionmaker(
        engine,
        class_=AsyncSession,
        expire_on_commit=False,
        autocommit=False,
        autoflush=False
)

Base = declarative_base()

async def get_async_db() -> AsyncSession:
    """
    FastAPI Dependency: Provides an async database session
    """
    async with AsyncSessionLocal() as session:
        yield session
        await session.commit()
