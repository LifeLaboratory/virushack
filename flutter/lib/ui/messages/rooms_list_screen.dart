import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:palliative_chat/blocs/chat/bloc.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:palliative_chat/repository/models/room.dart';
import 'package:palliative_chat/ui/common/base_screen.dart';
import 'package:palliative_chat/ui/common/my_divider.dart';
import 'package:palliative_chat/ui/common/placeholder.dart';
import 'package:palliative_chat/ui/common/texts.dart';
import 'package:palliative_chat/util/log.dart';

import 'room_screen.dart';

class RoomsListScreen extends StatefulBaseScreen {
  RoomsListScreen({Key key}) : super(key: key);

  @override
  _RoomsListState createState() => new _RoomsListState();
}

class _RoomsListState extends BaseState<RoomsListScreen> {
  //
  Room _selectedRoom;

  //
  @override
  Widget build(BuildContext context) {
    l('build', 'rooms list');
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Texts.appBarTitle(
              _selectedRoom == null ? 'Общение' : _selectedRoom.title,
            ),
            leading: _selectedRoom != null
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      sendEvent<ChatBloc>(
                          context, LeaveRoom(_selectedRoom.roomId));
                      setState(() => _selectedRoom = null);
                    },
                  )
                : null,
          ),
          body: Container(
            color: Colors.white,
            child: _content(state),
          ),
        );
      },
    );
  }

  //
  Widget _content(ChatState state) {
    l('_content');
    if (state.rooms == null || state.rooms.isEmpty) {
      return MyPlaceholder(
        icon: Icons.chat_bubble_outline,
        text: "Групп нет",
      );
    }

    if (_selectedRoom != null) {
      l('_content', '_selectedRoomId', '$_selectedRoom');
      return WillPopScope(
        onWillPop: () async {
          if (_selectedRoom != null) {
            setState(() => _selectedRoom = null);
            return false;
          } else {
            return true;
          }
        },
        child: RoomScreen(
          room: state.rooms.firstWhere(
            (r) => r.roomId == _selectedRoom.roomId,
            orElse: () => null,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: AppPadding.allZero,
      separatorBuilder: (c, i) => MyDivider.horizontalTen(),
      itemBuilder: (context, index) {
        var room = state.rooms[index];
        return RoomItem(
          room: room,
          onPressed: () {
            l('_content', 'set selected room id', '${room.roomId}');
            setState(() => _selectedRoom = room);
          },
        );
      },
      itemCount: state.rooms.length,
    );
  }
}

class RoomItem extends StatelessWidget {
  //
  static var todayTimeFormat = DateFormat("hh:mm a");
  static var generalDateFormat = DateFormat("dd MMM");
  static const unreadMessagesIndicatorSize = 20.0;

  //
  final Room room;
  final Function() onPressed;

  //
  const RoomItem({
    this.room,
    this.onPressed,
  });

  //
  @override
  Widget build(BuildContext context) {
    final newMessages = Random().nextInt(20);

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 70.0,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: AppPadding.rightNormal,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Texts.bold(room.title),
                    Row(
                      children: [
                        Expanded(
                          child: _lastMessageText(room),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (newMessages > 0)
                Padding(
                  padding: AppPadding.rightNormal,
                  child: Container(
                    padding: AppPadding.horizontalMicro,
                    alignment: Alignment.center,
                    height: 16.0,
                    constraints: BoxConstraints(
                      minWidth: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Texts(
                      newMessages.toString(),
                      textSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /*String _getTimeString(String date) {
    var now = DateTime.now();
    var todayMidnight = DateTime(now.year, now.month, now.day, 0, 0, 0);
    var yesterdayMidnight = DateTime(now.year, now.month, now.day - 1, 0, 0, 0);
    var dateTime = MessageUtil.stringToDate(date);
    if (dateTime.isAfter(todayMidnight)) {
      return todayTimeFormat.format(dateTime);
    } else if (dateTime.isAfter(yesterdayMidnight)) {
      return "YESTERDAY";
    } else {
      return generalDateFormat.format(dateTime);
    }
  }*/

  Widget _unreadMessagesIndicator(int unreadMessagesCount) {
    if (unreadMessagesCount == 0) {
      return Container(
        width: unreadMessagesIndicatorSize,
        height: unreadMessagesIndicatorSize,
      );
    } else {
      return Container(
        margin: AppPadding.topSmall,
        alignment: Alignment.center,
        width: unreadMessagesIndicatorSize,
        height: unreadMessagesIndicatorSize,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.green,
        ),
        child: Texts(unreadMessagesCount.toString(), textSize: 11.0),
      );
    }
  }

  Widget _lastMessageText(Room room) {
    return Texts.secondaryBlack(
      '',

      ///room.messages?.last?.text ?? '',
      overflow: TextOverflow.ellipsis,
    );
  }
}
