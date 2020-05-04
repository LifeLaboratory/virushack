import requests as req
from requests.auth import HTTPBasicAuth
from urllib.parse import urlencode
import random


class SMS_SENDER(object):
    def __init__(self, email, api_key):
        self.auth_basic = HTTPBasicAuth(email, api_key)
        self.session = req.Session()
        self.sign = None

        self.auth()
        self.create_sign('TestMessage')
        self.send_msg(f'Одноразовый код: {random.randint(0000, 9999)}')

    def __del__(self):
        self.session.close()

    def __api_request(self, endpoint='/', **kwargs):
        host = 'https://gate.smsaero.ru/v2'
        print(f'Endpoint: {host}{endpoint}')
        response = self.session.get(f'{host}{endpoint}', auth=self.auth_basic, **kwargs).json()
        print(response, end='\n\n')

    def auth(self):
        self.__api_request('/auth')

    def send_msg(self, msg='Test'):
        params = urlencode({
            'number': 79834578656,
            'text': msg,
            'channel': 'DIRECT',
            'sign': self.sign
        })
        self.__api_request(f'/sms/send?{params}')

    def create_sign(self, sign):
        self.sign = sign
        self.__api_request(f'/sign/add?name={sign}')

if __name__ == '__main__':
    SMS_SENDER('airon@tark.pro', 'd0BxIwvzDaieysL7Z49aB94giT10')
