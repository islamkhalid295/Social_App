import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/states.dart';
import '../component/component.dart';
import '../cubit/app_cubit.dart';
import 'chat_detailes_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Appcubit cubit = Appcubit.get(context);


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailesScreen(message.data)));
      print('Got a message whilst in the foreground!');
      print('Message data : ${message.data}');
      toast('onMessage', Colors.green);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    return BlocConsumer<Appcubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                child: Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(image: NetworkImage('https://img.piri.net/piri/upload/3/2023/10/10/4ca608d1-k56wjvnaov01quf9o5b3w4.jpeg'),),
                ),
              ),
              ConditionalBuilderRec(
               condition: cubit.posts.isNotEmpty ,
                fallback: (context) => Center(child: CircularProgressIndicator()),
                builder: (context) =>  ListView.builder(
                  itemCount: cubit.posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Use FutureBuilder to await and display the like count for each post
                    return BuildNewsItem(context,cubit.posts[index],index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
