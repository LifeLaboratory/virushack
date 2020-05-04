from app.api.base.base_sql import Sql
from app.api.base import base_name as names


class Provider:
    """
    Класс для работы с контактами в бд
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
and public
{filter_diagnosis}
ORDER BY ts_rank(setweight(to_tsvector(name), 'A') ||
         setweight(to_tsvector(description), 'B') ||
         setweight(to_tsvector(adress), 'C'), plainto_tsquery('{search}')) DESC;
                """
        return Sql.exec(query=query, args=args)

    @staticmethod
    def post_contact(args):
        """
        Занести запись в контакты
        :param args:
        :return:
        """
        query = """
insert into contacts 
   (name, 
    description,
    tel, 
    public, 
    adress,
    id_diagnosis) 
values ('{name}', 
        '{description}',
        '{tel}',
        FALSE,
        '{adress}',
        {id_diagnosis}
        )
returning
     id_contact
     , name 
     , description
     , tel 
     , public 
     , adress
     , id_diagnosis
"""
        query_user_contact = """
insert into user_contact 
   (id_user, 
    id_contact
    ) 
values ({id_user},
        {id_contact}
        )
        """
        result = Sql.exec(query=query, args=args)
        if result:
            args[names.ID_CONTACT] = result[0].get(names.ID_CONTACT)
            Sql.exec(query=query_user_contact, args=args)
        return result

    @staticmethod
    def change_contact(args):
        """
        отредактировать запись контакта
        :param args:
        :return:
        """
        query = """
update contacts set 
   name = '{name}', 
    description = '{description}',
    tel = '{tel}',
    adress = '{adress}'
where id_contact = {id_contact}
returning  
       id_contact
     , name 
     , description
     , tel 
     , public 
     , adress
     , id_diagnosis
"""
        return Sql.exec(query=query, args=args)
