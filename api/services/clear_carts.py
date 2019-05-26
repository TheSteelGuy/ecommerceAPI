
from api.models import ShoppingCart
from api.models.database import db
from . import celery_scheduler


@celery_scheduler.task(name='clear_cart_after_checkout')
def clear_cart_after_checkout(cart_id):
    clear = ShoppingCart.query.filter_by(cart_id=cart_id)

    clear.delete()
    db.session.commit()

    return cart_id

