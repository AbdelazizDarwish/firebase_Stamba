import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireb1/chat_screen.dart';
import 'package:fireb1/component/color.dart';
import 'package:fireb1/cubit/cubit/chatapp_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    GetData();
    super.initState();
  }

  SendData() {
    firestore.collection('Notes').add({
      'note': sentController.text,
    }).then((value) => print("Send Data $value"));
  }

  GetData() {
    Stream:
    firestore.collection('Notes').snapshots();
  }

  final firestore = FirebaseFirestore.instance;
  TextEditingController sentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              //backgroundImage: NetworkImage('${cubit.registerUser.photoUrl}'),
              child: Image.asset('lib/image/downloads.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 14,
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.white,
                ),
              )),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 14,
              child: Icon(
                Icons.edit,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 10,
                ),
                Text('Search'),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: cubit.AllUsers.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        name: '${cubit.AllUsers[index].name}',
                        index: index,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage('${cubit.AllUsers[index].photoUrl}'),
                        backgroundColor: Colors.transparent,
                        child: Image.asset('lib/image/downloads.png'),
                      ),
                      Text('${cubit.AllUsers[index].name}'),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(bottom: 1.0, end: 1),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
