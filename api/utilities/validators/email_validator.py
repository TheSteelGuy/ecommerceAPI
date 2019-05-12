from marshmallow import ValidationError
from ..messages.error_messages import serialization_errors
from validate_email import validate_email


def email_validate(email):
    """validate an email"""
    if not validate_email(email):
        raise ValidationError(
            serialization_errors['invalid_email'])
