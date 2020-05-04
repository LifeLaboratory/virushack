# coding=utf-8
from app.api.base import base_name as names
from route.survey.processor import post_survey
from app.api.base.base_router import BaseRouter


class Survey(BaseRouter):
    """
    Роут для работы с товарами
    """
    def __init__(self):
        super().__init__()
        self.args = [names.EAT, names.DYSPHAGIA, names.WASH, names.ID_USER, names.RESTROOM, names.DRESS,
                     names.WASH_TEETH, names.ID_SURVEY]

    def post(self):
        self._read_args()
        answer = post_survey(self.data)
        return answer, 200, names.CORS_HEADERS
