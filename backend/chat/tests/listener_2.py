import socketio
import asyncio
import hashlib
import faker


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
    # await sio.emit('join', {'id_room': 0, 'hash': 'c81e728d9d4c2f636f067f89cc14862c'})
    await sio.emit('send_message', {'id_room': 0, 'hash': 'c81e728d9d4c2f636f067f89cc14862c', 'msg': '2 Test message'})
    # await sio.emit('get_history', {'id_room': 0, 'hash': 'c81e728d9d4c2f636f067f89cc14862c'})
    await sio.wait()

if __name__ == '__main__':
    loop.run_until_complete(main())