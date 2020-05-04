from route.materials.provider import Provider
from app.api.base import base_name as names


def get_materials(user_data):
    """
    Получение материалов
    :param user_data:
    :return:
    """
    provider = Provider()
    user_data[names.FILTER_DIAGNOSIS] = ''
    if user_data.get(names.SEARCH):
        if user_data.get(names.ID_DIAGNOSIS):
            user_data[names.FILTER_DIAGNOSIS] = f'and {names.ID_DIAGNOSIS} = {user_data.get(names.ID_DIAGNOSIS)}'
        answer = provider.search_materials(user_data)
    else:
        if user_data.get(names.ID_DIAGNOSIS) is None:
            user_data[names.ID_DIAGNOSIS] = provider.get_diagnosis_by_id_user(user_data)
        answer = provider.get_materials(user_data)
    return answer
