"""Module for category model."""

# Third-party libraries

#middleware
from ..middlewares.base_validator import ValidationError

#utilities
from ..utilities.messages.error_messages import serialization_errors
# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db

class Category(BaseModel):
    """category model"""

    __tablename__ = 'category'

    category_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    department_id = db.Column(db.Integer, db.ForeignKey('department.department_id'), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(1000))
    products = db.relationship(
        'Product',
        lazy='dynamic'
    )

    @classmethod
    def get(cls, id):
        """
        return entries by id
        """
        return cls.query.filter_by(category_id=id).first()
        

