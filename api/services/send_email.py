"""Module for handling sending of emails"""


# Application instance


# Celery
from main import celery_app

from python_http_client.exceptions import (
    BadRequestsError, UnauthorizedError, UnsupportedMediaTypeError,
    ForbiddenError, PayloadTooLargeError, InternalServerError,
    GatewayTimeoutError)

# Third Party
import sendgrid
from sendgrid.helpers.mail import Email, Mail, Personalization

# App AppConfig
from config import AppConfig

SENDGRID_CLIENT = sendgrid.SendGridAPIClient(AppConfig.SENDGRID_API_KEY)
DEFAULT_SENDER = Email(AppConfig.TURING_MAIL_USERNAME)
MAX_RESEND_TRIALS = 10


@celery_app.task(name='send_smtp_email')
def send_mail(recipient, template_id, template_data):
    """Sends an email using smtp.gmail.com mail server
    Args:
       recipient (str): the receiving email address.
       template_id (str): the SendGrid transactional template id
       template_data (dict): data to populate the template.

    """
    send_mail_with_template(recipient, template_id, template_data)


def send_mail_with_template(recipient, template_id, template_data):
    """Function for sending template emails using SendGrid API

   Args:
       recipient (str): the receiving email address.
       template_id (str): the SendGrid transactional template id
       template_data (dict): data to populate the template.

   Returns:
       dict: returns a dictionary containing status, headers and body  on success.
       Bool: returns a boolean False on failure.

   """
    mail = Mail()
    mail.from_email = DEFAULT_SENDER
    mail.template_id = template_id
    p = Personalization()
    p.add_to(Email(recipient))
    p.dynamic_template_data = template_data
    mail.add_personalization(p)

    return send(mail)


def send(mail, trials=6):
    """Function that handles sending mail using SendGrid API

    Args:
        mail (instance): an instance of SendGrid's Mail class.
        trials (int): The maximum number OF time the email submit resent incase a GatewayTimeoutError is raised.

    Returns:
        dict: returns a dictionary containing status, headers and body  on success.
        Bool: returns a boolean False on failure.

    """
    response = False
    try:
        response = SENDGRID_CLIENT.client.mail.send.post(
            request_body=mail.get())

    except (BadRequestsError, UnauthorizedError, UnsupportedMediaTypeError,
            ForbiddenError, PayloadTooLargeError, InternalServerError):
        pass
    except GatewayTimeoutError:
        if not (0 <= trials <= MAX_RESEND_TRIALS):
            return False
        return send(mail=mail, trials=trials - 1)

    return response
