from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.dependencies.database import get_async_db
from app.schemas.client import ClientCreate, ClientResponse
from app.services import client_service

router = APIRouter(prefix="/client", tags=["Clients"])


@router.post("/", response_model=ClientResponse, status_code=status.HTTP_201_CREATED)
async def create_client(
        client_data: ClientCreate,
        db: AsyncSession = Depends(get_async_db)
        ):
    return await client_service.create_client(db, client_data)


@router.get("/{client_id}", response_model=ClientResponse)
async def get_client(
        client_id: int,
        db: AsyncSession = Depends(get_async_db)
        ):
    client = await client_service.get_client_by_id(db, client_id)
    if not client:
        raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Client not found."
                )
    return client
