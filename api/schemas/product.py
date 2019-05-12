from marshmallow import fields
from .base_schema import BaseSchema


class ProductSchema(BaseSchema):
    """product schema"""
    product_id = fields.Integer()
    name = fields.String()
    description = fields.String()
    price =  fields.String()
    discounted_price = fields.String()
    image = fields.String()
    image_2 = fields.String()
    thumbnail = fields.String()
    display = fields.Integer()


class ProductCategorySchema(BaseSchema):
    """Product complete schema"""

    product_id = fields.Integer()
    category_id = fields.Integer()
    name = fields.String()
   

class ProductDetail(BaseSchema):
    """product detail schema"""

    image = fields.String()
    image_2 = fields.String()

    