from flask import request
from flask_restplus import Resource
from flask import jsonify

from api.middlewares.base_validator import ValidationError
from api.schemas.department import DepartmentSchema
from api.models.department import Department
from api.utilities.constants.constants import DEP_02, USR_03
from api.utilities.messages.error_messages import serialization_errors

from main import api

depart_schema = DepartmentSchema(exclude=['deleted'], many=True)


@api.route('/departments')
class DepartmentResource(Resource):
    """department resource"""
    def get(self):
        """fetch all departments"""
        departments = Department.get_all()
        data = depart_schema.dump(departments).data
        
        response = jsonify(data)
        response.status_code = 200
        return response


@api.route('/departments/<department_id>')
class SingleDepartment(Resource):
    """ single department resource"""
    def get(self, department_id):
        try:
            int(department_id)
            department = Department.get_or_404(department_id, DEP_02, 'department_id')
            depart_schema = DepartmentSchema(exclude=['deleted'], many=False)
            data = depart_schema.dump(department).data
            response = jsonify(data)
            response.status_code = 200
            return response
        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('department_id')}, DEP_02, 'url')
