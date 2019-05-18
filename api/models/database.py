"""Database setup module."""
from flask_sqlalchemy import SQLAlchemy
from os import getenv
import mysql.connector

# Initialize database object
db = SQLAlchemy()

conn = mysql.connector.connect(user=getenv('ADMIN'), database='tur', password=getenv('ADMIN_PWD'))
cursor = conn.cursor(dictionary=True)

