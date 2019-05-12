"""Module for department model."""

# Third-party libraries

# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db


class Department(BaseModel):
    """Departments model"""

    __tablename__ = 'department'

    department_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    name = db.Column(db.String(100))
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
        return cls.query.filter_by(department_id=id).first()

