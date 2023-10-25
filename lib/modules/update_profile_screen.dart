import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/main.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  var bioController = TextEditingController(text: user?.bio);
  var nameController = TextEditingController(text: user?.name);
  var phoneController = TextEditingController(text: user?.phone);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        Appcubit cubit = Appcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            actions: [
              TextButton(onPressed: (){
                cubit.updateProfileData(uId!,{
                  'name': nameController.text,
                  'bio': bioController.text,
                  'phone': phoneController.text,
                });
              }, child: Text('UPDATE'))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
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
                              CircleAvatar(
                                radius: 15,
                                child: IconButton(onPressed: (){
                                  cubit.updateCoverImage();
                                },
                                    icon: Icon(IconBroken.Camera,size: 15,)),
                              ),
                            ],
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        CircleAvatar(
                            radius: 60,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                    radius: 55,
                                    backgroundImage: NetworkImage(
                                        user!.profile)),
                                CircleAvatar(
                                  radius: 15,
                                  child: IconButton(onPressed: (){
                                    cubit.updateProfileImage();
                                  },
                                      icon: Icon(IconBroken.Camera,size: 15,)),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.orange.shade300),
                      icon: const Icon(
                        IconBroken.User,
                      ),
                      border: const OutlineInputBorder(
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bio can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      labelText: 'Bio',
                      labelStyle: TextStyle(color: Colors.orange.shade300),
                      icon: const Icon(
                        IconBroken.Document,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.orange.shade300),
                      icon: const Icon(
                        IconBroken.Call,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
