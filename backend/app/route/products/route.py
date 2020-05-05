# coding=utf-8
from app.api.base import base_name as names
from route.products.processor import get_products
from app.api.base.base_router import BaseRouter


class Products(BaseRouter):
    """
    Роут для работы с товарами
    """
    def __init__(self):
        super().__init__()
        self.args = [names.SEARCH, names.ID_USER]

    def get(self):
        self._read_args()
        answer = get_products(self.data)
        return answer, 200, names.CORS_HEADERS

    def options(self):
        return 'Ok', 200, names.CORS_HEADERS
