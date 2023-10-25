import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/update_profile_screen.dart';

import '../constans/constats.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    user!.cover)),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                  user!.profile))),
                    ),
                  ],
                ),
              ),
              Text(
                user!.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                user!.bio,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'POST',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Reels',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text('90', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Follower',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text('1240', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Followings',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        '541',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            minimumSize: Size.fromHeight(30)),
                        onPressed: () {},
                        child: Text('Add Photo',style: TextStyle(fontSize: 15),),
                      )
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      minimumSize: Size(10, 30)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(),));
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
