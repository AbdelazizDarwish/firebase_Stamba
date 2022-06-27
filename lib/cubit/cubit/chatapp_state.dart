part of 'chatapp_cubit.dart';

@immutable
abstract class ChatState {}

class ChatappInitial extends ChatState {}

class ChatRegisterSuccess extends ChatState {}

class ChatLogin extends ChatState {}

class ChatCreateUserState extends ChatState {}

class ChatChangePassword extends ChatState {}

class ChatGetAllUsers extends ChatState {}

class ChatGetAllMessagesState extends ChatState {}
