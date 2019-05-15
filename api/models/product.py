"""Module for product model."""

# Third-party libraries

#middleware
from ..middlewares.base_validator import ValidationError

#utilities
from ..utilities.messages.error_messages import serialization_errors
# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db
from api.utilities.constants.constants import PRD_01
import main



class QueryModel(BaseModel):
    """get method for product related models"""

    __abstract__ = True
    
    @classmethod
    def get(cls, product_id):
        """get method"""
        record = cls.query.filter_by(product_id=product_id).first()
        if record:
            return record
        else:
            raise ValidationError(
            {'message': serialization_errors['not_found'].format('product with this id')}, PRD_01, 'produc_id')


@main.whooshee.register_model('name', 'description')
class Product(QueryModel):
    """product model"""

    __tablename__ = 'product'

    product_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(1000), nullable=False)
    price =  db.Column(db.Numeric(10,2), nullable=False)
    discounted_price = db.Column(db.Numeric(10,2), default=0.00)
    image = db.Column(db.String(150))
    image_2 = db.Column(db.String(150))
    thumbnail = db.Column(db.String(150))
    display = db.Column(db.Integer, nullable=False, default=0)
    category_id = db.Column(db.Integer, db.ForeignKey('category.category_id'))
    department_id = db.Column(db.Integer, db.ForeignKey('department.department_id'))
    department = db.relationship('Department', lazy='joined')
    category = db.relationship('Category', lazy='joined')
    reviews = db.relationship('ProductReview', lazy='joined')




class ProductAttribute(QueryModel):
    """product_attribute model"""

    __tablename__ = 'product_attribute'

    product_id = db.Column(db.Integer, primary_key=True, nullable=False)
    attribute_value_id = db.Column(db.Integer, primary_key=True, nullable=False)
   

class ProductCategory(QueryModel):
    """model for product category basic"""

    __tablename__ = 'product_category'
    
    product_id = db.Column(db.Integer, primary_key=True, nullable=False)
    category_id = db.Column(db.Integer, db.ForeignKey('category.category_id'), nullable=False)
    category = db.relationship(
        'Category',
        lazy='joined')
    
