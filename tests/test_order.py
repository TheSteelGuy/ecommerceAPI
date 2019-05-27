
import json

from config import AppConfig

API_V1_BASE_URL = AppConfig.API_BASE_URL_V1


class TestOrder:

    """Tests for orders"""
    def test_create_order_succeeds(
            self, app, init_db, client, global_test_user, add_many_items_to_cart, create_order):

        response = client.post(
            f'{API_V1_BASE_URL}/customers/login',
            data={'email': 'global@gmail.com', 'password': 'testpwd123'},
            content_type='application/x-www-form-urlencoded'
        )

        response_json = json.loads(response.data.decode('utf-8'))
        assert response.status_code, 200
        assert 'access_token' in response_json

        token = response_json['access_token']

        response2 = client.post(
            f'{API_V1_BASE_URL}/orders',
            data=create_order,
            content_type='application/x-www-form-urlencoded',
            headers={
                'user-key': 'Bearer '+token
            }
        )

        response_json = json.loads(response2.data.decode('utf-8'))
        assert response_json['order_id'] == 1

    def test_create_order_with_no_token_fails(
            self,  client, add_many_items_to_cart, create_order):
        """test created"""

        response = client.post(
            f'{API_V1_BASE_URL}/orders',
            data=create_order,
            content_type='application/x-www-form-urlencoded',

        )

        response_json = json.loads(response.data.decode('utf-8'))
        assert response_json['error']['message'] == 'Authorization code is empty'
        assert response.status_code == 401
