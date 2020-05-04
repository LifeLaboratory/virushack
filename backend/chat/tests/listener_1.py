import asyncio

import socketio

loop = asyncio.get_event_loop()
sio = socketio.AsyncClient()

# @sio.on('connect')
# async def on_connect():
#     await sio.send('I m connected')

@sio.on('disconnect')
def on_disconnect():
    sio.disconnect()

@sio.event
async def message(msg):
    print(msg)

async def main():
    await sio.connect('http://127.0.0.1:15446')
    # await sio.emit('join', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b'})
    # await sio.emit('leave', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b'})
    # await sio.emit('send_message', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b', 'msg': '1 Test message'})
    # await sio.sleep(3)
    # await sio.emit('send_message', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b', 'msg': 'Test message'})
    # await sio.sleep(3)
    # await sio.emit('leave', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b'})

    # await sio.emit('get_info', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b'})
    # await sio.emit('get_info', {'hash': 'c4ca4238a0b923820dcc509a6f75849b'})
    # await sio.emit('get_info', {'id_room': 0})
    # await sio.emit('get_info')

    await sio.emit('test', {'id_room': 0})

    # await sio.emit('get_history', {'id_room': 0, 'hash': 'c4ca4238a0b923820dcc509a6f75849b'})
    # await sio.emit('get_history', {'hash': 'c4ca4238a0b923820dcc509a6f75849b'})
    # await sio.emit('get_history', {'id_room': 0})
    # await sio.emit('get_history', {'full': True})
    await sio.wait()

if __name__ == '__main__':
    loop.run_until_complete(main())