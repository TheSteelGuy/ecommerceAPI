from flask import request
from flask_restplus import Resource
from flask import jsonify

from api.middlewares.base_validator import ValidationError
from api.schemas.customer import CustomerSchema
from api.utilities.constants.constants import USR_02, USR_04
from api.utilities.messages.error_messages import serialization_errors

from main import api
from api.models.customer import Customer
from api.middlewares.generate_token import token_generator
from api.middlewares.token_required import token_required

customer_schema = CustomerSchema(exclude=['deleted'])


@api.route('/customer')
class CustomerResource(Resource):
    """Resource class for customers"""

    def post(self):
        # Deserialize, validate response data
        request_data = request.form
      
        user_data, error = customer_schema.load_object_into_schema(request_data)

        if error:
            raise ValidationError(
                {'message': serialization_errors['field_empty'].format(error[0])}, USR_02, error[0])

        # check if user already exist or add the new user data to the database
        email = user_data.get('email')
        customer_instance = Customer.find_or_create(user_data, email, 'login')

        token = token_generator(customer_instance.customer_id)
    
        customer_data = customer_schema.dump(customer_instance).data

        response = jsonify(
            {'status': 'success', 'customer': customer_data, 'access_token': token.decode(), 'expires_in': '24h'}
        )
        response.status_code = 200
        return response

    @token_required
    def get(self):
        """get customer by id"""
        user_id = request.decoded_token['sub']

        customer = Customer.query.filter_by(customer_id=user_id).first()
        customer_data = customer_schema.dump(customer).data
        response = jsonify(
            {'status': 'success', 'customer': customer_data}
        )
        response.status_code = 200
        return response


@api.route('/customers/login')
class CustomerLogin(Resource):
    """customer login endpoint"""
    def post(self):

        request_data = request.form
        schema = CustomerSchema(exclude=['deleted', 'name'])
        user_data, error_tuple = schema.load_object_into_schema(request_data)

        email = user_data.get('email')
        password = user_data.get('password')
        customer = Customer.get(email)
        password_hash = customer.password
        Customer.check_password(password_hash, password)

        token = token_generator(customer.customer_id)
        customer_data = customer_schema.dump(customer).data
        response = jsonify(
            {'status': 'success', 'customer': customer_data, 'access_token': token.decode(), 'expires_in': '24h'}
        )
        response.status_code = 200
        return response


