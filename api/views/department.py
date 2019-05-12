from flask import request
from flask_restplus import Resource
from flask import jsonify

from api.schemas.department import DepartmentSchema
from api.models.department import Department
from api.utilities.constants.constants import DEP_02

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


@api.route('/departments/<int:department_id>')
class SingleDepartment(Resource):
    """ single department resource"""
    def get(self, department_id):
        department = Department.get_or_404(department_id, DEP_02, 'department_id')
        depart_schema = DepartmentSchema(exclude=['deleted'], many=False)
        data = depart_schema.dump(department).data
        response = jsonify(data)
        response.status_code = 200
        return response
