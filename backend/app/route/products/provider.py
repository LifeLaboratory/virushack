from app.api.base.base_sql import Sql
from app.api.base import base_name as names


class Provider:
    """
    Класс для работы с товарами
    """
    @staticmethod
    def get_products(args):
        """
        Получить товары в наличии у пользователя
        :param args:
        :return:
        """
        query = """
with balances as (
    select id_product, sum(qty) qty, min(expiration_date) expiration_date
    from flows
    where flows.id_user = {id_user}
    group by flows.id_product
)

select
balances.id_product
, title
, description
, qty
, to_char(expiration_date,'DD.MM.YY') expiration_date
from balances
left join products on products.id_product = balances.id_product
                """
        return Sql.exec(query=query, args=args)
