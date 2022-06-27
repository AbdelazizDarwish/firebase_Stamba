// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';

class MessageModel {
  String? title;
  String? senderId;
  String? receiverId;
  String? messageId;
  DateTime? time;
  MessageModel(
      {this.title, this.senderId, this.receiverId, this.messageId, this.time});
  static MessageModel fromJson(Map<String, dynamic> map) {
    MessageModel messageModel = MessageModel(
        title: map['title'],
        senderId: map['senderId'],
        receiverId: map['receiverId'],
        messageId: map['messageId'],
        time: map['time'].toDate());
    return messageModel;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': title,
      'senderId': senderId,
      'receiverId': receiverId,
      'time': time,
    };
    return json;
  }

  // MessageModel({
  //   this.title,
  //   this.senderId,
  //   this.receiverId,
  //   this.messageId,
  //   this.time,
  // });

  // MessageModel copyWith({
  //   String? title,
  //   String? senderId,
  //   String? receiverId,
  //   String? messageId,
  //   DateTime? time,
  // }) {
  //   return MessageModel(
  //     title: title ?? this.title,
  //     senderId: senderId ?? this.senderId,
  //     receiverId: receiverId ?? this.receiverId,
  //     messageId: messageId ?? this.messageId,
  //     time: time ?? this.time,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'title': title,
  //     'senderId': senderId,
  //     'receiverId': receiverId,
  //     'messageId': messageId,
  //     'time': time?.millisecondsSinceEpoch,
  //   };
  // }

  // factory MessageModel.fromMap(Map<String, dynamic> map) {
  //   return MessageModel(
  //     title: map['title'] != null ? map['title'] as String : null,
  //     senderId: map['senderId'] != null ? map['senderId'] as String : null,
  //     receiverId:
  //         map['receiverId'] != null ? map['receiverId'] as String : null,
  //     messageId: map['messageId'] != null ? map['messageId'] as String : null,
  //     time: map['time'] != null
  //         ? DateTime.fromMillisecondsSinceEpoch(map['time'] as int)
  //         : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory MessageModel.fromJson(String source) =>
  //     MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'MessageModel(title: $title, senderId: $senderId, receiverId: $receiverId, messageId: $messageId, time: $time)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is MessageModel &&
  //       other.title == title &&
  //       other.senderId == senderId &&
  //       other.receiverId == receiverId &&
  //       other.messageId == messageId &&
  //       other.time == time;
  // }

  // @override
  // int get hashCode {
  //   return title.hashCode ^
  //       senderId.hashCode ^
  //       receiverId.hashCode ^
  //       messageId.hashCode ^
  //       time.hashCode;
  // }

}
