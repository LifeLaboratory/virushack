import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palliative_chat/repository/models/message.dart';

class MessageUtil {
  ///
  static var format = DateFormat("hh:mm:ss dd-MM-yyyy");

  ///
  static DateTime getSentDate(Message message) {
    return DateTime.fromMillisecondsSinceEpoch(message.createdAt);
  }

  static int compareBySentDates(Message m1, Message m2) {
    return getSentDate(m1).compareTo(getSentDate(m2));
  }

  static String dateToString(DateTime date) {
    return format.format(date);
  }

  static DateTime stringToDate(String date) {
    return format.parse(date);
  }

  static Widget stateIcon(String messageState, {double size = 14.0}) {
    IconData iconData;
    Color iconColor;

    /*switch (messageState) {
      case MessageState.received:
        iconData = Icons.done;
        iconColor = AppColors.fontSecondaryBlack;
        break;
      case MessageState.read:
        iconData = Icons.done_all;
        iconColor = AppColors.lightBlue;
        break;
      case MessageState.sent:
      default:
        iconData = Icons.timer;
        iconColor = AppColors.fontSecondaryBlack;
        break;
    }*/

    return Icon(
      iconData,
      color: iconColor,
      size: size,
    );
  }
}
