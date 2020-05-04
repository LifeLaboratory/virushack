# coding=utf-8
from app.api.base import base_name as names
from route.contacts.processor import get_contacts
from app.api.base.base_router import BaseRouter


class Contacts(BaseRouter):
    """
    Роут для работы с материалами
    """
    def __init__(self):
        super().__init__()
        self.args = [names.ID_USER, names.ID_DIAGNOSIS, names.SEARCH]

    def get(self):
        self._read_args()
        answer = get_contacts(self.data)
        return answer, 200, names.CORS_HEADERS
