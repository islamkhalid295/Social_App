import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/main.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_screen.dart';
import 'package:social_app/modules/feed_screen.dart';
import 'package:social_app/modules/users_screen.dart';

import '../constans/constats.dart';
import '../modules/settings_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit(super.initialState);

  int currentIndex = 0;

  static Appcubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> images = [
    'https://img.resized.co/breaking-news/eyJkYXRhIjoie1widXJsXCI6XCJodHRwczpcXFwvXFxcL2ltYWdlcy5icmVha2luZ25ld3MuaWVcXFwvcHJvZFxcXC91cGxvYWRzXFxcLzIwMjNcXFwvMTBcXFwvMTMxOTM0MjVcXFwvR2V0dHlJbWFnZXMtMTcxOTQ5NDA0My1lMTY5NzIyMjEwNzI1NC5qcGdcIixcIndpZHRoXCI6bnVsbCxcImhlaWdodFwiOjM2MCxcImRlZmF1bHRcIjpcImh0dHBzOlxcXC9cXFwvd3d3LmJyZWFraW5nbmV3cy5pZVxcXC9pbWFnZXNcXFwvbm8taW1hZ2UucG5nXCIsXCJvcHRpb25zXCI6e1wib3V0cHV0XCI6XCJqcGVnXCJ9fSIsImhhc2giOiI2Yjc4MjEzMDI3YzRjMWZmM2YxY2IzNDYxOGQ2NjY1ZDY1NjVlYTQwIn0=',
    'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/newscms/2021_19/3472341/ss-210512-isael-palestinians-01.JPG',
    'https://ichef.bbci.co.uk/news/640/cpsprodpb/2504/production/_118467490_gettyimages-1232810997.jpg',
    'https://images.skynewsarabia.com/images/v2/2023/10/11/1660929/800/450/1-1660929.jpg',
    'https://almsaeyimages.akhbarelyom.com/UP/20231013201720186.jpg',
    'https://mohammy.com/wp-content/uploads/2023/10/32356609-1696922534.jpg',
    'https://ebd3.net/wp-content/uploads/2023/10/32348939-1696843351.jpg',
    'https://ebd3.net/wp-content/uploads/2023/10/32348939-1696843351.jpg',
    'https://gumlet.assettype.com/sabq%2F2023-10%2Fa1033cd7-2835-4264-bf2a-35a2375054c2%2F1.jpg?auto=format%2Ccompress&fit=max&w=1200',
    'https://www.alaraby.com/sites/default/files/2023-10/AA-20231017-32435110-32435100-SH_GZ_500_SHHYD_THR_QSF_SRYYLY_LMSTSHF_LMMDNY.jpg',
  ];

  void getUser(String uId) {
    emit(LodingGetUserState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      user = UserModel.fromjson(value.data());
      emit(GetUserDataSucssesState());
    }).catchError((error) {
      emit(GetUserDataErorrState(error));
    });
  }

  void changeNavBarState(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
  }

  void updateProfileData(String uId, Map<Object, Object?> data) {
    emit(updateProfileDataLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).update(data).then((value) {
      emit(updateProfileDataSuccessState());
      getUser(uId);
    }).catchError((error){
      print(error);
      emit(updateProfileDataErrorState());
    });
  }
  late File image;

  Future<void> updateProfileImage() async
  {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
      {
        image = File(pickedFile.path);
        FirebaseStorage.instance.ref().child('user/${Uri.file(image.path).pathSegments.last}').putFile(image).then((p0){
          p0.ref.getDownloadURL().then((value) {
            print(value.toString());
            updateProfileData(uId!,{
              'profile' : value.toString(),
            });
            user?.profile = value.toString();
          }).catchError((error){
            print(error);
          });
        });
      }
  }
  Future<void> updateCoverImage() async
  {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      image = File(pickedFile.path);
      FirebaseStorage.instance.ref().child('user/${Uri.file(image.path).pathSegments.last}').putFile(image).then((p0){
        p0.ref.getDownloadURL().then((value) {
          print(value.toString());
          updateProfileData(uId!,{
            'cover' : value.toString(),
          });
          user?.profile = value.toString();
        }).catchError((error){
          print(error);
        });
      });
    }
  }
}
