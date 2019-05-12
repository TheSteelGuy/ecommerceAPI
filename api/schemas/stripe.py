from marshmallow import fields
from .base_schema import BaseSchema
from api.utilities.messages.error_messages import serialization_errors


class StripeSchema(BaseSchema):
    """Shopping cart schema"""
    stripeToken = fields.String(required=True,
                                error_messages={'required': serialization_errors['field_empty'].format('stripe_token')})
    order_id = fields.Integer(required=True,
                              error_messages={'required': serialization_errors['field_empty'].format('order_id')})
    description = fields.String(required=True,
                                error_messages={'required': serialization_errors['field_empty'].format('description')})
    amount = fields.Integer(required=True,
                               error_messages={'required': serialization_errors['field_empty'].format('amount')})
    currency = fields.String()

