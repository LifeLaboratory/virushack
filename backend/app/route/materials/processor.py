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
    elif user_data.get(names.LAW_MATERIALS):
        answer = provider.get_law_materials(user_data)
    elif user_data.get(names.ID_DIAGNOSIS) is None:
        result = provider.get_diagnosis_by_id_user(user_data)
        test_fields = [names.EAT, names.DYSPHAGIA, names.WASH, names.ID_USER, names.RESTROOM, names.DRESS,
                       names.WASH_TEETH, names.ID_DIAGNOSIS]
        for field in test_fields:
            user_data[field] = result.get(field)
        answer = provider.get_diagnosis_by_user(user_data)
    else:
        answer = provider.get_materials(user_data)
    return answer
