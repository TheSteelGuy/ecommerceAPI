"""Module for User model."""
# System imports

# Models
from api.middlewares.base_validator import ValidationError
from api.models.base.base_model import BaseModel

# Database
from api.utilities.constants.constants import USR_05
from api.utilities.messages.error_messages import serialization_errors
from .database import db


class ShippingRegion(BaseModel):
    """Class for customer login with social"""

    __tablename__ = 'shipping_region'

    shipping_region_id = db.Column(db.Integer, primary_key=True, nullable=False)
    shipping_region = db.Column(db.String(100), nullable=False)

    def get(self, shipping_region_id):
        """
        return entries by id
        """
        customer = ShippingRegion.query.filter_by(shipping_region_id=shipping_region_id, deleted=False).first()
        if customer:
            return customer
        raise ValidationError(
            {'message': serialization_errors['not_found'].format('shipping region')}, USR_05, 'shipping_region_id'
        )

    def __repr__(self):
        return f'<ShippingRegion {self.shipping_region_id}>'


class Shipping(BaseModel):
    """Class for shipping model"""

    __tablename__ = 'shipping'

    shipping_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    shipping_type = db.Column(db.String(100), nullable=False)
    shipping_cost = db.Column(db.Numeric(10,2), nullable=False)
    shipping_region_id = db.Column(db.Integer, db.ForeignKey('shipping_region.shipping_region_id'), nullable=False)

    def get(self, shipping_id=shipping_id):
        """
        return entries by id
        """
        customer = ShippingRegion.query.filter_by(shipping_id=shipping_id, deleted=False).first()
        if customer:
            return customer
        raise ValidationError(
            {'message': serialization_errors['not_found'].format('shipping region')}, USR_05, 'shipping_region_id'
        )

    def __repr__(self):
        return f'<Shipping {self.shipping_id}>'


