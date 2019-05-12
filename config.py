"""Application configuration module."""

import sys

from os import getenv, urandom
from pathlib import Path  # python3 only

from dotenv import load_dotenv

env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path, verbose=True)


class Config(object):
    """App base configuration."""

    SQLALCHEMY_DATABASE_URI = getenv(
        'DATABASE_URI', default='mysql://localhost/ecomm')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    DEBUG = False
    TESTING = False
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USERNAME = getenv('FLASK_MAIL_USERNAME')
    MAIL_DEFAULT_SENDER = getenv('FLASK_MAIL_USERNAME')
    MAIL_PASSWORD = getenv('FLASK_MAIL_PASSWORD')
    MAIL_USE_TLS = True
    API_BASE_URL_V1 = getenv('API_BASE_URL_V1')
    BUGSNAG_API_KEY = getenv('BUGSNAG_API_KEY')
    SECRET_KEY = urandom(24)
    ITEMS_PER_PAGE = 20

    # Celery configuration
    REDIS_URL = getenv('REDIS_URL', default='redis://localhost:6379/0')
    CELERYD_POOL_RESTARTS = True
    CELERY_BROKER_URL = getenv(
        'CELERY_BROKER_URL', default='redis://localhost:6379/0')
    CELERY_RESULT_BACKEND = getenv(
        'CELERY_RESULT_BACKEND', default='redis://localhost:6379/0')

    # Mail configuration
    ECOMM_MAIL_USERNAME = getenv('ECOMM_MAIL_USERNAME')
    MAILGUN_SENDER = getenv('MAILGUN_SENDER')
    MAILGUN_API_KEY = getenv('MAILGUN_API_KEY')
    MAILGUN_DOMAIN_NAME = getenv('MAILGUN_DOMAIN_NAME')
    MAIL_SERVICE = getenv('MAIL_SERVICE', 'mailgun')


    # FLASK_ENV Configuration
    FLASK_ENV = getenv('FLASK_ENV')


class ProductionConfig(Config):
    """App production configuration."""

    AUTH_URL = getenv('AUTH_URL_PROD')
    BUGSNAG_API_KEY = getenv('BUGSNAG_KEY_PROD')


class DevelopmentConfig(Config):
    """App development configuration."""

    DEBUG = True


class StagingConfig(Config):
    """App staging configuration."""

    AUTH_URL = getenv('AUTH_URL_STAGING')


class TestingConfig(Config):
    """App testing configuration."""

    TESTING = True

    SQLALCHEMY_DATABASE_URI = getenv(
        'TEST_DATABASE_URI')
    FLASK_ENV = 'testing'

    AUTH_URL = getenv('AUTH_URL_STAGING', '')


config = {
    'development': DevelopmentConfig,
    'staging': StagingConfig,
    'production': ProductionConfig,
    'testing': TestingConfig
}

AppConfig = TestingConfig if 'pytest' in sys.modules else config.get(
    getenv('FLASK_ENV'), 'development')
