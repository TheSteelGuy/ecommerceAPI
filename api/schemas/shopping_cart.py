from marshmallow import fields
from .base_schema import BaseSchema
from api.utilities.messages.error_messages import serialization_errors


class ShoppingCartSchema(BaseSchema):
    """Shopping cart schema"""
    item_id = fields.Integer(dump_only=True)
    cart_id = fields.String(required=True, error_messages={'required': serialization_errors['field_empty'].format('cart_id')})
    product_id = fields.Integer(required=True, error_messages={'required': serialization_errors['field_empty'].format('product_id')})
    attributes = fields.String(required=True, error_messages={'required': serialization_errors['field_empty'].format('attributes')})
    quantity = fields.Integer()
    buy_now  = fields.String()
    added_on = fields.String()
 