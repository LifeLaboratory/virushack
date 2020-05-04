import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:palliative_chat/config/settings.dart';
import 'package:palliative_chat/util/log.dart';
import 'package:web_socket_channel/io.dart';

import 'models/message.dart';

class HttpStatus {
  static const ok = 200;
  static const badRequest = 400;
  static const notFound = 404;
  static const notAllowed = 405;
}

enum CallType { get, post, delete, put, patch }

class Api {
  //
  static final Api _singleton = Api._internal();

  factory Api() => _singleton;

  //
  http.Client _client = http.Client();
  var _messagesController = StreamController<Message>.broadcast();
  StreamSubscription _websocketSubscription;
  var _deviceId = '';
  IOWebSocketChannel _websocketChannel;

  /*Stream<WebsocketData> get positions => _positionsController.stream;

  Stream<WebsocketData> get margins => _marginsController.stream;

  Stream<WebsocketData> get orderbook => _orderbookController.stream;

  Stream<WebsocketData> get ticker => _tickerController.stream;

  Stream<WebsocketData> get matches => _matchesController.stream;*/
  authToWebsocket() async {
    //payload:
    //{
    //“room_id”: int, “device_id”: str }

    _websocketChannel.sink.add(jsonEncode({
      //_type: 'auth',
      //_token: token,
    }));
  }

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

  setDeviceId(String deviceId) {
    _deviceId = deviceId;
  }

  //
  Api._internal() {
    l('_internal');
    _initWebSocket();
    authToWebsocket();
  }

  _initWebSocket() {
    l('_initWebSocket');
    // [_initWebsocket] can be called from a few places, so we need to make
    // sure to cancel the previous subscription before making a new one
    if (_websocketSubscription != null) {
      _websocketSubscription.cancel();
    }

    // connect
    _websocketChannel = IOWebSocketChannel.connect(_feedUrl());

    _websocketSubscription = _websocketChannel.stream.listen((data) {
      l('_initWebSocket', data);
      final message = Message.fromJson(jsonDecode(data));
      _messagesController.add(message);
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
    var headers = await _headers(token: token);
    if (params != null) {
      params.removeWhere((key, value) => value == null);
    }
    try {
      switch (callType) {
        case CallType.get:
          response = await _client.get(
            Uri.https(
              _apiHost(),
              '/v1/$endpoint',
              params,
            ),
            headers: headers,
          );
          break;
        case CallType.post:
          response = await _client.post(
            Uri.https(_apiHost(), '/v1/$endpoint'),
            headers: headers,
            body: json.encode(params),
          );
          break;
        case CallType.delete:
          final request = http.Request(
            'DELETE',
            Uri.https(_apiHost(), '/v1/$endpoint'),
          );
          request.body = json.encode(params);
          request.headers.addAll(headers);
          final streamedResponse = await _client.send(request);
          response = await http.Response.fromStream(streamedResponse);
          break;
        case CallType.put:
          final request = http.Request(
            'PUT',
            Uri.https(_apiHost(), '/v1/$endpoint'),
          );
          request.body = json.encode(params);
          request.headers.addAll(headers);
          final streamedResponse = await _client.send(request);
          response = await http.Response.fromStream(streamedResponse);
          break;
        case CallType.patch:
          final request = http.Request(
            'PATCH',
            Uri.https(_apiHost(), '/v1/$endpoint'),
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

  Future<Map<String, String>> _headers({String token}) async {
    var headers = Map<String, String>()
      ..['Accept'] = 'application/json'
      ..['Content-Type'] = 'application/json';

    // Some api requests required special token with other session level
    // if we was provided with the token - used it
    // if not - try to get token with level 'loggedIn' form the settings
    if (token == null) {
      token = await Settings().getTokenLoggedIn();
    }
    // Maybe we have no any token at all - this is ok
    if (token != null && token.isNotEmpty) {
      headers = headers..['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  String _feedUrl() {
    return '90.189.183.166:15446';
  }

  String _apiHost() {
    return '90.189.183.166';
  }
}
