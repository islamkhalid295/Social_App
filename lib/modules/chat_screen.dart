import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';

import '../component/component.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Appcubit cubit = Appcubit.get(context);
    return BlocConsumer<Appcubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        print(cubit.users.length);
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ConditionalBuilderRec(
              condition: cubit.users.length > 0,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>  BuildChatItem(context,cubit.users[index]),
                separatorBuilder: (context, index) =>  myDivider(),
                itemCount: cubit.users.length,
              ),
            )
        );
      },
    );
  }
}
