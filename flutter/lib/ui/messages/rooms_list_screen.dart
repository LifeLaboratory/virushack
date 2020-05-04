import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:palliative_chat/blocs/chat/bloc.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:palliative_chat/repository/models/room.dart';
import 'package:palliative_chat/ui/common/base_screen.dart';
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
  //int _selectedRoomId;
  Room _selectedRoom;

  //
  @override
  Widget build(BuildContext context) {
    l('build', 'rooms list');
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _selectedRoom == null ? 'Общение' : _selectedRoom.title,
            ),
            leading: _selectedRoom != null
                ? IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
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

    return ListView.builder(
      padding: AppPadding.allZero,
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
  ///
  static var todayTimeFormat = DateFormat("hh:mm a");
  static var generalDateFormat = DateFormat("dd MMM");
  static const unreadMessagesIndicatorSize = 20.0;

  ///
  final Room room;
  final Function() onPressed;

  ///
  const RoomItem({
    this.room,
    this.onPressed,
  });

  ///
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            new Padding(
              padding: AppPadding.allNormal,
              child: CircleAvatar(
                backgroundColor: AppColors.greyLight,
                radius: 10.0,
                backgroundImage: NetworkImage(
                  "http://via.placeholder.com/100x100",
                ),
              ),
            ),
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts(room.title),
                  Row(
                    children: [
                      Padding(
                        padding: AppPadding.rightMicro,
                        child:
                            Container() /*MessageUtil.stateIcon(
                          room.lastMessageState,
                          size: 20.0,
                        )*/
                        ,
                      ),
                      Expanded(
                        child: _lastMessageText(room),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: AppPadding.rightNormal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Texts.secondaryBlackSmall(
                    _getTimeString(room.lastMessageTime),
                  ),
                  _unreadMessagesIndicator(
                    room.unreadMessagesCount,
                  )
                ],
              ),
            )*/
          ],
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
      room.messages.last.text,
      overflow: TextOverflow.ellipsis,
    );
  }
}
