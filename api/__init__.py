from flask import Blueprint
api_blueprint = Blueprint('api_blueprint', __name__, url_prefix='/api/v1')

from flask_whooshee import Whooshee
whooshee = Whooshee()



