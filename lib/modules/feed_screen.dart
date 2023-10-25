import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/component.dart';
import '../cubit/app_cubit.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Appcubit cubit = Appcubit.get(context);
    return Container(
      child: Container(
        child: SingleChildScrollView(
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
              ListView.builder(
                itemBuilder: (context, index) => BuildNewsItem(context,cubit.images[index]),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
