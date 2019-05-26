"""Module for application factory."""

# Third-party libraries
from celery import Celery
from flask import Flask, jsonify
from flask_migrate import Migrate
from flask_restplus import Api
from flask_cors import CORS
from flask_caching import Cache

# Middlewares
from api import api_blueprint
from api.middlewares.base_validator import (middleware_blueprint,
                                            ValidationError)
from api.error import resource_not_found


from config import AppConfig
from api.models.database import db

from api import whooshee


celery_app = Celery(__name__, broker=AppConfig.REDIS_URL)


api = Api(api_blueprint, doc=False)
cache = Cache(
    config = {
        'CACHE_TYPE': 'redis',
        'CACHE_REDIS_URL': AppConfig.REDIS_URL
    }
)


def initialize_errorhandlers(application):
    ''' Initialize error handlers '''
    application.register_blueprint(middleware_blueprint)
    application.register_blueprint(api_blueprint)

    application.register_error_handler(404, resource_not_found)


def create_app(config=AppConfig):
    """Return app object given config object."""
    app = Flask(__name__)
    CORS(app)
    app.config.from_object(config)

    whooshee.init_app(app)

    app.url_map.strict_slashes = False

    # initialize error handlers
    initialize_errorhandlers(app)
    app.config.from_object(config)
    celery_app.conf.update(app.config)

    # bind app to db
    db.init_app(app)

    cache.init_app(app)
    # import all models
    import api.models 

    # import views
    import api.views

    # initialize migration scripts
    Migrate(app, db)

    return app


@api.errorhandler(ValidationError)
@middleware_blueprint.app_errorhandler(ValidationError)
def handle_exception(error):
    """Error handler called when a ValidationError Exception is raised"""

    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response



