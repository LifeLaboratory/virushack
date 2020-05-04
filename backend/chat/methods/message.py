from app.api.base.base_sql import Sql
from chat.methods.user import user
class message:
    @classmethod
    def commit(cls, id_room, pw_hash, msg):
        id_user = user.get_id(pw_hash)
        query = f"insert into messages(id_user, id_room, id_parent_chat, created_at, text_message) " \
                f"values ('{id_user}', '{id_room}', null, 'NOW()', '{msg}')"
        return Sql.exec(query)

