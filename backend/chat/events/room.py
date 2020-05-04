from chat import sio
from chat.methods.user import user
from chat.methods.message import message
from chat.methods.room import room

@sio.on('send_message')
async def on_message(sid, data):
    """ Приходит сообщение """
    pw_hash = data.get('hash')
    id_room = data.get('id_room')
    msg = data.get('msg')
    sio.enter_room(sid, room=id_room)
    message.commit(id_room, pw_hash, msg)
    await sio.send({
        'status': 200,
        'event': 'send_message',
        'msg': msg,
        'sender': user.resolve(pw_hash)
    }, room=id_room)


@sio.on('get_history')
async def on_get_history(sid, data):
    """ Возвращает историю сообщений и информацию о чате/чатах """
    pw_hash = data.get('hash')
    id_room = data.get('id_room')
    params = {'id_room': id_room, 'pw_hash': pw_hash}
    await sio.send({
        'status': 200,
        'event': 'get_history',
        'body': room.get_history(**params)
    })

@sio.on('get_info')
async def on_get_info(sid, data):
    """ Возвращает информацию о названии канала(-ов) и их участников """
    pw_hash = data.get('hash')
    id_room = data.get('id_room')
    params = {'id_room': id_room, 'pw_hash': pw_hash}
    await sio.send({
        'status': 200,
        'event': 'get_info',
        'body': room.get_info(**params)
    })
