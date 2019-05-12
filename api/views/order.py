from flask_restplus import Resource
from flask import jsonify, request

from api.schemas.order import OrderSchema
from api.models import Order
from api.utilities.paginate_helper import (
    paginator, validate_pagination_args,
    order_by_ascending_or_descending,
    truncate_description)

from api.utilities.constants.constants import CAT_02

from main import api

order_schema = OrderSchema(exclude=['deleted'])



@api.route('/orders')
class OrderResource(Resource):
    """Resource for category"""
    def get(self):
        pass