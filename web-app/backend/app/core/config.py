from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DATABASE_URL: str = "postgresql+asyncpg://postgres:secret@db:5432/postgres"
    APP_NAME: str = "Auto Repair Shop API"
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


settings = Settings()
