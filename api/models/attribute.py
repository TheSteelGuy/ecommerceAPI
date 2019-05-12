
#utilities

# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db


class Attribute(BaseModel):
    """category model"""

    __tablename__ = 'attribute'
    attribute_id = db.Column(db.Integer, autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(100), nullable=False)


class AttributeValue(BaseModel):
    """category model"""

    __tablename__ = 'attribute_value'

    attribute_value_id = db.Column(db.Integer, autoincrement=True, primary_key=True, nullable=False)
    attribute_id = db.Column(db.Integer, db.ForeignKey('attribute.attribute_id'), nullable=False) #attribute value id
    value = db.Column(db.String(100), nullable=False)