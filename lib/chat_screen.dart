import 'package:fireb1/component/color.dart';
import 'package:fireb1/component/component.dart';
import 'package:fireb1/cubit/cubit/chatapp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.name, required this.index})
      : super(key: key);
  String name;
  int index;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController messageController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    ChatCubit cubit = ChatCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('${widget.name}'),
            Text('3 min ago'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          color: kSecondaryColor,
          child: Column(
            children: [
              Container(
                height: h * 0.7,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      controller: cubit.scrollController,
                      itemCount: cubit.Allmessages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          textDirection: (cubit.registerUser.id ==
                                  cubit.Allmessages[index].receiverId
                              ? TextDirection.ltr
                              : TextDirection.rtl),
                          children: [
                            Column(
                              children: [
                                Text('${cubit.Allmessages[index].title}'),
                                Text("${cubit.Allmessages[index].time}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextfieldWidget(
                        controller: messageController,
                        keyboardType: TextInputType.text,
                        label: 'Enter Message',
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        if (messageController.text.trim().length > 0) {
                          await cubit.SendMessage(
                              messageController.text, widget.index);

                          messageController.clear();
                        }
                      },
                      child: Icon(Icons.send),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
