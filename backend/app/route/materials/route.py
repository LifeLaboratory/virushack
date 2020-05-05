# coding=utf-8
from app.api.base import base_name as names
from route.materials.processor import get_materials
from app.api.base.base_router import BaseRouter


class Materials(BaseRouter):
    """
    Роут для работы с материалами
    """
    def __init__(self):
        super().__init__()
        self.args = [names.ID_USER, names.ID_DIAGNOSIS, names.SEARCH, names.LAW_MATERIALS, names.PICTURE_URL]

    def get(self):
        self._read_args()
        answer = get_materials(self.data)
        return answer, 200, names.CORS_HEADERS

    def options(self):
        return 'Ok', 200, names.CORS_HEADERS
