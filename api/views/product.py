from flask_restplus import Resource
from flask import jsonify, request

from api.schemas.product import ProductSchema, ProductCategorySchema
from api.schemas.review import ReviewSchema
from api.models import Product, ProductCategory
from api.models import Category
from api.models import Department
from api.models import ProductReview
from api.models import sql_queries
from api.models import cursor

from api.utilities.paginate_helper import (
    paginator, validate_pagination_args,
    search_db, truncate_description)
from api.utilities.constants.constants import USR_02, USR_05, USR_03, DEP_02, CAT_02
from api.middlewares.base_validator import ValidationError
from api.utilities.messages.error_messages import serialization_errors
from api.utilities.constants.constants import PRD_01
from api.middlewares.token_required import token_required

from main import api


product_schema = ProductSchema(exclude=['deleted', 'display', 'image_2', 'image'], many=True)
product_category_schema = ProductCategorySchema(exclude=['deleted'])


@api.route('/products')
class ProductResource(Resource):
    """Get all products resource"""

    def get(self):
        page, limit, order, description_length, query_string = validate_pagination_args(request)
        instances_base_query = Product.query.filter(Product.product_id)

        paginated_products, total_records_count = paginator(instances_base_query, page, limit)

        data = product_schema.dump(paginated_products).data
        truncate_description(data, description_length)

        response = jsonify(
            {'count': total_records_count, 'status': 'success', 'rows': data}
        )
        return response


@api.route('/products/search')
class ProductResourceSearch(Resource):
    """product search resource"""

    def get(self):
        page, limit, order, description_length, query_string = validate_pagination_args(request)
        instance_base_query = search_db(request, Product, query_string)
        paginated_products, total_record_account = paginator(instance_base_query, page, limit)

        data = product_schema.dump(paginated_products).data

        # mutates the data array by reference ie no need to return anything
        truncate_description(data, description_length)
        response = jsonify(
            {'count': total_record_account, 'status': 'success', 'rows': data}
        )
        return response


@api.route('/products/<product_id>')
class SingleProduct(Resource):
    def get(self, product_id):
        product = Product.get_or_404(product_id, USR_02, field='product_id')
        schema = ProductSchema(exclude=['deleted'])
        data = schema.dump(product).data
        response = jsonify(
            {'status': 'success', 'rows': data}
        )
        return response


@api.route('/categories/inProduct/<product_id>')
class ProductsCategory(Resource):
    """categories of a product resource"""

    def get(self, product_id):
        try:
            int(product_id)
            product_category = ProductCategory.get(product_id)
            name = product_category.category.name
            department_id = product_category.category.department_id
            schema = ProductCategorySchema(only=['category_id'])
            data = schema.dump(product_category).data

            data['name'] = name
            data['department_id'] = department_id
            response = jsonify(
                [data]
            )
            return response
        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('product_id in url')}, USR_03, 'url')


@api.route('/products/inCategory/<int:category_id>')
class ProductsInCategory(Resource):
    """products category resource"""

    def get(self, category_id):
        try:
            page, limit, order, description_length, query_string = validate_pagination_args(request)

            product_category_base_query = Category.query.filter_by(category_id=category_id).first().products
            paginated_products, total_records_count = paginator(product_category_base_query, page, limit)
            products_schema = ProductSchema(exclude=[
                'deleted', 'category_id', 'display', 'image', 'image_2', 'thumbnail'], many=True)
            data = products_schema.dump(paginated_products).data

            truncate_description(data, description_length)
            response = jsonify(
                {'count': total_records_count, 'status': 'success', 'rows': data}
            )
            return response

        except AttributeError:
            raise ValidationError(
                {'message': serialization_errors['not_found'].format('category with this ID')}, CAT_02, 'category_id')


@api.route('/products/inDepartment/<int:department_id>')
class ProductsIndepartment(Resource):
    """products in department  resource"""

    def get(self, department_id):
        try:
            page, limit, order, description_length, query_string = validate_pagination_args(request)

            product_category_base_query = Department.query.filter_by(department_id=department_id).first().products

            paginated_products, total_records_count = paginator(product_category_base_query, page, limit)

            products_schema = ProductSchema(exclude=[
                'deleted', 'category_id', 'display', 'image', 'image_2', 'thumbnail'], many=True)
            data = products_schema.dump(paginated_products).data

            truncate_description(data, description_length)
            response = jsonify(
                {'count': total_records_count, 'status': 'success', 'rows': data}
            )
            return response

        except AttributeError:
            raise ValidationError(
                {'message': serialization_errors['not_found'].format(
                    'department with that id')}, DEP_02, 'department_id')


@api.route('/products/<product_id>/details')
class ProductDetails(Resource):
    """products details resource"""

    def get(self, product_id):
        try:
            int(product_id)

            product = Product.get(product_id=product_id)
            schema = ProductSchema(exclude=[
                'deleted', 'category_id', 'display', 'thumbnail'])

            data = schema.dump(product).data

            response = jsonify(
                [data]
            )
            return response
        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('product_id in url')}, USR_03, 'url')


@api.route('/products/<product_id>/locations')
class ProductLocation(Resource):
    """products locations resource"""

    def get(self, product_id):
        try:
            int(product_id)
            product = Product.get(product_id=product_id)

            department = product.department
            category = product.category

            product_loactions = dict(
                category_id=category.category_id,
                category_name=category.name,
                department_id=department.department_id,
                department_name=department.name
            )

            response = jsonify(
                product_loactions
            )
            return response
        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('product_id in url')}, USR_03, 'url')


@api.route('/products/<product_id>/reviews')
class ProductReviews(Resource):
    """products reviews resource"""

    def get(self, product_id):
        try:
            int(product_id)
            cursor.execute(sql_queries.get('get_reviews'), (product_id,))
            reviews = cursor.fetchall()
            if not reviews:
                raise ValidationError(
                    {'message': serialization_errors['not_found'].format('product with this ID')}, USR_05, 'product_id')
            response = jsonify(reviews)
            return response

        except ValueError:
            raise ValidationError(
                {'message': serialization_errors['invalid'].format('product_id in url')}, USR_03, 'url')

    @token_required
    def post(self, product_id):
        request_data = request.form

        review_schema = ReviewSchema()

        review_details, error = review_schema.load_object_into_schema(request_data)
        if error:
            raise ValidationError(
                {'message': serialization_errors['field_empty'].format(error[0])}, USR_02, error[0])
        ProductReview.exists(
            request_data.get('product_id'),
            'product_id',
            PRD_01,
            'product'
        )

        review_details['customer_id'] = request.decoded_token['sub']
        product_review = ProductReview(**review_details)
        product_review.save()

        response = jsonify(

        )
        response.status_code = 204
        return response
