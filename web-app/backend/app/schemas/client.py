from pydantic import BaseModel
from datetime import date
from typing import Optional


class ClientBase(BaseModel):
    person_id: str
    registration_date: Optional[date] = None


class ClientCreate(ClientBase):
    pass


class ClientResponse(BaseModel):
    id: int
    person_id: str
    registration_date: date


    class Config:
        from_attributes = True
