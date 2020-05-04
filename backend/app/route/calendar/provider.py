from app.api.base.base_sql import Sql
from app.api.base import base_name as names


class Provider:
    """
    Класс для работы с календарем
    """
    @staticmethod
    def get_calendar(args):
        """
        Получить товары в наличии у пользователя
        :param args:
        :return:
        """
        query = """
select
    id_procedure
    , title
    , description
    , link
    , to_char(datebegin,'DD.MM.YY HH24:MI:SS') datebegin
    , to_char(dateend,'DD.MM.YY HH24:MI:SS') dateend
from calendar
where id_user = {id_user}
order by datebegin
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def post_calendar(args):
        """
        Занести запись в календарь
        :param args:
        :return:
        """
        query = """
insert into calendar 
   (title, 
    description,
    datebegin, 
    dateend, 
    id_user) 
values ('{title}', 
        '{description}',
        '{datebegin}'::timestamp,
        '{dateend}'::timestamp,
        {id_user})
returning  
      id_procedure
    , title
    , description
    , link
    , to_char(datebegin,'DD.MM.YY HH24:MI:SS') datebegin
    , to_char(dateend,'DD.MM.YY HH24:MI:SS') dateend
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def change_calendar(args):
        """
        Отредактировать запись в календаре
        :param args:
        :return:
        """
        query = """
update calendar set 
    title = '{title}', 
    description = '{description}',
    datebegin = '{datebegin}', 
    dateend = '{dateend}', 
    id_user = {id_user}
where id_procedure = {id_procedure}
returning  
      id_procedure
    , title
    , description
    , link
    , to_char(datebegin,'DD.MM.YY HH24:MI:SS') datebegin
    , to_char(dateend,'DD.MM.YY HH24:MI:SS') dateend
"""
        return Sql.exec(query=query, args=args)
