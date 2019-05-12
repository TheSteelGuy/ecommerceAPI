"""Module for order model."""

# Models
from api.models.base.base_model import BaseModel

# Database
from api.models.database import db


class Order(BaseModel):
    """order model"""

    __tablename__ = 'orders'

    order_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    total_amount = db.Column(db.Float(10, 2), default=0.00)
    created_on = db.Column(db.DateTime, nullable=False)
    shipped_on = db.Column(db.DateTime)
    status = db.Column(db.Integer, default=0, nullable=False)
    comments = db.Column(db.String(255))
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.customer_id'))
    auth_code = db.Column(db.String(50))
    reference = db.Column(db.String(60))
    shipping_id = db.Column(db.Integer, db.ForeignKey('shipping.shipping_id'))
    tax_id = db.Column(db.Integer, db.ForeignKey('tax.tax_id'))

    def __repr__(self):
        return f'<Order {self.total_amount}>'


class OrderDetail(BaseModel):
    """order model"""

    __tablename__ = 'order_detail'

    item_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    order_id = db.Column(db.Integer, db.ForeignKey('orders.order_id'), nullable=False)
    product_id = db.Column(db.Integer, nullable=False)
    attributes = db.Column(db.String(1000), nullable=False)
    product_name = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    unit_cost = db.Column(db.Float(10, 2), nullable=False)

    def __repr__(self):
        return f'<Order {self.id}>'
