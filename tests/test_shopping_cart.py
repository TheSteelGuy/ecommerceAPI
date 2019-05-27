# tests/test_user.py

import json

from api.models import ShoppingCart
from config import AppConfig

API_V1_BASE_URL = AppConfig.API_BASE_URL_V1


class TestShoppingCart:
    """tests shopping cart endpoints"""

    def test_generate_unique_id(self, init_db, client, products_save):
        """test generate cart id"""

        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/generateUniqueId'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert response_json['status'] == 'success'

    def test_add_item_to_cart(self, init_db, client, add_item_to_cart):
        """test add product to cart"""
        for i in range(1, 4):
            response = client.post(
                f'{API_V1_BASE_URL}/shoppingcart/add',
                data=add_item_to_cart,
                content_type='application/x-www-form-urlencoded'
            )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert response_json[0]['attributes'] == 'red'
        assert response_json[0]['sub_total'] == '900.0'
        assert response_json[0]['quantity'] == 3

    def test_get_items_in_a_cart_succeeds(self, init_db, client, add_many_items_to_cart):
        """test getting items in a cart succeeds"""

        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/06ddc3da-6076-48e8-a183-6a29cf12b87'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert len(response_json[0]) == 4
        assert 'Product y' == response_json[0][0]['name']

    def test_get_items_in_a_cart_with_invalid_cart_id_returns_empty_list(
            self, init_db, client, add_many_items_to_cart):
        """test generate cart id"""

        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/06ddc3da-6076'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert len(response_json[0]) == 0

    def test_save_items_for_later_succeeds(self, init_db, client, add_item_to_cart):
        """test save items for later succeeds"""

        cart = ShoppingCart(**add_item_to_cart)
        cart.save()
        assert len(ShoppingCart.query.all()) > 0
        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/saveForLater/1'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert len(response_json) == 0

    def test_get_saved_items_for_later_succeeds(self, init_db, client, add_item_to_cart):
        """test get items saved for later succeeds"""

        cart = ShoppingCart(**add_item_to_cart)
        cart.save()
        client.get(
            f'{API_V1_BASE_URL}/shoppingcart/saveForLater/1'
        )
        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/getSaved/06ddc3da-6076-48e8-a183-6a29cf12b87'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert response_json[0]['attributes'] == 'red'
        assert response_json[0]['item_id'] == 1
        assert response_json[0]['name'] == 'Product p'

    def test_remove_item_from_cart_succeeds(self, app,init_db, client, add_item_to_cart):
        """test save items for later succeeds"""

        cart = ShoppingCart(**add_item_to_cart)
        cart.save()
        assert len(ShoppingCart.query.all()) == 1
        assert ShoppingCart.query.first().item_id == 1

        response = client.delete(
            f'{API_V1_BASE_URL}/shoppingcart/removeProduct/1'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert len(response_json) == 0

    def test_total_amount_by_cart_succeeds(self, init_db, client, add_many_items_to_cart):
        """test get total amount by cart succeeds"""

        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/totalAmount/06ddc3da-6076-48e8-a183-6a29cf12b87'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert response_json['total_amount'] == 740.9

    def test_total_amount_by_cart_not_existing_returns_empty_array(self, init_db, client, add_many_items_to_cart):
        """test for non existing cart"""

        response = client.get(
            f'{API_V1_BASE_URL}/shoppingcart/totalAmount/odjgnjng-jneneneje'
        )

        response_json = json.loads(response.data.decode('utf-8'))
        assert response_json == []

    def test_empty_cart_succeeds(self, app, init_db, client, add_many_items_to_cart):
        """test emptying cart succeeds"""

        assert len(ShoppingCart.query.filter_by(cart_id='06ddc3da-6076-48e8-a183-6a29cf12b87').all()) == 4

        response = client.delete(
            f'{API_V1_BASE_URL}/shoppingcart/empty/06ddc3da-6076-48e8-a183-6a29cf12b87'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert len(response_json) == 0

    def test_update_cart_succeeds(self, app, init_db, client, add_item_to_cart):
        """test update item in a cart succeeds"""
        item = ShoppingCart(**add_item_to_cart)
        item.save()

        assert ShoppingCart.query.filter_by(item_id=item.item_id).first().quantity == 1

        response = client.put(
            f'{API_V1_BASE_URL}/shoppingcart/update/{item.item_id}',
            content_type='application/x-www-form-urlencoded',
            data={'quantity': 8}
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert response_json[0]['quantity'] == 8
