import 'dart:async';
import 'dart:convert';

import 'package:adhara_socket_io/socket.dart';
import 'package:bloc/bloc.dart';
import 'package:palliative_chat/repository/api.dart';
import 'package:palliative_chat/repository/models/message.dart';
import 'package:palliative_chat/repository/models/room.dart';
import 'package:palliative_chat/util/log.dart';

import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  SocketIO _socket;

  @override
  ChatState get initialState => ChatState.idle();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    l('mapEventToState', event);

    if (event is Opened) {
      /*SocketIOManager manager = SocketIOManager();
      SocketIO socket = await manager.createInstance(
        SocketOptions(
          'http://90.189.183.166:5000',
          nameSpace: '/',
          enableLogging: false,
          transports: [Transports.WEB_SOCKET],
        ),
      );

      l('mapEventToState', 'socket received');

      socket.onConnecting((data) {
        l('mapEventToState', 'connecting...', data);
      });

      socket.onConnect((data) {
        l('mapEventToState', 'connected!', data);
      });

      socket.onConnectError((data) {
        l('mapEventToState', 'connected error', data);
      });

      socket.onError((data) {
        l('mapEventToState', 'error', data);
      });

      socket.on('get_history', (data) {
        l('mapEventToState', 'on get hostory', data);
      });

      socket.connect();*/

      //final connected = await socket.isConnected();
      //l('mapEventToState', 'connected', connected);

      yield state.copyWith(
        rooms: [
          Room()
            ..roomId = 1
            ..title = 'Общий канал'
          /*..messages = [
              Message()
                ..messageId = 1
                ..senderId = 1
                ..senderName = 'Vitaminka'
                ..text =
                    'Доброго дня. Свекрови 3 дня не даем хлор - все вернулось на круги своя, активная, требует отправить ее домой. Сегодня получила пенсию - жду с содраганием когда ее украдут или еще что случится. Меня всю трясет, горит лицо, руки дрожат. Мои нервы сдают... Я прям чувствую это... Мужу ничего не говорю, потому что что он сделает? Это какой-то ад... Наверное пишу просто, чтоб выговориться. Мучает совесть плюс еще, но я не хочу этого всего, меня трясет от одного ее вида, голоса... Это кошмар какой-то... Понять, принять - все отлично пока она спокойна. Когда она активна я хочу бежать куда глаза глядят... Просто поговорите со мной. Простите, если не в тот раздел написала... ',
            ]*/
          ,
          Room()
            ..roomId = 2
            ..title = 'Деменция'
          /*..messages = [
              Message()
                ..messageId = 2
                ..senderId = 1
                ..senderName = 'Ariana'
                ..text =
                    'Вчера примерно тоже самое испытывала, что вы описываете, хотя моя свекровь не в пример спокойнее, просто много лежит и теряет память. Но вчера была ажитирована и не спала весь день, тоже домой простилась, хотя на ногах толком не держится. Ушатпла меня совсем. Добавила полтпблетки сероквеля на ночь, все равно спала плохо. А сегодня тихая как мышь. А я все чаще думаю, что проблему нужно решать деньгами - нанимать сиделку с проживанием. С такими негативными эмоциями меня надолго не хватит, работать мне она не даст..  так что не корите себя, мы все здесь в одной жёлтой субмарине.',
            ]*/
          ,
          Room()
            ..roomId = 1
            ..title = 'Онкология'
          /*..messages = [
              Message()
                ..messageId = 4
                ..senderId = 1
                ..senderName = 'Наталья Козлова'
                ..text =
                    'Добрый вечер, уважаемые участники форума. С большим трудом нашла этот сайт. С первых же постов поняла, что это то, что мне необходимо. Уже месяц ухаживают за мамой, 74 года. Деменция на фоне сахарного диабета Привезли в ужасном состоянии. Сейчас чуть лучше. Но моя жизнь перевернулась. Я долго не могла понять, как теперь с этим жить. Искала помощи в больнице, социальных службах. Слава богу, семья поддерживает. Но нервы сдают у всех!!! С большим уважением читаю посты многих, столкнувшихся с этой бедой. Вы настоящие герои! Извините, что  сумбурно! И спасибо за возможность выговориться!',
            ]*/
          ,
          Room()
            ..roomId = 2
            ..title = 'СПИД'
          /*..messages = [
              Message()
                ..messageId = 4
                ..senderId = 1
                ..senderName = 'Наталья 1970'
                ..text =
                    'Моя жизнь тоже изменилась....и я сама изменилась с болезнью мамы....человечней стала что-ли....здесь много полезных советов а самое главное огромное количество хороших людей!!! '
            ]*/
          ,
          Room()
            ..roomId = 2
            ..title = 'Склерозы'
          /*..messages = [
              Message()
                ..messageId = 4
                ..senderId = 1
                ..senderName = 'iris_ka'
                ..text =
                    'С нейролептиков надо уходить, постепенно снижая дозу. Хлорпотексен очень сильно бьёт по ногам. Тиоридозин, он же сонопакс, возможно вам не подошёл и у  мамы развился нейролептический синдром, не знаю. Есть более современные препараты, к примеру сероквель.  АМ это противодементный  препарат, здесь были темы, когда именно его принимая , состояние улучшалось.',
            ]*/
          ,
          Room()
            ..roomId = 2
            ..title = 'Вегетативные состояние',
        ],
        messages: [
          Message()
            ..messageId = 1
            ..userId = 1
            //..senderName = 'Vitaminka'
            ..text =
                'Доброго дня. Свекрови 3 дня не даем хлор - все вернулось на круги своя, активная, требует отправить ее домой. Сегодня получила пенсию - жду с содраганием когда ее украдут или еще что случится. Меня всю трясет, горит лицо, руки дрожат. Мои нервы сдают... Я прям чувствую это... Мужу ничего не говорю, потому что что он сделает? Это какой-то ад... Наверное пишу просто, чтоб выговориться. Мучает совесть плюс еще, но я не хочу этого всего, меня трясет от одного ее вида, голоса... Это кошмар какой-то... Понять, принять - все отлично пока она спокойна. Когда она активна я хочу бежать куда глаза глядят... Просто поговорите со мной. Простите, если не в тот раздел написала... ',
          Message()
            ..messageId = 2
            ..userId = 1
            //..senderName = 'Ariana'
            ..text =
                'Вчера примерно тоже самое испытывала, что вы описываете, хотя моя свекровь не в пример спокойнее, просто много лежит и теряет память. Но вчера была ажитирована и не спала весь день, тоже домой простилась, хотя на ногах толком не держится. Ушатпла меня совсем. Добавила полтпблетки сероквеля на ночь, все равно спала плохо. А сегодня тихая как мышь. А я все чаще думаю, что проблему нужно решать деньгами - нанимать сиделку с проживанием. С такими негативными эмоциями меня надолго не хватит, работать мне она не даст..  так что не корите себя, мы все здесь в одной жёлтой субмарине.',
          Message()
            ..messageId = 3
            ..userId = 1
            //..senderName = 'Катя Катя'
            ..text =
                'Позавчера испытала то же самое, ажитация полная, негатив, беготня. Меня сразу начинает всю трясти, с содроганием боюсь возвращения к периоду до нейролептика. Обязательно всё возвращайте! Мне кажется такой больной может до инфаркта довести даже если он не причиняет физического вреда. Обвинения, беготня, поиски, я вообще это выносить не могу. Держитесь!!!',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Милена'
            ..text =
                'Добрый день. Пишу, чтобы попросить советы бывалых. Краткая история: живу в самоизоляции с бабушкой 88 лет. У бабушки деменция. 2 недели назад она упала и решила, что ходить больше не может (при этом ни переломов, ни растяжений нет, все конечности подвижны). Приобретён стул туалет. Нарядила в памперсы. Сажаю на туалет  достаточно насильно,  с криками «я упаду». Вопросы: 1. Как-нибудь можно ей внушить, что она может ходить? 2. Как отрегулировать ее стул (несколько дней был запор, сделала клизму, теперь уже 2 дня мажет фекалиями на памперс)? 3. Как бороться с моей непереносимостью к запаху фекалий (начинаются рвотные позывы)? Заранее всем спасибо за ответы и советы',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Ariana'
            ..text =
                'Мою свекровь прошибает только гутталакс 30 капель раз в четыре дня. Мироклизмы и свечи не мопогают. Тоже туалетный стул, но без памперсов пока. Насчёт остального ничего сказать не могу.',
          Message()
            ..messageId = 4
            //..senderId = 1
            //..senderName = 'Наталья Козлова'
            ..text =
                'Добрый вечер, уважаемые участники форума. С большим трудом нашла этот сайт. С первых же постов поняла, что это то, что мне необходимо. Уже месяц ухаживают за мамой, 74 года. Деменция на фоне сахарного диабета Привезли в ужасном состоянии. Сейчас чуть лучше. Но моя жизнь перевернулась. Я долго не могла понять, как теперь с этим жить. Искала помощи в больнице, социальных службах. Слава богу, семья поддерживает. Но нервы сдают у всех!!! С большим уважением читаю посты многих, столкнувшихся с этой бедой. Вы настоящие герои! Извините, что  сумбурно! И спасибо за возможность выговориться!',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Таламея'
            ..text =
                'Присоединяйтесь. Читайте, спрашивайте. Тут многие прошли такой путь, что подскажут не хуже докторов, а порой и лучше. Я тоже недавно, и тоже пришла в полном ужасе и шоке что делать. Тут мне подсказали, поставили на место мозги и теперь учусь жить с этим всем. ',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Александр Сонин'
            ..text =
                'Здравствуйте! Диабет не может быть непосредственной причиной деменции. Наверно, болезнь Альцгеймера? Что врач говорит?',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Snow Scorpion'
            ..text =
                'Добро пожаловать" в наших ситуациях звучит странновато... Но, все же... добро пожаловать!',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Фиалка'
            ..text =
                'Здесь Вас поймут. Не осудят. Подскажут. Пожалеют. Поддержат. Здесь можно рассказать о том, о чем неловко или нехочется говорить с друзьями, родственниками или соседями. Здесь мы в одной лодке. В справочнике вы найдете много информации, а в историях форумчан много ценных советов, удачных  решений, лайфхаков. Психические или поведенческие отклонения сильно стигматизированы в нашем обществе. Многие даже не знают о том, насколько распространена эта проблема, поэтому те, кто с ней сталкивается лично часто теряется и чувствует себя одиноко. Здесь вы поймёте, вы не одна. От этого не проще, но немного легче психологически. ',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'Наталья 1970'
            ..text =
                'Моя жизнь тоже изменилась....и я сама изменилась с болезнью мамы....человечней стала что-ли....здесь много полезных советов а самое главное огромное количество хороших людей!!! ',
          Message()
            ..messageId = 4
            ..userId = 1
            //..senderName = 'iris_ka'
            ..text =
                'С нейролептиков надо уходить, постепенно снижая дозу. Хлорпотексен очень сильно бьёт по ногам. Тиоридозин, он же сонопакс, возможно вам не подошёл и у  мамы развился нейролептический синдром, не знаю. Есть более современные препараты, к примеру сероквель.  АМ это противодементный  препарат, здесь были темы, когда именно его принимая , состояние улучшалось.',
        ],
      );
    }

    if (event is SendMessage) {
      try {
        yield state.copyWith(
          sendingMessage: true,
        );
        await Api().message(event.roomId, event.message);
        yield state.copyWith(
          sendingMessage: false,
        );
      } catch (e, stack) {
        l('mapEventToState', e, stack);
        yield state.copyWith(
          sendingMessage: false,
        );
      }
    }

    if (event is ChatDataReceived) {
      final data = jsonDecode(event.data);
      l('mapEventToState', data);
      final type = data['event'];
    }

    if (event is EnterRoom) {
      Api().joinRoom(event.roomId);
    }

    if (event is LeaveRoom) {
      Api().joinRoom(event.roomId);
    }
  }
}
