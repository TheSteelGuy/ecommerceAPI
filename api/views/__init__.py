from .customer import CustomerResource, CustomerLogin
from .department import DepartmentResource, SingleDepartment
from .category import (
    CategoryResourece,SingleCategoryResource, 
    CategoriesInDepartmentResource)
from .product import (
    ProductResource, ProductsInCategory, ProductDetails,
    ProductLocation,ProductReviews
    )
from .order import OrderResource
from .shopping_cart import GenerateUniqueId
from .stripe import StripeCharge


