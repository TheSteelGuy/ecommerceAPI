"""Module for Validation error and error handler"""

from flask import Blueprint

middleware_blueprint = Blueprint('middleware', __name__)


class ValidationError(Exception):
    """Base Validation class for handling validation errors"""

    def __init__(self, error, code, field=None, status_code=None):
   
        Exception.__init__(self)
        self.status_code = 400
        self.error = error
        self.error['status'] = self.status_code
        self.error['code'] = code
        self.error['message'] = error['message']
        

        if status_code is not None:
            self.error['status'] = status_code
            self.status_code = status_code
        if field:
            self.error['field'] = field

    def to_dict(self):
        
        return {'error':self.error}


