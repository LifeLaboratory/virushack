import 'dart:async';
import 'dart:convert';

import 'package:adhara_socket_io/socket.dart';
import 'package:http/http.dart' as http;
import 'package:palliative_chat/util/log.dart';
import 'package:web_socket_channel/io.dart';

import 'models/article.dart';

class HttpStatus {
  static const ok = 200;
  static const badRequest = 400;
  static const notFound = 404;
  static const notAllowed = 405;
}

enum CallType { get, post, delete, put, patch }

const testHash1 = 'c4ca4238a0b923820dcc509a6f75849b';
const testHash2 = 'c81e728d9d4c2f636f067f89cc14862c';
const testHash3 = 'eccbc87e4b5ce2fe28308fd9f2a7baf3';
const testUserId1 = 1;

class Api {
  //
  static final Api _singleton = Api._internal();

  factory Api() => _singleton;

  //
  http.Client _client = http.Client();
  var _chatController = StreamController<dynamic>.broadcast();
  StreamSubscription _websocketSubscription;
  var _deviceId = testHash1;
  var _userId = 1;
  IOWebSocketChannel _websocketChannel;
  SocketIO _socket;

  Stream<dynamic> get chatData => _chatController.stream;

  joinRoom(int roomId) {
    _websocketChannel.sink.add(jsonEncode({
      'event': 'join',
      'payload': {
        'room_id': roomId,
        'device_id': _deviceId,
      },
    }));
  }

  leaveRoom(int roomId) {
    _websocketChannel.sink.add(jsonEncode({
      'event': 'leave',
      'payload': {
        'room_id': roomId,
        'device_id': _deviceId,
      },
    }));
  }

  message(int roomId, String message) {
    _websocketChannel.sink.add(jsonEncode({
      'event': 'message',
      'payload': {
        'room_id': roomId,
        'device_id': _deviceId,
        'msg': message,
      },
    }));
  }

  /*getRooms() {
    l('getRooms', '$_websocketChannel');

    _websocketChannel.sink.add(jsonEncode({
      'event': 'get_history',
      'payload': {
        'full': true,
      },
    }));
  }*/

  setDeviceId(String deviceId) {
    _deviceId = deviceId;
  }

  Future sendSurveyResult({
    bool eat,
    bool dysphagia,
    bool washTeeth,
    bool wash,
    bool dress,
    bool restroom,
  }) async {
    return _post('survey', params: {
      "eat": eat,
      "dysphagia": dysphagia,
      "wash_teeth": washTeeth,
      "wash": wash,
      "dress": dress,
      "restroom": restroom,
      "id_user": _userId,
    });
  }

  Future<List<Article>> getArticlesForUser(int userId) async {
    final response =
        await http.get('http://90.189.183.166:13451/api/materials?id_user=1');
    final list = response.body as List;

    l('getArticlesForUser', response.body);
    //return list.map((e) => null);
  }

  //
  Api._internal() {
    l('_internal');
    //_initWebSocket();
  }

  _initWebSocket() {
    l('_initWebSocket');
    // [_initWebsocket] can be called from a few places, so we need to make
    // sure to cancel the previous subscription before making a new one

    if (_websocketSubscription != null) {
      _websocketSubscription.cancel();
    }

    l('_initWebSocket', 1);
    // connect

    /*_websocketChannel = IOWebSocketChannel.connect(
      'ws://90.189.183.166:15446',
      protocols: ['websocket'],
    );*/

    /* SocketIOManager manager = SocketIOManager();
    manager
        .createInstance(SocketOptions('http://90.189.183.166:5000'))
        .then((socket) {
      _socket = socket;

      _socket.onConnect((data) {
        print("connected...");
        print(data);
        socket.emit("message", ["Hello world!"]);
      });

      _socket.on("news", (data) {
        print("news");
        print(data);
      });

      _socket.connect();
    });*/

    l('_initWebSocket', 'opened', _websocketChannel.closeCode == null);

    l('_initWebSocket', 2);

    _websocketSubscription = _websocketChannel.stream.listen((data) {
      l('_initWebSocket', 'received data', data);
      //final message = Message.fromJson(jsonDecode(data));
      _chatController.add(data);
    });
  }

  Future<http.Response> _get(
    String endpoint, {
    Map<String, String> params,
    String token,
  }) async {
    return _call(
      endpoint,
      callType: CallType.get,
      params: params,
      token: token,
    );
  }

  Future<http.Response> _post(
    String endpoint, {
    Map<String, dynamic> params,
    String token,
  }) async {
    return _call(
      endpoint,
      callType: CallType.post,
      params: params,
      token: token,
    );
  }

  Future<http.Response> _delete(
    String endpoint, {
    Map<String, dynamic> params,
    String token,
  }) async {
    return _call(
      endpoint,
      callType: CallType.delete,
      params: params,
      token: token,
    );
  }

  Future<http.Response> _patch(
    String endpoint, {
    Map<String, dynamic> params,
    String token,
  }) async {
    return _call(
      endpoint,
      callType: CallType.patch,
      params: params,
      token: token,
    );
  }

  Future<http.Response> _put(
    String endpoint, {
    Map<String, dynamic> params,
    String token,
  }) async {
    return _call(
      endpoint,
      callType: CallType.put,
      params: params,
      token: token,
    );
  }

  Future<http.Response> _call(
    String endpoint, {
    callType = CallType.get,
    Map<String, dynamic> params,
    String token,
  }) async {
    http.Response response;
    var headers = await _headers();
    if (params != null) {
      params.removeWhere((key, value) => value == null);
    }
    try {
      switch (callType) {
        case CallType.get:
          response = await _client.get(
            Uri.https(
              _apiHost(),
              '/api/$endpoint',
              params,
            ),
            headers: headers,
          );
          break;
        case CallType.post:
          response = await _client.post(
            Uri.https(_apiHost(), '/api/$endpoint'),
            headers: headers,
            body: json.encode(params),
          );
          break;
        case CallType.delete:
          final request = http.Request(
            'DELETE',
            Uri.https(_apiHost(), '/api/$endpoint'),
          );
          request.body = json.encode(params);
          request.headers.addAll(headers);
          final streamedResponse = await _client.send(request);
          response = await http.Response.fromStream(streamedResponse);
          break;
        case CallType.put:
          final request = http.Request(
            'PUT',
            Uri.https(_apiHost(), '/api/$endpoint'),
          );
          request.body = json.encode(params);
          request.headers.addAll(headers);
          final streamedResponse = await _client.send(request);
          response = await http.Response.fromStream(streamedResponse);
          break;
        case CallType.patch:
          final request = http.Request(
            'PATCH',
            Uri.https(_apiHost(), '/api/$endpoint'),
          );
          request.body = json.encode(params);
          request.headers.addAll(headers);
          final streamedResponse = await _client.send(request);
          response = await http.Response.fromStream(streamedResponse);
          break;
      }
    } catch (error, stacktrace) {
      l('_call', error, stacktrace);
    }

    _checkError(response);

    return response;
  }

  _checkError(http.Response response) {
    if (response.statusCode == 500) {
      throw Exception('Ошибка на сервере');
    }

    if (response.statusCode == 401) {
      throw Exception('Не авторизован');
    }

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Map<String, String>> _headers() async {
    var headers = Map<String, String>()
      ..['Accept'] = 'application/json'
      ..['Content-Type'] = 'application/json';
    return headers;
  }

  String _apiHost() {
    return '90.189.183.166:13451';
  }
}

Api api = Api();
