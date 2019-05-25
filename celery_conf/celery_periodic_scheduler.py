

"""Configuring Celery Beat used for running periodic tasks"""

# Third Party
from celery.schedules import crontab

# Services
from api.services import celery_scheduler

celery_scheduler.conf.beat_schedule = {

    'run-clear-carts-automatically-periodically': {
        'task': 'clear_carts_periodically',
        'schedule': crontab(hour=0, minute=1)
    },
}
