# coding=utf-8
from app.api.base import base_name as names
from route.contacts.processor import get_contacts
from route.contacts.processor import post_contact
from app.api.base.base_router import BaseRouter


class Contacts(BaseRouter):
    """
    Роут для работы с контактами
    """
    def __init__(self):
        super().__init__()
        self.args = [names.ID_USER, names.ID_DIAGNOSIS, names.SEARCH, names.NAME, names.DESCRIPTION, names.ADRESS,
                     names.tel, names.ID_CONTACT]

    def get(self):
        self._read_args()
        answer = get_contacts(self.data)
        return answer, 200, names.CORS_HEADERS

    def post(self):
        self._read_args()
        answer = post_contact(self.data)
        return answer, 200, names.CORS_HEADERS

    def options(self):
        return 'Ok', 200, names.CORS_HEADERS
