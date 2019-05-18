"""Module with application entry point."""

# Third party Imports


from flask import jsonify
from flask_mail import Mail


from main import create_app
from config import AppConfig


# create application object
app = create_app(AppConfig)
mail = Mail(app)


@app.route('/')
def index():
    """index url"""
    return jsonify(dict(message='resource does not exist'))


if __name__ == '__main__':
    app.run()

