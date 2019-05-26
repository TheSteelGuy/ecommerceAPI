import stripe
from flask_restplus import Resource
from flask import jsonify, request
from os import getenv
from flask import render_template

from api.models import Order
from api.schemas.stripe import StripeSchema
from api.middlewares.base_validator import ValidationError
from api.services.clear_carts import clear_cart_after_checkout
from api.services.send_email import send_mail
from api.services.sendgrid_templates import email_templates

from api.utilities.constants.constants import USR_02
from api.utilities.messages.error_messages import serialization_errors

from main import api, cache


@api.route('/stripe/charge')
class StripeCharge(Resource):
    """Charge payment resource"""

    def post(self):
        try:
            stripe.api_key = getenv('stripe_api_key')
            request_data = request.form

            stripe_schema = StripeSchema()
            data, error = stripe_schema.load_object_into_schema(request_data)
            if error:
                raise ValidationError(
                    {'message': serialization_errors['field_empty'].format(error[0])}, USR_02, error[0])

            user_email = cache.get('user_email')
            stripe_obj = stripe.Charge.create(
                amount=data.get('amount'),
                currency=data.get('currency', 'USD'),
                description=data.get('description'),
                source=data.get('stripeToken'),
                metadata={'order_id': str(data.get('order_id'))},
                receipt_email=user_email
            )

            cart_id = Order.query.filter_by(order_id=4).first().cart_id
            clear_cart_after_checkout.delay(cart_id)
            user_email = cache.get('user_email')
            # if user_email:
            #     send_mail.delay(
            #         user_email, email_templates.get('order_email'),
            #         {'amount': data.get('amount'), 'currency': data.get('currency', 'USD')}
            #     )
            response = jsonify(
                stripe_obj
            )
            return response
        except stripe.error.CardError as e:
            # Since it's a decline, stripe.error.CardError will be caught
            # Since it's a decline, stripe.error.CardError will be caught

            body = e.json_body
            err = body.get('error', {})
            raise ValidationError(
                {'message': err.get('message')}, err.get('code'), err.get('param'))

        except stripe.error.RateLimitError as e:
            # Too many requests made to the API too quickly
            raise e
        except stripe.error.InvalidRequestError as e:
            body = e.json_body
            err = body.get('error', {})
            raise ValidationError(
                {'message': err.get('message')}, err.get('code'), err.get('param'))

        except stripe.error.AuthenticationError as e:
            body = e.json_body
            err = body.get('error', {})
            raise ValidationError(
                {'message': err.get('message')}, err.get('code'), err.get('param'))
        except stripe.error.APIConnectionError as e:
            # Network communication with Stripe failed
            raise e
        except stripe.error.StripeError as e:
            # Display a very generic error to the user, and maybe send
            # yourself an email
            raise e
        except Exception as e:
            # Something else happened, completely unrelated to Stripe
            raise e

    @api.route('/stripe/webhooks')
    class StripeWebhooks(Resource):

        def post(self):
            response = jsonify(
                {'received': True}
            )
            return response

