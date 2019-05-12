from marshmallow import fields

from api.utilities.messages.error_messages import serialization_errors

from .base_schema import BaseSchema


class CustomerSchema(BaseSchema):
    """Customer model"""
    name = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('name')},
        required=True
    )
    email = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('email')},
        required=True
    )
    address_1 = fields.String()
    address_2 = fields.String()
    city = fields.String()
    region = fields.String()
    postal_code = fields.String()
    country = fields.String()
    shipping_region_id = fields.Integer()
    eve_phone = fields.String()
    mob_phone = fields.String()
    day_phone = fields.String()
    password = fields.String(load_only=True, required=True,
                             error_messages={'required': serialization_errors['field_empty'].format('email')})


class CustomerRegisterSchema(BaseSchema):
    """Customer model"""
    customer_id = fields.Integer(load_only=True)
    customer = fields.Nested(
        'CustomerSchema'
    )
    access_token = fields.String()
    expires_in = fields.String()