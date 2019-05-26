"""Module with application entry point."""
from datetime import datetime, timedelta

# Third party Imports

from flask import jsonify
from flask_mail import Mail


from main import create_app, celery_app
from config import AppConfig


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


def celery_task_state(*args, **kwargs):
    """Function to get statistics about celery-beat scheduled tasks

        Args:
            *args: Variable length argument list and the mandatory position arguments for this list are:
                task (instance): an instance of python Shelve class
                task_name (str): Task name
                ok_tasks (dict): A python dictionary holding celery-beat tasks that run successfully
                down_tasks (dict): A python dictionary holding celery-beat tasks that didn't run successfully

            **kwargs: Variable length keyword argument dictionary and the mandatory keys for this dictionary are:
                is_cron_task (bool): True if the scheduled task is a cron job task otherwise False.
        """
    now = datetime.now()
    task, task_name, ok_tasks, down_tasks = args
    is_cron_task = kwargs.get('is_cron_task', True)
    next_run = now + task.schedule.remaining_estimate(task.last_run_at)

    if_condition = timedelta() < task.schedule.remaining_estimate(
        task.last_run_at
    ) if is_cron_task else now < task.last_run_at + task.schedule.run_every

    if if_condition:
        ok_tasks[task_name] = {
            'status': 'Okay',
            'last_run': task.last_run_at,
            'next run': next_run
        }
        return
    down_tasks[task_name] = {
        'status': 'Down',
        'last_run': task.last_run_at,
        'missed run': next_run
    }


@app.route('/celery-beat/health')
def celery_beat_stats():
    """Checks tasks scheduled by celery-beat."""

    import shelve

    down_tasks = {}
    ok_tasks = {}

    file_data = shelve.open(
        'celerybeat-schedule'
    )  # Name of the file used by PersistentScheduler to store the last run times of periodic tasks.

    entries = file_data.get('entries')

    if not entries:
        return jsonify(dict(error="celery-beat service not available")), 503

    for task_name, task in entries.items():

        try:
            celery_task_state(
                task, task_name, ok_tasks, down_tasks, is_cron_task=False)

        except AttributeError:

            celery_task_state(task, task_name, ok_tasks, down_tasks)

    if down_tasks:
        return jsonify(dict(message={
            'Down tasks': down_tasks,
        })), 503

    return jsonify(dict(message={'Okay tasks': ok_tasks})), 200


if __name__ == '__main__':
    app.run()

