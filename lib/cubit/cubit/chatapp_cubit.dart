import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireb1/model/message_model.dart';
import 'package:fireb1/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'chatapp_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatappInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignIn googlesingin = GoogleSignIn();
  UserModel registerUser = UserModel();
  final scrollController = ScrollController();
  var snapshot;

  List<UserModel> AllUsers = [];
  List<UserModel> user = [];
  List<MessageModel> Allmessages = [];

  ImagePicker imagePicker = ImagePicker();
  XFile? userImage;

  Image(String Cameras) async {
    if (Cameras == 'cam') {
      userImage = await imagePicker.pickImage(source: ImageSource.camera);
      return userImage?.readAsBytes();
    } else {
      userImage = await imagePicker.pickImage(source: ImageSource.gallery);
    }
  }

  registerByEmailAndPassword(String email, String password, String name) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    emit(ChatRegisterSuccess());
    registerUser.email = email;
    registerUser.name = name;
    registerUser.id = credential.user!.uid;
    emit(ChatRegisterSuccess());
    await storage
        .ref()
        .child("images/")
        .child("${registerUser.id}.jpg")
        .putFile(File(userImage!.path));
    registerUser.photoUrl = await storage
        .ref()
        .child("images/")
        .child("${registerUser.id}.jpg")
        .getDownloadURL();
    await firestore
        .collection("users")
        .doc(registerUser.id)
        .set(registerUser.toMap());
    emit(ChatCreateUserState());
    await getAllUsers();
  }

  login(String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    snapshot =
        await firestore.collection('users').doc(userCredential.user!.uid).get();
    registerUser = UserModel.fromMap(snapshot.data());
    print(registerUser.toMap());
    getAllUsers();
    // user =
    //     await auth.signInWithEmailAndPassword(email: email, password: password);
    // snapshot = await firestore.collection('users').doc(user.user.uid).get();
    // registerUser = UserModel.fromMap(snapshot.data());
  }

  getAllUsers() async {
    AllUsers = [];
    var docs = await firestore
        .collection('users')
        .where('id', isNotEqualTo: registerUser.id)
        .get();

    docs.docs.forEach((element) {
      AllUsers.add(UserModel.fromMap(element.data()));
      print(AllUsers.length);
    });
    emit(ChatGetAllUsers());
  }

  signInByGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googlesingin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential userCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    var user = await auth.signInWithCredential(userCredential);

    registerUser.id = user.user!.uid;
    registerUser.name = googleSignInAccount.displayName;
    registerUser.email = googleSignInAccount.email;
    registerUser.photoUrl = googleSignInAccount.photoUrl;

    await firestore
        .collection('users')
        .doc(registerUser.id)
        .set(registerUser.toMap());
  }

  IconData suffix = Icons.visibility_off_outlined;

  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility;
    emit(ChatChangePassword());
  }

  SendMessage(String mes, int index) async {
    MessageModel message = MessageModel(
      time: DateTime.now(),
      title: mes,
      senderId: registerUser.id,
      receiverId: user[index].id,
      messageId: '${registerUser.id}${user[index].id}',
      // receiverId: 'd',
      // messageId: 's',
    );
    Allmessages.add(message);
    await scrollController.animateTo(
        scrollController.position.maxScrollExtent + 90,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear);
    await firestore.collection('chats').doc().set(message.toJson());
  }

  getAllMessages(int index) async {
    Allmessages = [];
    await firestore
        .collection('chats')
        .where('messageId', whereIn: [
          '${registerUser.id}${user[index].id}',
          '${user[index].id}${registerUser.id}'
        ])
        .snapshots()
        .listen((event) async {
          if (Allmessages.isEmpty) {
            var message = await firestore
                .collection('chats')
                .where('messageID', whereIn: [
                  '${registerUser.id}${user[index].id}',
                  '${user[index].id}${registerUser.id}'
                ])
                .orderBy('time')
                .get();
            message.docs.forEach((element) {
              MessageModel M = MessageModel.fromJson(element.data());
              Allmessages.add(M);
            });

            emit(ChatGetAllMessagesState());
          } else {
            Allmessages.add(
                MessageModel.fromJson(event.docChanges.first.doc.data()!));
            emit(ChatGetAllMessagesState());
          }
        });
  }
}
