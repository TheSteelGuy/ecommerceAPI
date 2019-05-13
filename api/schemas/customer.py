from marshmallow import fields

from api.utilities.messages.error_messages import serialization_errors

from .base_schema import BaseSchema


class CustomerSchema(BaseSchema):
    """Customer schema"""
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


class CustomerAddressSchema(BaseSchema):
    """Address schemal"""
    address_2 = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('address_2')},
        required=True
    )
    address_2 = fields.String()
    city = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('city')},
        required=True
    )
    region = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('reqion')},
        required=True
    )
    postal_code = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('postal code')},
        required=True
    )
    country = fields.String(
        error_messages={'required': serialization_errors['field_empty'].format('country')},
        required=True
    )
    shipping_region_id = fields.Integer(
        error_messages={'required': serialization_errors['field_empty'].format('shipping region id')},
        required=True
    )


