import 'dart:convert';

import 'package:flutter/material.dart';

class MessageModel {
  final String sender;
  final String receiver;
  final String txt;

  final String dateTime;

  MessageModel({
    required this.sender,
    required this.receiver,
    required this.dateTime,
    required this.txt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'sender': sender});
    result.addAll({'receiver': receiver});
    result.addAll({'txt': txt});
    result.addAll({'date_time': dateTime});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      txt: map['txt'] ?? '',
      dateTime: map['date_time'] ?? '',
    );
  }
}
