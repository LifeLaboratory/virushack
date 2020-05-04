# coding=utf-8
from app.api.base import base_name as names
from route.calendar.processor import get_calendar
from route.calendar.processor import post_calendar
from app.api.base.base_router import BaseRouter


class Calendar(BaseRouter):
    """
    Роут для работы с товарами
    """
    def __init__(self):
        super().__init__()
        self.args = [names.ID_USER, names.TITLE, names.DESCRIPTION, names.DATEBEGIN, names.DATEEND, names.ID_PROCEDURE]

    def get(self):
        self._read_args()
        answer = get_calendar(self.data)
        return answer, 200, names.CORS_HEADERS

    def post(self):
        self._read_args()
        answer = post_calendar(self.data)
        return answer, 200, names.CORS_HEADERS
