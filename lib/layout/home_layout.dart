import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/component/component.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';

import '../modules/settings_screen.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Appcubit cubit = Appcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News Feed'),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
              IconButton(
                  onPressed: () {}, icon: Icon(IconBroken.Notification)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home, color: defaultColor),
                    label: "Feeds"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat, color: defaultColor),
                    label: "Chats"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location, color: defaultColor),
                    label: "Users"),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting, color: defaultColor),
                  label: "Settings",
                ),
              ],
              onTap: (value) {
                cubit.changeNavBarState(value);
              },
              currentIndex: cubit.currentIndex),
        );
      },
    );
  }
}
