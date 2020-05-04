from app.api.base import base_name as names
from route.survey.provider import Provider


def post_survey(user_data):
    """
    Записать данные теста
    :param user_data:
    :return:
    """
    answer = Provider.post_survey(user_data)
    return answer
