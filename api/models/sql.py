sql_queries = dict(
    get_reviews='SELECT c.name, r.review, r.rating, r.created_on FROM\
    review r INNER JOIN  customer c ON r.customer_id=c.customer_id WHERE r.product_id=%s  ORDER BY r.rating DESC;',
    exists="SELECT 1 FROM {table} WHERE {table}.{column}={value};",
    total_cart_amount="select sum((p.price*sc.quantity)) as total_amount from product p inner \
    join shopping_cart sc on p.product_id=sc.product_id where sc.cart_id=%s;"
)
