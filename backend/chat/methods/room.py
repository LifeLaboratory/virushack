from app.api.base.base_sql import Sql
from chat.methods.user import user

def build_query(query, prefix='ur.', **kwargs):
    id_room = kwargs.get('id_room')
    pw_hash = kwargs.get('pw_hash')
    id_user = user.get_id(pw_hash) if pw_hash else None

    if id_room:  # Все записи определённого чата
        query += f"where {prefix}id_room='{id_room}'"
    elif pw_hash:  # Все записи, где пользователь является участником
        if id_user:
            query += f"where {prefix}id_user='{id_user}'"
    elif id_room and pw_hash:  # Все записи чатов, где состоит пользователь
        query += f"where {prefix}id_room='{id_room}' and {prefix}id_user='{id_user}'"

class room:
    @classmethod
    def get_rooms(cls, **kwargs):
        query = f"select ur.id_user, ur.id_room, r.title " \
                f"from user_room ur left join rooms r on r.id_room=u.id_room "

        build_query(query, **kwargs)
        return Sql.exec(query)


    @classmethod
    def get_info(cls, **kwargs):
        rooms_list = []

        query = "select id_room, title from rooms"
        rooms = Sql.exec(query)

        for room in rooms:
            id_room = room.get("id_room")
            query = f"select ur.id_user, u.name from user_room ur " \
                    f"left join users u on ur.id_user=ur.id_user "

            build_query(query, id_room=id_room, **kwargs)

            members = Sql.exec(query)
            room.update({'body': members})
            rooms_list.append(room)

        return rooms_list

    @classmethod
    def get_history(cls, **kwargs):
        id_room = kwargs.get('id_room')
        pw_hash = kwargs.get('pw_hash')

        id_user = user.get_id(pw_hash) if pw_hash else None

        query = f"select id_message, text_message, id_user, id_room, id_parent_chat, " \
                f"to_char(created_at,'DD.MM.YY HH24:MI:SS') created_at " \
                f"from messages "

        if id_room:  # Все записи определённого чата
            query += f"where id_room='{id_room}'"
        elif pw_hash and id_user:  # Все записи, где пользователь является участником
            query += f"where id_user='{id_user}'"
        elif id_room and pw_hash:  # Все записи чатов, где состоит пользователь
            query += f"where id_room='{id_room}' and id_user='{id_user}'"

        query += "order by created_at"
        return Sql.exec(query)

    @classmethod
    def commit_join(cls, id_room, pw_hash):
        if id_room == 0:
            return {'status': 400}

        id_user = user.get_id(pw_hash)
        query = f"delete from user_room where id_room=0 and id_user='{id_user}';" \
                f"insert into user_room(id_user, id_room) values ('{id_user}', {id_room})"
        return Sql.exec(query)

    @classmethod
    def commit_leave(cls, id_room, pw_hash):
        if id_room == 0:
            return {'status': 400}

        id_user = user.get_id(pw_hash)
        query = f"delete from user_room where id_room='{id_room}' and id_user='{id_user}';" \
                f"select count(id_user) from user_room"
        return Sql.exec(query)
