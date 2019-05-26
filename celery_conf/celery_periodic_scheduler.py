

"""Configuring Celery Beat used for running periodic tasks"""

# Third Party
#from celery.schedules import crontab

# Services
from api.services import celery_scheduler

# celery_scheduler.conf.beat_schedule = {
#
#     'run-clear-carts-automatically-periodically': {
#         'task': 'clear_carts_periodically',
#         'schedule': crontab(hour=0, minute='*/1')
#     },
# }
#celery worker -A celery_worker.celery_app --loglevel=DEBUG
#celery -A celery_conf.celery_periodic_scheduler beat --loglevel=info
#./redis-cli -h localhost -p 6379 -n 0 keys \*
#./redis-cli flushdb

