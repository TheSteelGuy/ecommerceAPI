from sqlalchemy import or_

# Messages
from .messages.error_messages import serialization_errors

# Middlewares
from ..middlewares.base_validator import ValidationError
from api.utilities.constants.constants import USR_02, DESCRIPTION_LENGTH

from config import AppConfig


def validate_pagination_args(request):
    """
    Validates if the query strings are valid.

    Arguments:
        request (obj): request object

    Raises:
        ValidationError: Use to raise exception if any error occur

    Returns:
        (tuple) -- Returns tuple
    """
    page = request.args.get('page')
    limit = request.args.get('limit')
    order = request.args.get('order', 'category_id,ASC')
    description_length = request.args.get('description_length')
    query_string = request.args.get('query_string')

    try:

        if page and limit:
            if int(page) < 0 or int(limit) < 0:
                raise ValidationError({
                    'message': "Page and limit only accept positive integer values"
                }, USR_02)
        page = 1 if page is None else int(page)
        limit = AppConfig.ITEMS_PER_PAGE if limit is None else int(limit)

        if description_length and not description_length.isdigit():
            raise ValidationError({
                'message': "Description length only accept interger values"
            }, USR_02)
        if not description_length:
            description_length = DESCRIPTION_LENGTH

        return page, limit, order, description_length, query_string

    except ValueError:
        raise ValidationError({
            'message': "Page and limit only accept integer values"
        }, USR_02)


def search_db(request, model, query_string):
    """search model based on a query string"""
    all_words = request.args.get('all_words', 'on', str)
    import pdb;
    pdb.set_trace()

    if query_string and all_words == 'on':
        instance_base_query = model.query.filter(
            or_(model.name.like('%' + query_string + '%'), model.description.like('%' + query_string + '%'))
        )
    elif query_string and all_words == 'off':
        all_words_tuple = tuple(query_string.split(' '))

        instance_base_query = model.query.filter(or_(model.name.in_(all_words_tuple), model.description.in_(all_words_tuple)))
    else:
        raise ValidationError({
            'message': "The field query string is empty."
        }, USR_02, 'query_string')

    return instance_base_query


def order_by_ascending_or_descending(order, model):
    """Descending|ascending sorter method"""

    order_by_combination = [['category_id', 'DESC'], ['category_id', 'ASC'], ['name', 'ASC'], ['name', 'DESC']]
    order_by_list = order.split(',')
    model_id_str = f"model.{model.__name__.lower()}_id"  # this allows re-usability of the function by all models
    # for instance if the class making the call is Category then id becomes category_id
    if order and order_by_list in order_by_combination:
        column_name = order_by_list[0].lower()
        asc_or_desc = order_by_list[1].upper()
        sorted_instance = {
            'id' in column_name and asc_or_desc == 'ASC': model.query.order_by(eval(model_id_str).asc()),
            'id' in column_name and asc_or_desc == 'DESC': model.query.order_by(eval(model_id_str).desc()),
            column_name == 'name' and asc_or_desc == 'ASC': model.query.order_by(model.name.asc()),
            column_name == 'name' and asc_or_desc == 'DESC': model.query.order_by(model.name.desc())}
        return sorted_instance.get(True)

    if order_by_list not in order_by_combination:
        raise ValidationError({
            'message': "The order is not match 'field,(DESC|ASC)'."
        }, USR_02)


def truncate_description(data, description_length):
    """truncates the description length in an view where called"""
    if data and description_length:
        for item in data:
            item['description'] = f"{item['description'][:int(description_length)]}..." \
                if int(description_length) < len(item['description']) else item['description'][:int(description_length)]


def paginator(model_instances, page, limit):
    """pagination function"""
    records = model_instances.paginate(page, limit, False).items
    total_records_count = len(records) if records else model_instances.count()

    return records, total_records_count
