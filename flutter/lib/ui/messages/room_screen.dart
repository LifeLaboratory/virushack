import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:palliative_chat/blocs/chat/bloc.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:palliative_chat/repository/models/message.dart';
import 'package:palliative_chat/repository/models/room.dart';
import 'package:palliative_chat/ui/common/base_screen.dart';
import 'package:palliative_chat/ui/common/input.dart';
import 'package:palliative_chat/ui/common/placeholder.dart';
import 'package:palliative_chat/ui/common/texts.dart';
import 'package:palliative_chat/util/log.dart';

const photoUrl = 'https://randomuser.me/api/portraits/women/8.jpg';

class RoomScreen extends StatefulBaseScreen {
  ///
  final Room room;

  ///
  RoomScreen({
    Key key,
    this.room,
  }) : super(key: key);

  @override
  _RoomState createState() => new _RoomState();
}

class _RoomState extends BaseState<RoomScreen> {
  ///
  var _interlocutorName = "";
  var _scrollController = ScrollController();
  var _inputController = TextEditingController();
  var _focus = new FocusNode();
  var _sendButtonEnabled = false;

  //var _showNoMessages = true;
  var _messageText = '';

  ///
  _RoomState();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        Future.delayed(Duration(milliseconds: 100), () => scrollToBottom());
      }
    });
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _presenter.onScrolledToBottom();
      } else {
        _presenter.onScrolledUpper();
      }
    });*/
  }

  ///
  @override
  Widget build(BuildContext context) {
    l('build', 'room screen');
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        l('build', 'messages', '${state.messages}');
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: state.messages == null || state.messages.isEmpty
                        ? MyPlaceholder(
                            icon: Icons.chat,
                            text: 'Ваше сообщение будет первым',
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.only(
                              top: AppSize.paddingSmall,
                              bottom: 64.0,
                            ),
                            itemBuilder: (context, index) {
                              var message = state.messages[index];
                              return MessageItem(message: message);
                            },
                            itemCount: state.messages?.length ?? 0,
                          ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: Container(
                  color: Colors.white.withOpacity(0.95),
                  padding: EdgeInsets.only(
                    top: 6.0,
                    bottom: 8.0,
                    left: 8.0,
                    right: 6.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Input(
                          controller: _inputController,
                          textColor: Colors.black,
                          focusNode: _focus,
                          onChanged: (s) => setState(() => _messageText = s),
                        ),
                      ),
                      Padding(
                        padding: AppPadding.leftSmall,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            buttonTheme: ButtonTheme.of(context).copyWith(
                              minWidth: 10.0,
                            ),
                          ),
                          child: RaisedButton(
                            padding: AppPadding.allMedium,
                            shape: CircleBorder(),
                            color: AppColors.green,
                            disabledColor: Colors.grey,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onPressed:
                                _messageText != null && _messageText.isNotEmpty
                                    ? () {
                                        sendEvent<ChatBloc>(
                                          context,
                                          SendMessage(
                                            _messageText,
                                            state.room.roomId,
                                          ),
                                        );
                                        _inputController.clear();
                                      }
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  jumpToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    });
  }

  @override
  disableSendButton() {
    setState(() => _sendButtonEnabled = false);
  }

  @override
  enableSendButton() {
    setState(() => _sendButtonEnabled = true);
  }
}

class MessageItem extends StatelessWidget {
  ///
  static var dateFormat = DateFormat('hh:mm a');

  ///
  final Message message;

  ///
  const MessageItem({this.message});

  ///
  @override
  Widget build(BuildContext context) {
    //L.i("build");

    final isMine = true;

    return Padding(
      padding: AppPadding.exceptBottomNormal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMine == null)
            _userIcon(
              photoUrl /*message.photoUrl*/,
              right: false,
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 240.0,
              minWidth: 0.0,
              maxHeight: double.infinity,
              minHeight: 0.0,
            ),
            decoration: _decoration(),
            child: message.text.length > 10
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: AppPadding.exceptBottomMedium,
                        child: Texts.black(message.text),
                      ),
                      Padding(
                        padding: AppPadding.allMicro,
                        child: _stateAndTime(message),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: AppPadding.allMedium,
                        child: Texts.black(message.text),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: _stateAndTime(message),
                      ),
                    ],
                  ),
          ),
          if (isMine != null)
            _userIcon(
              photoUrl,
              right: true,
            ),
        ],
      ),
    );
  }

  ///
  _userIcon(String photoUrl, {bool right}) {
    return Padding(
      padding: right ? AppPadding.leftSmall : AppPadding.rightSmall,
      child: CircleAvatar(
        backgroundColor: AppColors.greyLight,
        radius: 20.0,
        backgroundImage: NetworkImage(photoUrl),
      ),
    );
  }

  _rounded() {
    return const Radius.circular(6.0);
  }

  _sharp() {
    return const Radius.circular(6.0);
  }

  _decoration() {
    return BoxDecoration(
      color: Colors.green[100],
      borderRadius: new BorderRadius.only(
        topLeft: _rounded(),
        topRight: _rounded(),
        bottomRight: _sharp(),
        bottomLeft: _rounded(),
      ),
    );
    /*return BoxDecoration(
      color: info.isMine ? AppColors.greenWhite40 : AppColors.greyLightVery,
      borderRadius: new BorderRadius.only(
        topLeft: _rounded(),
        topRight: _rounded(),
        bottomRight: info.isMine ? _sharp() : _rounded(),
        bottomLeft: info.isMine ? _rounded() : _sharp(),
      ),
    );*/
  }

  _stateAndTime(Message message) {
    return Container();
    /*return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        info.isMine
            ? Texts.text(
                dateFormat.format(info.time),
                color: AppColors.fontSecondaryBlack,
                size: 11.0,
              )
            : Texts.text(
                dateFormat.format(info.time),
                color: AppColors.fontSecondaryBlack,
                size: 11.0,
              ),
        Padding(
          padding: AppPadding.allZero,
          child: MessageUtil.stateIcon(info.state),
        ),
      ],
    );*/
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: AppColors.green,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
