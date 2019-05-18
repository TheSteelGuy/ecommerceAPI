
from flask_restplus import Resource
from flask import jsonify, request

from api.middlewares.base_validator import ValidationError
from api.utilities.messages.error_messages import serialization_errors

from api.schemas.category import CategorySchema
from api.schemas.product import ProductSchema
from api.schemas.department import DepartmentSchema
from api.models.category import Category

from api.utilities.paginate_helper import (
    paginator, validate_pagination_args,
    order_by_ascending_or_descending,
)

from api.utilities.constants.constants import USR_05

from main import api

category_schema = CategorySchema(exclude=['deleted'], many=True)
product_schema = ProductSchema(exclude=['deleted'], many=True)
department_schema = DepartmentSchema(exclude=['deleted'], many=True)


@api.route('/categories')
class CategoryResourece(Resource):
    """Resource for category"""

    def get(self):
        page, limit, order, description_length, query_string = validate_pagination_args(request)

        instance_base_query = order_by_ascending_or_descending(order, Category)

        paginated_categories, total_record_count = paginator(instance_base_query, page, limit)
        data = category_schema.dump(paginated_categories).data
        response = jsonify(
           {'count': Category.count(), 'status': 'success', 'rows': data}
        )
        return response


@api.route('/categories/<category_id>')
class SingleCategoryResource(Resource):
    """Single category Resource"""
    def get(self, category_id):
        try:
            int(category_id)
            category = Category.get_or_404(category_id, USR_05 ,field='category_id')
            category_schema = CategorySchema(exclude=['deleted'])
            data = category_schema.dump(category).data
            response = jsonify(
              data
            )
            return response
        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('product_id in url')}, DEP_01, 'url')


@api.route('/categories/inDepartment/<int:department_id>')
class CategoriesInDepartmentResource(Resource):
    def get(self, department_id):
        """ categories in a department resource"""
        categories = Category.query.filter_by(department_id=department_id).all()
        if not categories:
            raise ValidationError({'message': serialization_errors[
                'not_found'].format('department with this id')}, USR_05, 'department_id')
        data = category_schema.dump(categories).data
        response = jsonify(
          data
        )
        return response







