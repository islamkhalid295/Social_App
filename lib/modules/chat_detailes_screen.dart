import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/app_cubit.dart';

class ChatDetailesScreen extends StatelessWidget {
  ChatDetailesScreen(this.chatUser, {super.key});
  var messageController = TextEditingController();
  QueryDocumentSnapshot<Map<String, dynamic>> chatUser;

  @override
  Widget build(BuildContext context) {
    Appcubit cubit = Appcubit.get(context);
    print("Messages len : ${cubit.messages.length}");
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(chatUser.get('profile')),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              chatUser.get('name'),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) => cubit.messages[index].get('sender_id') == user.uId ? MyMessage(cubit.messages[index].get('message')) : Message(cubit.messages[index].get('message')),
                    itemCount: cubit.messages.length,
                  ))),
            Card(
              elevation: 5,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.amber)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  // Icon(Icons.comment,
                  //     color: Colors.grey),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                              maxLines: 5,
                              minLines: 1,
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'write your message ...',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                              )),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Appcubit.get(context)
                          .addMessage(messageController.text, chatUser.id);
                      messageController.text = '';
                    },
                    icon: Icon(
                      Icons.telegram_outlined,
                      color: Colors.amber,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Message(String text) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          )),
    );

Widget MyMessage(String text) => Align(
      alignment: Alignment.centerRight,
      child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          )),
    );
