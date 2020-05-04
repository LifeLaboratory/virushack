from route.contacts.provider import Provider
from app.api.base import base_name as names


def get_contacts(user_data):
    """
    Получение контактов
    :param user_data:
    :return:
    """
    provider = Provider()
    user_data[names.FILTER_DIAGNOSIS] = ''
    if user_data.get(names.SEARCH):
        if user_data.get(names.ID_DIAGNOSIS):
            user_data[names.FILTER_DIAGNOSIS] = f'and {names.ID_DIAGNOSIS} = {user_data.get(names.ID_DIAGNOSIS)}'
        answer = provider.search_contacts(user_data)
    else:
        if user_data.get(names.ID_DIAGNOSIS) is None:
            answer = provider.get_contacts_by_id_user(user_data)
        else:
            answer = provider.get_contacts(user_data)
    return answer


def post_contact(user_data):
    """
    Занести запись контакта
    :param user_data:
    :return:
    """
    if user_data.get(names.ID_CONTACT):
        answer = Provider.change_contact(user_data)
    else:
        answer = Provider.post_contact(user_data)
    return answer
