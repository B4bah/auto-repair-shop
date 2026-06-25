from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.person import Person
from app.schemas.person import PersonCreate


async def get_person(db: AsyncSession, person_id: str) -> Person | None:
    result = await db.execute(select(Person).where(Person.id == person_id))
    return result.scalar_one_or_none()


async def create_person(db: AsyncSession, person_data: PersonCreate) -> Person:
    db_person = Person(**person_data.model_dump())
    db.add(db_person)
    await db.commit()
    await db.refresh(db_person)
    return db_person
