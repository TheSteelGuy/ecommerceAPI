"""Module for cart model."""
import datetime

# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db

from sqlalchemy.orm import relationship


class ShoppingCart(BaseModel):
    """cart model"""

    __tablename__ = 'shopping_cart'

    item_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    cart_id = db.Column(db.String(100), nullable=False)
    product_id = db.Column(db.Integer, db.ForeignKey('product.product_id'))
    attributes = db.Column(db.String(1000), nullable=False)
    quantity = db.Column(db.Integer, nullable=False, default=1)
    buy_now = db.Column(db.Boolean, default=True, nullable=False)
    added_on = db.Column(db.DateTime, nullable=False, default=datetime.datetime.utcnow())

    product = relationship("Product", lazy="joined")


def group_products(product_list, cart_list):

    for item in product_list:
        
        similar_item_dict = dict(
            item_id=item.item_id,
            name=item.product.name,
            attributes=item.attributes,
            product_id=item.product.product_id,
            image=item.product.image,
            price=str(item.product.price),
            quantity=item.quantity,
            sub_total=str(round(eval(str(item.product.price)) * item.quantity, 2))
        )
        if similar_item_dict not in cart_list:
            cart_list.append(similar_item_dict)
        continue


def update_cart_item(item_dict, quantity):
        """updates the quantity of a item in cart"""
        item_raw_list = [
            item_dict for i in range(1, quantity)
        ]
        return item_raw_list




       


