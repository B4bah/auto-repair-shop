from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from fastapi import HTTPException, status

from app.models.client import Client
from app.models.person import Person
from app.schemas.client import ClientCreate

async def get_client_by_id(db: AsyncSession, client_id: int) -> Client | None:
    result = await db.execute(select(Client).where(Client.id == client_id))
    return result.scalar_one_or_none()

async def create_client(db: AsyncSession, client_data: ClientCreate) -> Client:
    person_result = await db.execute(
        select(Person).where(Person.id == client_data.person_id)
    )
    person = person_result.scalar_one_or_none()
    if not person:
        raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Person with ID '{client_data.person_id}' not found."
                )
    
    existing_result = await db.execute(
            select(Client).where(Client.person_id == client_data.person_id)
            )
    if existing_result.scalar_one_or_none():
        raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Client with person_id '{client_data.person_id}' already exists"
                )

    db_client = Client(**client_data.model_dump())
    db.add(db_client)
    await db.commit()
    await db.refresh(db_client)
    return db_client
