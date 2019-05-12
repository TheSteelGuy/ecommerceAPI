# tests/test_customer.py

# third party imports


import json

from config import AppConfig

API_V1_BASE_URL = AppConfig.API_BASE_URL_V1


class TestAuth:
    """tests user authentication methods"""

    def test_registration(self, init_db, client,  new_test_user):
        """test registaration"""

        response = client.post(
            f'{API_V1_BASE_URL}/customer',
            data=new_test_user,
            content_type='application/x-www-form-urlencoded'
        )

        assert response.status_code, 200
        response_json = json.loads(response.data.decode('utf-8'))
        assert response_json['status'] == 'success'

    def test_login(self, init_db, client,  global_test_user):
        """test login"""

        response = client.post(
            f'{API_V1_BASE_URL}/customers/login',
            data={'email': 'global@gmail.com', 'password': 'testpwd123'},
            content_type='application/x-www-form-urlencoded'
        )

        response_json = json.loads(response.data.decode('utf-8'))
        assert response.status_code, 200
        assert response_json['customer']['email'] == 'global@gmail.com'


