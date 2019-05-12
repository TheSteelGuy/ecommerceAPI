# tests/test_user.py

import json


from config import AppConfig

API_V1_BASE_URL = AppConfig.API_BASE_URL_V1


class TestProducts:
    """tests products endpoints"""

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

        response = client.post(
            f'{API_V1_BASE_URL}/shoppingcart/add',
            data=add_item_to_cart,
            content_type='application/x-www-form-urlencoded'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert response_json[0]['attributes'] == 'red'
        assert response_json[0]['sub_total'] == '300.0'



