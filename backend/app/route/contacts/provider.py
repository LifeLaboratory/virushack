from app.api.base.base_sql import Sql


class Provider:
    """
    Класс для работы с материалами в бж
    """
    @staticmethod
    def get_contacts(args):
        """
        Получить контакты по диагнозу
        :param args:
        :return:
        """
        query = """
select *
from contacts
where id_diagnosis = {id_diagnosis} and public
                """
        return Sql.exec(query=query, args=args)

    @staticmethod
    def get_contacts_by_id_user(args):
        """
        Получить контакты пользователя
        :param args:
        :return:
        """
        query = """
with
contacts_users as (
    select id_contact from user_contact where id_user = {id_user}
  )
select * from contacts
where id_contact = any(table contacts_users)
                """
        return Sql.exec(query=query, args=args)

    @staticmethod
    def search_contacts(args):
        """
        Поиск по контактам
        :param args:
        :return:
        """
        query = """
SELECT * FROM contacts
WHERE setweight(to_tsvector(name), 'A') ||
      setweight(to_tsvector(description), 'B') ||
      setweight(to_tsvector(adress), 'C') @@ plainto_tsquery('{search}')
{filter_diagnosis}
ORDER BY ts_rank(setweight(to_tsvector(name), 'A') ||
         setweight(to_tsvector(description), 'B') ||
         setweight(to_tsvector(adress), 'C'), plainto_tsquery('{search}')) DESC;
                """
        return Sql.exec(query=query, args=args)
