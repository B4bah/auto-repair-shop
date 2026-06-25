from pydantic import BaseModel, Field
from datetime import date
from typing import Optional

class PersonBase(BaseModel):
    id: str = Field(..., pattern=r'^\d{11}$')
    last_name: str
    first_name: str
    middle_name: Optional[str] = None
    birth_date: Optional[date] = None
    city: Optional[str] = None
    district: Optional[str] = None
    street: Optional[str] = None
    building: Optional[str] = None
    flat_number: Optional[str] = None

class PersonCreate(PersonBase):
    pass

class PersonResponse(PersonBase):
    class Config:
        from_attributes = True  # Pydantic v2 uses from_attributes (formerly orm_mode)
