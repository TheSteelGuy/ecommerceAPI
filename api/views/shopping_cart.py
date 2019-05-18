
import uuid

from flask_restplus import Resource
from flask import jsonify, request

from api.models import ShoppingCart, Product
from api.models.database import db
from api.models.shopping_cart import group_products

from api.utilities.constants.constants import USR_05, USR_03, USR_02
from api.middlewares.base_validator import ValidationError
from api.utilities.messages.error_messages import serialization_errors
from api.utilities.constants.constants import PRD_01

from api.schemas.shopping_cart import ShoppingCartSchema

from main import api



cart_schema = ShoppingCartSchema(exclude=['deleted'])


@api.route('/shoppingcart/generateUniqueId')
class GenerateUniqueId(Resource):
    """generate unique for shoppping carts resource"""

    def get(self):
        cart_id = uuid.uuid4()

        response = jsonify(
            {'status': 'success', 'cart_id': cart_id}
        )
        return response


@api.route('/shoppingcart/add')
class ShoppingCartAdd(Resource):
    """generate unique for shopping carts resource"""

    def post(self):
        request_data = request.form

        cart_id = request_data.get('cart_id')

        cart_data, error = cart_schema.load_object_into_schema(request_data)
        if error:
            raise ValidationError(
                {'message': serialization_errors['field_empty'].format(error[0])}, PRD_01, error[0])
        item_exist = ShoppingCart.query.filter_by(
            cart_id=cart_id, product_id=cart_data.get('product_id'), attributes=cart_data.get('attributes')).first()

        if item_exist:
            item_exist.quantity += 1
            db.session.commit()
        else:
            cart = ShoppingCart(**cart_data)
            cart.save()

        cart_list = []
        products_by_cart = ShoppingCart.query.order_by(
            ShoppingCart.item_id.desc()).filter_by(cart_id=cart_id)
        product_list = products_by_cart.all()

        group_products(product_list, cart_list)

        response = jsonify(
            cart_list
        )
        return response


@api.route('/shoppingcart/<cart_id>')
class SingleShoppingCart(Resource):
    """Gets Items in a cart"""

    def get(self, cart_id):
        cart_list = []
        products_by_cart = ShoppingCart.query.order_by(
            ShoppingCart.item_id.desc()).filter_by(cart_id=cart_id)
        product_list = products_by_cart.all()

        group_products(product_list, cart_list)

        response = jsonify(
            [cart_list]
        )
        return response


@api.route('/shoppingcart/update/<item_id>')
class UptateShoppingCartItem(Resource):
    """update Item in a cart"""

    def put(self, item_id):
        quantity = request.form.get('quantity')

        if not quantity or len(quantity) == 0:
            raise ValidationError(
                {'message': serialization_errors['required']}, USR_02, 'quantity')
        cart_list = []
        try:
            int(quantity)

            item_by_id = ShoppingCart.query.filter_by(item_id=item_id).first()
            item_by_id.quantity = quantity
            db.session.commit()

            products_by_cart = ShoppingCart.query.order_by(
                ShoppingCart.item_id.desc()).filter_by(cart_id=item_by_id.cart_id)
            product_list = products_by_cart.all()

            group_products(product_list, cart_list)
            response = jsonify(
                cart_list
            )
            return response

        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('quantity')}, USR_03, 'quantity value')
        except AttributeError:
            raise ValidationError(
                {'message': serialization_errors['not_found'].format('item_id')}, USR_05, 'item_id')
        except:

            db.session.rollback()


@api.route('/shoppingcart/empty/<cart_id>')
class EmptyShoppingCart(Resource):
    """Empty cart resource Items in a cart"""

    def delete(self, cart_id):
        items_by_cart = ShoppingCart.query.filter_by(cart_id=cart_id)
        if items_by_cart:
            items_by_cart.delete()
            db.session.commit()

        response = jsonify(
            items_by_cart.all()
        )
        return response


@api.route('/shoppingcart/totalAmount/<cart_id>')
class ShoppingCartTotalAmount(Resource):
    """Get total from cart Items """

    def get(self, cart_id):
        items = db.session.query(
            Product, ShoppingCart).join(ShoppingCart,ShoppingCart.product_id == Product.product_id).filter_by(
            cart_id=cart_id, buy_now=True)
        total = 0
        for item in items:
            total += float(item.Product.price) * item.ShoppingCart.quantity
        response = jsonify(
            {'total_amount': round(total, 2)} if total>0 else []
        )
        return response


@api.route('/shoppingcart/saveForLater/<item_id>')
class ShoppingCartSaveForLater(Resource):
    """ Save Item for later """

    def get(self, item_id):
        try:
            int(item_id)
            item = ShoppingCart.query.filter_by(item_id=item_id).first()

            if item:
                item.buy_now = 0
                db.session.commit()
            response = jsonify(
                []
            )
            return response

        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('item_id in url')}, USR_03, 'url')


@api.route('/shoppingcart/getSaved/<cart_id>')
class ShoppingCartSaveForLater(Resource):
    """ Get Items saved for later """

    def get(self, cart_id):
        cart_list = []
        products_by_cart = ShoppingCart.query.order_by(
            ShoppingCart.item_id.desc()).filter_by(cart_id=cart_id, buy_now=False)
        product_list = products_by_cart.all()

        group_products(product_list, cart_list)

        response = jsonify(
            cart_list
        )
        return response


@api.route('/shoppingcart/removeProduct/<item_id>')
class ShoppingCartRemoveItem(Resource):
    """ Get Items saved for later """

    def delete(self, item_id):
        cart_list = []
        try:
            int(item_id)

            ShoppingCart.query.filter_by(item_id=item_id).delete()
            db.session.commit()

            response = jsonify(
                cart_list
            )
            return response

        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('item_id in url')}, USR_03, 'url')

