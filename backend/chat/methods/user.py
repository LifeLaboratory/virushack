from app.api.base.base_sql import Sql

class user:
    @classmethod
    def resolve(cls, pw_hash):
        query = f"select name from users where hash='{pw_hash}'"
        response = Sql.exec(query)[0].get('name')
        return response

    @classmethod
    def get_id(cls, pw_hash):
        query = f"select id_user from users where hash='{pw_hash}'"
        response = Sql.exec(query)[0].get('id_user')
        return response
