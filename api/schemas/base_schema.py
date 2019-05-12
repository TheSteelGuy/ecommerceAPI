""" Module for base marshmallow schema. """
from marshmallow import Schema, fields


class BaseSchema(Schema):
    """Base marshmallow schema with common attributes."""
    
    deleted = fields.Boolean(dump_only=True)


    def load_object_into_schema(self, data, partial=False):
        """Helper function to load python objects into schema"""
        data, errors = self.load(data, partial=partial)
        
        try:
            error = next(iter(errors.items()))
            return data, error
        except:
            return data, None




