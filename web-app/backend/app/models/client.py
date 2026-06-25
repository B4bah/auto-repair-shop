from sqlalchemy import Integer, CHAR, Date, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column
from datetime import date
from app.core.database import Base


class Client(Base):
    __tablename__ = "client"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    person_id: Mapped[str] = mapped_column(
            CHAR(11),
            ForeignKey("person.id", ondelete="CASCADE"),
            unique=True,
            nullable=False
            )
    registration_date: Mapped[date] = mapped_column(
            Date,
            server_default="CURRENT_DATE",
            nullable=False
            )
