from app.api.base.base_sql import Sql
from app.api.base import base_name as names


class Provider:
    """
    Класс для работы с материалами в бж
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
    def get_diagnosis_by_id_user(args):
        """
        Получить медицинские материалы по id диагноза
        :param args:
        :return:
        """
        query = """
select id_diagnosis
from users
where id_user = {id_user}
limit 1
                """
        result = Sql.exec(query=query, args=args)
        return result[0].get(names.ID_DIAGNOSIS) if result else 0

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
