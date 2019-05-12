"""Module for product model."""
#standard imports
from datetime import datetime
# Third-party libraries

#middleware
from ..middlewares.base_validator import ValidationError

#utilities
from ..utilities.messages.error_messages import serialization_errors
# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db
from api.utilities.constants.constants import PRD_01

class ProductReview(BaseModel):
    """product_attribute model"""

    __tablename__ = 'review'
    
    review_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.customer_id'), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('product.product_id'), nullable=False)
    review = db.Column(db.TEXT, nullable=False) 
    rating = db.Column(db.SMALLINT, nullable=False)
    created_on = db.Column(db.DateTime,nullable=False, default=datetime.utcnow)

    @classmethod
    def get(cls, product_id):
        """get method"""
        record = cls.query.filter_by(product_id=product_id).first()
        if record:
            return record
        else:
            raise ValidationError(
            {'message': serialization_errors['not_found'].format('product with this id')}, PRD_01, 'produc_id' )

