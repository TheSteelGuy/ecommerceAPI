"""Module with application entry point."""

# Third party Imports
import click

from flask import jsonify
from redis.exceptions import ConnectionError
from flask_mail import Mail

from main import create_app
from config import AppConfig

from main import celery_app


# create application object
app = create_app(AppConfig)
mail = Mail(app)


@app.route('/')
def index():
    """index url"""
    return jsonify(dict(message='resource does not exist'))


@app.route('/celery/health')
def celery_stats():
    """Checks tasks queued by celery.

    if celery is up the response should have `sample_scheduler` task
    """

    msg = None

    ins = celery_app.control.inspect()

    try:
        tasks = ins.registered_tasks()
        msg = {"tasks": tasks, "status": "Celery up"}
    except ConnectionError:
        msg = {"status": "Redis server down"}
    except Exception:
        msg = {"status": "Celery down"}

    return jsonify(dict(message=msg)), 200


if __name__ == '__main__':
    app.run()
