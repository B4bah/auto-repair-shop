from fastapi import APIRouter
from app.api.v1.endpoints import persons, clients

router = APIRouter(prefix="/v1")
router.include_router(persons.router)
router.include_router(clients.router)
