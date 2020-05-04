from app.api.base import base_name as names
from route.calendar.provider import Provider


def get_calendar(user_data):
    """
    Получить ссылку на яндекс маркет по поиску
    :param user_data:
    :return:
    """
    answer = Provider.get_calendar(user_data)
    return answer


def post_calendar(user_data):
    """
    Занести запись в календарь
    :param user_data:
    :return:
    """
    if user_data.get(names.ID_PROCEDURE):
        answer = Provider.change_calendar(user_data)
    else:
        answer = Provider.post_calendar(user_data)
    return answer
