from app.api.base.base_sql import Sql
from app.api.base import base_name as names


class Provider:
    """
    Класс для работы с товарами
    """
    @staticmethod
    def post_survey(args):
        """
        Занести результаты теста
        :param args:
        :return:
        """
        query = """
insert into survey 
   (eat, 
    dysphagia,
    wash, 
    wash_teeth,
    dress, 
    restroom,
    id_user) 
values ({eat}, 
        {dysphagia},
        {wash}, 
        {wash_teeth}, 
        {dress}, 
        {restroom},
        {id_user})
returning
    id_survey,
    eat, 
    dysphagia,
    wash, 
    wash_teeth,
    dress, 
    restroom,
    id_user
    """
        result = Sql.exec(query=query, args=args)
        return result
