from flask import jsonify

from api.utilities.constants.constants import USR_02
from api.utilities.messages.error_messages import serialization_errors


def resource_not_found(error):
    """resource not found"""
    response = jsonify({
        "error": {
            "status": 404,
            "code": USR_02,
            "message": serialization_errors['not_found'].format('the url entered'),
            "field": "invalid url"
        }
    })

    response.status_code = 404
    return response
