"""Module for generic model operations mixin."""

import re

from flask import request

from .database import db
from api.utilities.constants.constants import USR_04
from api.models.sql import sql_queries

# validators
from ..middlewares.base_validator import ValidationError
from ..utilities.messages.error_messages import serialization_errors


class ModelOperations(object):
    """Mixin class with generic model operations."""

    def save(self):
        """
        Save a model instance
        """
        db.session.add(self)
        db.session.commit()
        return self

    def update(self, **kwargs):
        """
        update entries
        """
        for field, value in kwargs.items():
            setattr(self, field, value)

        db.session.commit()
        return self

    @classmethod
    def get_or_404(cls, id, code, field):
        """
        return entries by id
        """
        record = cls.get(id)
        if not record or record.deleted:
            raise ValidationError(
                {
                    'message':
                    "Don'exist "f'{re.sub(r"(?<=[a-z])[A-Z]+",lambda x: f" {x.group(0).lower()}" , cls.__name__).lower()} with this ID'  
                },
                code, field)

        return record

    @classmethod
    def delete(cls, product_id, attributes, item_id):
        """
        delete a model instance.
        """

        db.session.query(cls).filter_by(
            product_id=product_id, attributes=attributes)
        db.session.flush()

    @classmethod
    def count(cls):
        """
        Returns total entries in the database
        """
        count = cls.query.count()
        return count

    @classmethod
    def find_or_create(cls, data, email, *args):
        """
        Finds a model instance or creates it
        """
        instance = cls.query.filter_by(email=email, deleted=False).first()
        if not instance:
            instance = cls(**data).save()
            return instance
        
        raise ValidationError(
            {'message': serialization_errors['exists'].format(email, *args)}, USR_04, 'email'
        ) 
        
    @classmethod
    def get_all(cls):
        """get all objects"""
        return cls.query.all()

    @classmethod
    def exists(cls, value, column, code, resource):
        """Verifies whether the specified id exists in the database

        This method uses an SQL statement which returns no row data to check
        whether a record exists. It is therefore more efficient than the
        `Model.get` method when verifying existence is all that is required.

        Args:
            column (str): The column to check. 
            value (str): The value to verify
            resourec (str) : abject instance name eg product, category
            code (str): error code
    

        Returns:
            bool: True if the value exists, False otherwise
        """
        get_query = sql_queries.get('exists')
        query = get_query.format(
            table=resource, column=column, value=value)
       
        result = db.engine.execute(query).scalar()
      
        if result:
            return True
        else:
            raise ValidationError(
                {'message': serialization_errors['not_found'].format(
                    f"{resource} with this id")}, code, column)

    @classmethod
    def bulk_create(cls, raw_list):
        """
        Save raw list of records to database

        Parameters:
            raw_list(list): List of records to be saved to database
        """
        resource_list = [cls(**item) for item in raw_list]
        db.session.add_all(resource_list)

        return resource_list
