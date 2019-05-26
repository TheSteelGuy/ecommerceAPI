from marshmallow import fields

from api.utilities.messages.error_messages import serialization_errors
from .base_schema import BaseSchema


class OrderSchema(BaseSchema):
    """order schema"""
    cart_id = fields.String(
        required=True, error_messages={'required': serialization_errors['field_empty'].format('cart_id')})
    shipping_id = fields.Integer(
        required=True, error_messages={'required': serialization_errors['field_empty'].format('shipping_id')})
    tax_id = fields.Integer(
        required=True, error_messages={'required': serialization_errors['field_empty'].format('tax_id')})
    customer_id = fields.Integer()
    amount = fields.Integer()