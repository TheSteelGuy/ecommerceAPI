from marshmallow import fields
from .base_schema import BaseSchema
from api.utilities.messages.error_messages import serialization_errors

class ReviewSchema(BaseSchema):
    """Review schema"""
    review_id = fields.String(dump_only=True)
    customer_id = fields.String()
    product_id = fields.Integer(required=True, error_messages={'required': serialization_errors['field_empty'].format('product_id')})
    review = fields.String(required=True, error_messages={'required': serialization_errors['field_empty'].format('review')})
    rating = fields.Integer(required=True, error_messages={'required': serialization_errors['field_empty'].format('rating')})
    created_on = fields.String()

