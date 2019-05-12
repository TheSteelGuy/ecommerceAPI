"""Module for setting up fixtures for testing"""
# pylint: skip-file
from os import environ

# Third-party libraries
import pytest


# Local imports
from main import create_app
from config import AppConfig

# Models
from api.models import (Customer, ShippingRegion, Product, Department, Category)

# Database
from api.models.database import db




environ['FLASK_ENV'] = 'testing'


@pytest.yield_fixture(scope='session')
def app():
    """
     Setup flask test app.
    :return: Flask app
    """

    _app = create_app(AppConfig)

    # Establish an application context before running the tests.
    ctx = _app.app_context()
    ctx.push()

    yield _app

    ctx.pop()


@pytest.fixture(scope='function')
def client(app):
    """
    Setup an app client, this gets executed for each test function.
    :param app: Pytest fixture
    :return: Flask app client
    """
    yield app.test_client()


@pytest.fixture(scope='module')
def init_db(app):
    db.drop_all()
    db.create_all()
    yield db
    db.session.close()
    db.drop_all()


@pytest.fixture(scope='function')
def shipping_region(init_db):
    shipping = {
        'deleted': 0,
        'shipping_region': 'test region',
    }

    return ShippingRegion(**shipping)


@pytest.fixture(scope='function')
def new_test_user(init_db, shipping_region):
    shipping = shipping_region.save()
    user = {
        'name': 'Jane',
        'email': 'test@email.com',
        'password': 'testpwd123',
        'shipping_region_id': shipping.shipping_region_id
    }

    return user


@pytest.fixture(scope='function')
def global_test_user(init_db, shipping_region):
    shipping = shipping_region.save()

    user = {
        'name': 'global',
        'email': 'global@gmail.com',
        'password': 'testpwd123',
        'shipping_region_id': shipping.shipping_region_id
    }
    obj = Customer(**user)
    obj.save()
    return obj


@pytest.fixture(scope='function')
def department_save(init_db):
    department = {
        'name': 'Nature',
        'description': 'some desc',

    }
    obj = Department(**department)
    depart = obj.save()
    return depart


@pytest.fixture(scope='function')
def category_save(init_db, department_save):
    category = {
        'department_id': department_save.department_id,
        'name': 'Nature',
        'description': 'some desc',

    }
    obj = Category(**category)
    cat = obj.save()
    return cat


@pytest.fixture(scope='function')
def products_save(init_db, category_save):
    product = {
        'name': 'Jane',
        'description': 'some random description',
        'price': 200,
        'discounted_price': '194',
        'image': 'url',
        'image_2': 'url',
        'thumbnail': 'thumbnail',
        'category_id': category_save.category_id,
        'department_id': category_save.department_id

    }
    for item in range(1, 3):
        obj = Product(**product)
        obj.save()
    return


@pytest.fixture(scope='function')
def single_product_save(init_db, category_save):
    product = {
        'name': 'Jane',
        'description': 'Good product',
        'price': 300,
        'discounted_price': '194',
        'image': 'url',
        'image_2': 'url',
        'thumbnail': 'thumbnail',
        'category_id': category_save.category_id,
        'department_id': category_save.department_id

    }

    obj = Product(**product)
    obj.save()
    return obj


@pytest.fixture(scope='function')
def add_item_to_cart(init_db, single_product_save):
    cart_dict = dict(
        attributes='red',
        product_id=single_product_save.product_id,
        cart_id='06ddc3da-6076-48e8-a183-6a29cf12b87'
    )

    return cart_dict
