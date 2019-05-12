from marshmallow import fields

from .base_schema import BaseSchema


class DepartmentSchema(BaseSchema):
    """department schema"""
    department_id = fields.Integer(dump_only=True)
    name = fields.String(
        required=True
    )
    description = fields.String()