from celery import Celery

from config import AppConfig

celery_scheduler = Celery(__name__, broker=AppConfig.REDIS_URL)
celery_scheduler.conf.enable_utc = False

