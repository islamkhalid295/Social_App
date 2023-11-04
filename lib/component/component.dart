import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/chat_detailes_screen.dart';

void toast(String messange, Color color) {
  Fluttertoast.showToast(
      msg: messange,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget BuildNewsItem(
    context, QueryDocumentSnapshot<Map<String, dynamic>> posts, int index) {
  var commentController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.only(top: 3.0, left: 8, right: 8),
    child: Column(
      children: [
        Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(posts.get('image')),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts.get('name'),
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(posts.get('dateTimw'),
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myDivider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(posts.get('text')),
                ),
                if (posts.get('postImage') != '')
                  Stack(
                    children: <Widget>[
                      Image.network(
                        posts.get('postImage'),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null)
                            return Shimmer.fromColors(
                              baseColor: Colors.amber.withAlpha(20),
                              highlightColor: Colors.amber.shade50,
                              child: Icon(
                                IconBroken.Image,
                                size: 200,
                              ),
                            );
                          else
                            return Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                posts.get('postImage'),
                              ),
                            );
                        },
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${Appcubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Spacer(),
                      Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '5.8 M',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: myDivider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(user.profile),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Appcubit.get(context).comments != null;
                            Appcubit.get(context).getPostComments(posts.id);
                            Appcubit.scaffoldKey.currentState
                                ?.showBottomSheet((context) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10.0,
                                        right: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30,
                                          child: Container(
                                            child: Icon(Icons.more_horiz,size: 30,),
                                          ),
                                          ),
                                          Expanded(
                                            child: BlocConsumer<Appcubit, AppStates>(
                                              listener: (context, state) {},
                                              builder: (context, state) {
                                                return ConditionalBuilderRec(
                                                  condition: Appcubit.get(context).comments != null,
                                                  fallback: (context) => Center(
                                                      child: CircularProgressIndicator()),
                                                  builder: (context) {
                                                    return ListView.builder(
                                                      addAutomaticKeepAlives: true,
                                                      itemBuilder: (context, index) => BuildComment(context, Appcubit.get(context).comments!.elementAt(index)),
                                                      itemCount: Appcubit.get(context).comments!.length,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            elevation: 5,
                                            shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: Colors.amber)),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: Row(
                                              children: [
                                                // Icon(Icons.comment,
                                                //     color: Colors.grey),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: TextFormField(
                                                            maxLines: 5,
                                                            minLines: 1,
                                                            controller:
                                                                commentController,
                                                            decoration:
                                                                InputDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      400]),
                                                              hintText:
                                                                  'write your comment ...',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Appcubit.get(context)
                                                        .addComment(
                                                            commentController
                                                                .text,
                                                            posts.id);
                                                    commentController.text = '';
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
                                    ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(' Write a comment ...   ',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Appcubit.get(context).likePost(posts.id);
                        },
                        icon: Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconBroken.Send,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget BuildComment(
        context, QueryDocumentSnapshot<Map<String, dynamic>> comment) =>
    Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(comment['userImage']),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
                color: Colors.grey[300]?.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment['userName'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      comment['comment'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget BuildChatItem(
        context, QueryDocumentSnapshot<Map<String, dynamic>> chatUser) =>
    Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          Appcubit.get(context).messages = [];
          Appcubit.get(context).getMessages(chatUser.id);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatDetailesScreen(chatUser);
          }));
        },
        child: Row(
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
    );
