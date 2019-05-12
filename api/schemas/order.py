from marshmallow import fields
from .base_schema import BaseSchema


class OrderSchema(BaseSchema):
    """order schema"""
    cart_id = fields.String()
    shipping_id = fields.Integer()
    tax_id = fields.Integer()
    customer_id = fields.Integer()
    amount = fields.Integer()