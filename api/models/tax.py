"""Module for tax model."""

# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db


class Tax(BaseModel):
    """Class for tax model"""

    __tablename__ = 'tax'

    tax_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    tax_type = db.Column(db.String(100), nullable=False)
    tax_percentage = db.Column(db.Numeric(10, 2), nullable=False)

    def __repr__(self):
        return f'<Tax {self.tax_type}>'
