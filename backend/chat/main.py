import os
import sys
sys.path.append(os.getcwd()+'/../')
sys.path.append(os.getcwd()+'../')
sys.path.append(os.getcwd())
from aiohttp import web
from chat import app
from chat.events.alert import *
from chat.events.room import *

if __name__ == '__main__':
    web.run_app(app, host='0.0.0.0', port=15446)
