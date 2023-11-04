import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/states.dart';
import '../component/component.dart';
import '../cubit/app_cubit.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Appcubit cubit = Appcubit.get(context);
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
               condition: cubit.posts.isNotEmpty && cubit.likes.length == cubit.posts.length,
                fallback: (context) => Center(child: CircularProgressIndicator()),
                builder: (context) => ListView.builder(
                  itemBuilder: (context, index) =>  BuildNewsItem(context,cubit.posts[index],index),
                  itemCount: cubit.posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
