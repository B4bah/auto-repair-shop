from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.dependencies.database import get_async_db
from app.schemas.person import PersonCreate, PersonResponse
from app.services import person_service

router = APIRouter(prefix="/persons", tags=["Persons"])

@router.post("/", response_model=PersonResponse, status_code=status.HTTP_201_CREATED)
async def create_person(
        person_data: PersonCreate,
        db: AsyncSession = Depends(get_async_db)
        ):
    existing = await person_service.get_person(db, person_data.id)
    if existing:
        raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Person with this ID (SNILS) already exists"
                )
    return await person_service.create_person(db, person_data)


@router.get("/{person_id}", response_model=PersonResponse)
async def get_person(
        person_id: str,
        db: AsyncSession = Depends(get_async_db)
        ):
    person = await person_service.get_person(db, person_id)
    if not person:
        raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Person not found."
                )
    return person
