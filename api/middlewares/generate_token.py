"""Token generator
"""
import jwt
from datetime import datetime, timedelta
from config import AppConfig
def token_generator(user_id):
    """Function to generate tokens"""
    
    try:
        payload = {
            'exp': datetime.utcnow() + timedelta(days=1),
            'sub': user_id
        }
        token = jwt.encode(
            payload, AppConfig.SECRET_KEY, algorithm='HS256'
        )
        return token
    except Exception as e:
        raise e
