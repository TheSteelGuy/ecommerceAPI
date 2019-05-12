"""Database setup module."""
from flask_sqlalchemy import SQLAlchemy
# from sqlalchemy import create_engine
import mysql.connector

# Initialize database object
db = SQLAlchemy()
#engine = create_engine('mysql+mysqlconnector://e_admin:collo0@localhost:3306/tur')

conn = mysql.connector.connect(user='e_admin',database='tur', password='collo0')
cursor = conn.cursor(dictionary=True)



