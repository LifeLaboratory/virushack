import asyncio
import json
import logging
import websockets
from provider import Provider
from app.api.base import base_name as names
logging.basicConfig()

USERS = dict()


async def notify_users(websocket, payload):
    USERS[payload.get(names.ID_USER)] = websocket
    users = Provider.get_users_by_room(payload)
    users_send = []
    for i in users:
        user = USERS.get(i.get(names.ID_USER))
        if user is not None:
            users_send.append(user)
    await asyncio.wait([u.send(json.dumps(payload)) for u in users_send])


async def main(websocket, path):
    async for message in websocket:
        data = json.loads(message.replace('\n', ''))
        answer = dict()
        answer[names.STATUS] = 200
        answer[names.EVENT] = data[names.EVENT]
        USERS[data.get(names.PAYLOAD).get(names.ID_USER)] = websocket
        if data[names.EVENT] == names.GET_HISTORY:
            if data[names.PAYLOAD].get(names.ID_ROOM):
                result = Provider.get_history_room(data[names.PAYLOAD])
            else:
                result = Provider.get_history(data[names.PAYLOAD])
            answer[names.BODY] = result
            await websocket.send(json.dumps(answer))
        if data[names.EVENT] == names.GET_ROOMS:
            if data[names.PAYLOAD].get(names.ID_USER):
                result = Provider.get_rooms_user(data[names.PAYLOAD])
            else:
                result = Provider.get_rooms(data[names.PAYLOAD])
            answer[names.BODY] = result
            await websocket.send(json.dumps(answer))
        elif data[names.EVENT] == names.JOIN:
            result = Provider.join_room(data[names.PAYLOAD])
            answer[names.BODY] = result
            await websocket.send(json.dumps(answer))
        elif data[names.EVENT] == names.LEAVE:
            Provider.leave_room(data[names.PAYLOAD])
            await websocket.send(json.dumps(answer))
        elif data[names.EVENT] == names.SEND_MESSAGE:
            Provider.send_message(data[names.PAYLOAD])
            await notify_users(websocket, data.get(names.PAYLOAD))


start_server = websockets.serve(main, "0.0.0.0", 9001)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
