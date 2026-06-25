from sqlalchemy import String, Date, CHAR
from sqlalchemy.orm import Mapped, mapped_column
from datetime import date
from app.core.database import Base

class Person(Base):
    __tablename__ = "person"

    id: Mapped[str] = mapped_column(CHAR(11), primary_key=True)
    last_name: Mapped[str] = mapped_column(String(100), nullable=False)
    first_name: Mapped[str] = mapped_column(String(100), nullable=False)
    middle_name: Mapped[str] = mapped_column(String(100), nullable=True)
    birth_date: Mapped[date] = mapped_column(Date, nullable=True)
    city: Mapped[str] = mapped_column(String(100), nullable=True)
    district: Mapped[str] = mapped_column(String(100), nullable=True)
    street: Mapped[str] = mapped_column(String(255), nullable=True)
    building: Mapped[str] = mapped_column(String(20), nullable=True)
    flat_number: Mapped[str] = mapped_column(String(10), nullable=True)
