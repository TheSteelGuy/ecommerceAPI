"""Module for token validation"""

# Standard library
from functools import wraps

#Third party
from flask import request
import jwt

#Utilities
from api.utilities.messages.error_messages import jwt_errors

# app config
from config import AppConfig

from api.utilities.constants.constants import AUT_01, AUT_02


def get_token(http_request=request):
    """Get token from request object

    Args:
        http_request (HTTPRequest): Http request object

    Returns:
        token (string): Token string

    Raises:
        ValidationError: Validation error raised when there is no token
                         or bearer keyword in authorization header
    """
    from .base_validator import ValidationError
    token = http_request.headers.get('USER-KEY')
    if not token:
        raise ValidationError({'message': jwt_errors['NO_TOKEN_MSG']}, AUT_01, 'NoAuth', 401)
    elif 'bearer' not in token.lower():
        raise ValidationError({'message': jwt_errors['NO_BEARER_MSG']}, AUT_02,'Bearer Missing', 401)
    token = token.split(' ')[-1]
    return token


def token_required(func):
    """Authentication decorator. Validates token from the client

    Args:
        func (function): Function to be decorated

    Returns:
        function: Decorated function

    Raises:
        ValidationError: Validation error
    """

    @wraps(func)
    def decorated_function(*args, **kwargs):
        from .base_validator import ValidationError

        token = get_token()
        try:
            decoded_token = jwt.decode(
                token,
                AppConfig.SECRET_KEY,
                algorithms=['HS256'])
        except (
                ValueError,
                TypeError,
                jwt.ExpiredSignatureError,
                jwt.DecodeError,
                jwt.InvalidTokenError,
                jwt.InvalidSignatureError,
                jwt.InvalidAlgorithmError
        ) as error:
            exception_mapper = {
                ValueError: ({'message': jwt_errors['SERVER_ERROR_MESSAGE']}, 500),
                TypeError: ({'message':jwt_errors['SERVER_ERROR_MESSAGE']}, 500),
                jwt.ExpiredSignatureError: ({'message':jwt_errors['EXPIRED_TOKEN_MSG']}, 401),
                jwt.DecodeError: ({'message':jwt_errors['INVALID_TOKEN_MSG']}, 401),
                jwt.InvalidTokenError: ({'message':jwt_errors['INVALID_TOKEN_MSG']}, 401),
                jwt.InvalidSignatureError: ({'message':jwt_errors['INVALID_TOKEN_MSG']}, 401),
                jwt.InvalidAlgorithmError: ({'message':jwt_errors['INVALID_TOKEN_MSG']}, 401)
            }
            
            message, status_code = exception_mapper.get(type(error), (jwt_errors['SERVER_ERROR_MESSAGE'], 500))
       
            raise ValidationError(message, AUT_01, 'authToken', status_code)

        # setting the payload to the request object and can be accessed with \
        # request.decoded_token from the view
        setattr(request, 'decoded_token', decoded_token)
        return func(*args, **kwargs)

    return decorated_function
