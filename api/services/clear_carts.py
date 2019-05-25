import threading
from datetime import datetime, timedelta

import dramatiq

@dramatiq.actor()
def clear_cart():

    ticker = threading.Event()
    while not ticker.wait(2):
        # clear = ShoppingCart.query.filter(datetime.utcnow()-timedelta(hours=134)>ShoppingCart.added_on)
        # clear.delete()
        # db.session.commit()
        print('done, done, done')


if __name__ == '__main__':
    clear_cart.send()