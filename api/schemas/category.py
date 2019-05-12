from marshmallow import fields
from .base_schema import BaseSchema


class CategorySchema(BaseSchema):
    """department schema"""
    category_id = fields.String(dump_only=True)
    name = fields.String(
        required=True
    )
    description = fields.String()
    department_id = fields.Integer()