"""Module for customer model."""

# Third-party libraries
from sqlalchemy.event import listens_for
from werkzeug.security import generate_password_hash, check_password_hash

#middleware
from api.utilities.constants.constants import USR_05, USR_01
from ..middlewares.base_validator import ValidationError

#utilities
from ..utilities.messages.error_messages import serialization_errors
# Models
from api.models.base.base_model import BaseModel

# Database
from .database import db


class Customer(BaseModel):
    """Class for customer model."""

    __tablename__ = 'customer'
    
    customer_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False, unique=True)
    password = db.Column(db.String(200))
    credit_card = db.Column(db.Text)
    address_1 = db.Column(db.String(100))
    address_2 = db.Column(db.String(100))
    city = db.Column(db.String(100))
    region = db.Column(db.String(100))
    postal_code = db.Column(db.String(60))
    country = db.Column(db.String(100))
    shipping_region_id = db.Column(db.Integer, db.ForeignKey('shipping_region.shipping_region_id'),default=1, nullable=False)
    day_phone = db.Column(db.String(100))
    eve_phone = db.Column(db.String(100))
    mob_phone = db.Column(db.String(100))
    
    

    @staticmethod
    def get(email):
        """
        return entries by email
        """
        customer = Customer.query.filter_by(email=email, deleted=False).first()
        if customer:
            return customer
        raise ValidationError(
            {'message': serialization_errors['not_found'].format('email')}, USR_05
        )

    @staticmethod
    def check_password(password_hash, password):
        """check password against password hash"""
       
        if check_password_hash(password_hash, password):
            return 
        raise ValidationError({'message': 'wrong email or password'}, USR_01, 'email or password')

    def __repr__(self):
        return f'<Customer {self.name}>'


@listens_for(Customer, "before_insert")
def before_insert(mapper, connect, target):
    """ 
    Event to hash the password
    Args:
        mapper (obj): The current model class
        connect (obj): The current database connection
        target (obj): The current model instance
    Returns:
        None
    """
    target.password = generate_password_hash(target.password)
