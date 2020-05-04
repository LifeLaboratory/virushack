from chat import sio
from chat.methods.user import user
from chat.methods.room import room

@sio.on('join')
async def on_join(sid, data):
    """ Пользователь подключается к комнате"""
    pw_hash = data.get('hash')
    id_room = data.get('id_room')
    sio.enter_room(sid, id_room)
    room.commit_join(id_room, pw_hash)
    params = {'id_room': id_room, 'pw_hash': pw_hash}
    await sio.send({
        'status': 200,
        'event': 'join',
        'alert': f'{user.resolve(pw_hash)} присоединился(-ась)',
        'body': room.get_history(**params)
    }, room=id_room)

@sio.on('leave')
async def on_leave(sid, data):
    """ Пользователь выходит из комнаты"""
    pw_hash = data.get('hash')
    id_room = data.get('id_room')
    sio.leave_room(sid, id_room)
    room.commit_leave(id_room, pw_hash)
    await sio.send({
        'status': 200,
        'event': 'leave',
        'alert': f'{user.resolve(pw_hash)} покинул(-а) комнату'
    }, room=id_room)

