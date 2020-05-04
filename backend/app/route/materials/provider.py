from app.api.base.base_sql import Sql
from app.api.base import base_name as names


class Provider:
    """
    Класс для работы с материалами в бд
    """
    @staticmethod
    def get_materials(args):
        """
        Получить медицинские материалы по id диагноза
        :param args:
        :return:
        """
        query = """
select *
from materials
where id_diagnosis = {id_diagnosis}
                """
        return Sql.exec(query=query, args=args)

    @staticmethod
    def get_materials_by_test(args):
        """
        Получить материалы по результатам теста
        :param args:
        :return:
        """
        query = """
select *
from materials
where id_diagnosis = {id_diagnosis}
                """
        return Sql.exec(query=query, args=args)

    @staticmethod
    def get_diagnosis_by_id_user(args):
        """
        Получить медицинские материалы по id пользователя
        :param args:
        :return:
        """
        query = """
select *
from users u
left join survey s on s.id_user = u.id_user
where u.id_user = {id_user}
order by s.datetime desc
limit 1
                """
        result = Sql.exec(query=query, args=args)
        return result[0] if result else 0

    @staticmethod
    def get_diagnosis_by_user(args):
        """
        Получить медицинские материалы по id пользователя
        :param args:
        :return:
        """
        query = """
select *
from materials
where 
id_diagnosis = {id_diagnosis}
and (
    eat = {eat} 
    or dysphagia = {dysphagia}
    or wash = {wash}
    or wash_teeth = {wash_teeth}
    or dress = {dress}
    or restroom = {restroom}
    )
"""
        result = Sql.exec(query=query, args=args)
        return result

    @staticmethod
    def get_law_materials(args):
        """
        Получить материалы по праву
        :param args:
        :return:
        """
        query = """
select *
from materials
where 
tags = 'юридический'
"""
        result = Sql.exec(query=query, args=args)
        return result

    @staticmethod
    def search_materials(args):
        """
        Поиск по материалам
        :param args:
        :return:
        """
        query = """
SELECT * FROM materials
WHERE setweight(to_tsvector(title), 'A') || 
      setweight(to_tsvector(body), 'B') || 
      setweight(to_tsvector(tags), 'C') @@ plainto_tsquery('{search}')
{filter_diagnosis}
ORDER BY ts_rank(setweight(to_tsvector(title), 'A') || 
         setweight(to_tsvector(body), 'B') || 
         setweight(to_tsvector(tags), 'C'), plainto_tsquery('{search}')) DESC;
                """
        return Sql.exec(query=query, args=args)
