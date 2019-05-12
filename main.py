"""Module for application factory."""

# Third-party libraries
from flask import Flask, jsonify
from flask_migrate import Migrate
from flask_restplus import Api
from flask_cors import CORS
from flask_caching import Cache
from celery import Celery

# Middlewares
from api import api_blueprint
from api.middlewares.base_validator import (middleware_blueprint,
                                            ValidationError)
from api.error import resource_not_found
from config import AppConfig
from api.models.database import db

api = Api(api_blueprint, doc=False)

# Celery object and configures it with the broker (redis).
# __name__ is the app.name, which will be initialized later
TASK_LIST = [

]
celery_app = Celery(__name__, broker=AppConfig.REDIS_URL, include=TASK_LIST)

cache = Cache(config={
    'CACHE_TYPE': 'redis',
    'CACHE_REDIS_URL': AppConfig.REDIS_URL
})


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
    celery_app.conf.update(app.config)
    cache.init_app(app)
   
    app.url_map.strict_slashes = False

    # initialize error handlers
    initialize_errorhandlers(app)

    # bind app to db
    db.init_app(app)

    # import all models
    import api.models 

    # import views
    import api.views

    # register celery tasks
    import celery_conf.tasks

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
