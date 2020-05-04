from app.api.base import base_name as names
from route.products.provider import Provider


def get_products(user_data):
    """
    Получить ссылку на яндекс маркет по поиску
    :param user_data:
    :return:
    """
    if user_data.get(names.SEARCH):
        answer = [{names.LINK: f'https://market.yandex.ru/search?text={user_data.get(names.SEARCH)}'}]
    else:
        answer = Provider.get_products(user_data)
    return answer
