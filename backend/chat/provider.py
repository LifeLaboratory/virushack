from app.api.base.base_sql import Sql


class Provider:
    """
    Класс для работы с чатом
    """
    @staticmethod
    def get_history(args):
        """
        Получить истрию чатов по id_user
        :param args:
        :return:
        """
        query = """
with user_rooms as(

  select id_room from  user_room ur
  where id_user = {id_user}
),

messages as (
  select
distinct m.id_room
       , r.title
       , m.id_message
, m.text_message
, m.id_user
, u.name
, m.created_at
from messages m
left join rooms r on r.id_room = m.id_room
left join users u on u.id_user = m.id_user
where m.id_room = any(array(table user_rooms))
)
select
    id_room
    , title
    , id_message
    , text_message
    , id_user
    , name
    , to_char(created_at,'DD.MM.YY HH24:MI:SS') created_at
from messages
order by id_room, created_at
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def get_rooms_user(args):
        """
        Получить комнаты по id_user
        :param args:
        :return:
        """
        query = """
select r.* from  user_room ur
left join rooms r on r.id_room = ur.id_room
where id_user = {id_user}
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def get_rooms(args):
        """
        Получить все комнаты
        :param args:
        :return:
        """
        query = """
select r.* from  user_room ur
left join rooms r on r.id_room = ur.id_room
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def get_history_room(args):
        """
        Получить истрию чата
        :param args:
        :return:
        """
        query = """
with
messages as (
  select
distinct m.id_room
       , r.title
       , m.id_message
, m.text_message
, m.id_user
, m.created_at
, u.name
from messages m
left join rooms r on r.id_room = m.id_room
left join users u on u.id_user = m.id_user
where m.id_room = {id_room}
    )
select
id_room
       , title
       , id_message
, text_message
, id_user
, name
, to_char(created_at,'DD.MM.YY HH24:MI:SS') created_at
from messages
order by created_at
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def join_room(args):
        """
        Войти в комнату
        :param args:
        :return:
        """
        query = """
insert into user_room 
   (id_user, 
    id_room )
values ({id_user}, 
        {id_room})
returning
    *
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def leave_room(args):
        """
        Покинуть комнату
        :param args:
        :return:
        """
        query = """
delete from  user_room where id_room = {id_room} and id_user = {id_user}
"""
        return Sql.exec(query=query, args=args)

    @staticmethod
    def send_message(args):
        """
        Отправить сообщение в комнату
        :param args:
        :return:
        """
        query = """
insert into messages 
   (text_message,
   id_user,
   id_room,
   created_at
    )
values ('{text_message}',
        {id_user},
        {id_room},
        now()::timestamp
        )
"""
        return Sql.exec(query=query, args=args)
