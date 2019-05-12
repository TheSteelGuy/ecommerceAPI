# tests/test_user.py

import json


from config import AppConfig

API_V1_BASE_URL = AppConfig.API_BASE_URL_V1


class TestProducts:
    """tests products endpoints"""

    def test_get_all_products(self, init_db, client, products_save):
        """test fetch products"""

        response = client.get(
            f'{API_V1_BASE_URL}/products'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert response_json['count'] == 2
        assert response_json['rows'][0]['description'] == 'some random description'

    def test_get_single_product(self, init_db, client, products_save):
        """test fetch product by id"""

        response = client.get(
            f'{API_V1_BASE_URL}/products/1'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))

        assert response_json['rows']['description'] == 'some random description'




