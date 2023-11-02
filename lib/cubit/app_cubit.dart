import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/main.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_screen.dart';
import 'package:social_app/modules/feed_screen.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/modules/users_screen.dart';

import '../component/component.dart';
import '../constans/constats.dart';
import '../modules/settings_screen.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit(super.initialState);

  int currentIndex = 0;

  static Appcubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    NewPostScreen(),
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

  void changeNavBarState(int index, context) {
    if (index == 1) getUsers();
    if (index != 2)
      currentIndex = index;
    else
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPostScreen(),
          ));
    emit(NavBarChangeState());
  }

  void updateProfileData(String uId, Map<Object, Object?> data) {
    emit(updateProfileDataLodingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(data)
        .then((value) {
      emit(updateProfileDataSuccessState());
      toast('تم تعديل البيانات بنجاح', Colors.green);
      getUser(uId);
    }).catchError((error) {
      toast(error.toString(), Colors.red);
      print(error);
      emit(updateProfileDataErrorState());
    });
  }

  late File image;

  Future<void> updateProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      FirebaseStorage.instance
          .ref()
          .child('user/${Uri.file(image.path).pathSegments.last}')
          .putFile(image)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          print(value.toString());
          updateProfileData(uId!, {
            'profile': value.toString(),
          });
          user?.profile = value.toString();
        }).catchError((error) {
          print(error);
        });
      });
    }
  }

  Future<void> updateCoverImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      FirebaseStorage.instance
          .ref()
          .child('user/${Uri.file(image.path).pathSegments.last}')
          .putFile(image)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          print(value.toString());
          updateProfileData(uId!, {
            'cover': value.toString(),
          });
          user.cover = value.toString();
        }).catchError((error) {
          print(error);
        });
      });
    }
  }

  String? postImage;

  Future<void> getPostImage() async {
    emit(GetPostImageLodingState());
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File Image = File(pickedFile.path);
      FirebaseStorage.instance
          .ref()
          .child('post/${Uri.file(Image.path).pathSegments.last}')
          .putFile(Image)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          print(value.toString());
          postImage = value.toString();
          emit(GetPostImageSuccessState());
        }).catchError((error) {
          emit(GetPostImageErrorState());
          print(error);
        });
      });
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> posts = [];

  void addPost(String text, String postImage) {
    emit(AddNewPostLodingState());
    FirebaseFirestore.instance.collection('posts').add({
      'image': user.profile,
      'name': user.name,
      'text': text,
      'postImage': postImage,
      'dateTimw': DateTime.now().toString(),
      'uId': user.uId,
    }).then((value) {
      getPosts();
      emit(AddNewPostSuccessState());
    });
  }

  List<Future<int>> likes = [];

  void getPosts() {
    emit(GetPostsLodingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      posts = value.docs;
      getPostsLikes().then((value) {
        likes = value;
      });
      //print(value.docs[0].get('text'));
      //print(value.docs[0].id);
    }).then((value) {
      print(likes.length);
      emit(GetPostsSuccessState());
    });
  }

  void refrashImage() {
    emit(RefrashImageState());
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(user.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    });
  }

  Future<List<Future<int>>> getPostsLikes() async {
    return posts.map((post) async {
      int likesCount = await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .collection('likes')
          .get()
          .then((value) => value.docs.length);

      return likesCount;
    }).toList();
  }

  static var scaffoldKey = GlobalKey<ScaffoldState>();

  void addComment(String text, String postId) {
    emit(AddNewCommentLodingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'comment': text,
      'userName': user.name,
      'userImage': user.profile,
    }).then((value) {
      emit(AddNewCommentSuccessState());
      getPostComments(postId);
    });
  }

  Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>? comments;

  void getPostComments(String postId) {
    emit(GetPostCommentsLodingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      comments = value.docs.reversed;
      emit(GetPostCommentsSuccessState());
    });
  }

  static Widget changeIcon() {
    bool love = false;
    if (!love) {
      love = !love;
      return Icon(
        Icons.favorite,
        color: Colors.red,
        size: 20,
      );
    } else {
      Icon(
        Icons.favorite_border,
        color: Colors.red,
        size: 20,
      );
    }
    // return love ? Icon(
    //   Icons.favorite,
    //   color: Colors.red,
    //   size: 20,
    // ) : Icon(
    //   Icons.favorite_border,
    //   color: Colors.red,
    //   size: 20,
    // );
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];

  void getUsers() {
    emit(GetUsersLodingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      users = value.docs;
    }).then((value) {
      emit(GetUsersSuccessState());
    });
  }

  void addMessage(String text, String reciverId) {
    emit(AddMessageLodingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('message')
        .add({
      'message': text,
      'sender_id': user.uId,
      'reciver_id': reciverId,
      'date_time': DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(reciverId)
          .collection('chats')
          .doc(user.uId)
          .collection('message')
          .add({
        'message': text,
        'sender_id': user.uId,
        'reciver_id': reciverId,
        'date_time': DateTime.now(),
      }).then((value) {
        emit(AddMessageSuccessState());
      });
    });
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> messages = [];

  void getMessages(String friendId) {
    emit(GetMessageLodingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uId)
        .collection('chats')
        .doc(friendId)
        .collection('message')
        .get().then((value) {
          messages = value.docs;
          emit(GetMessageSuccessState());
    });
  }
}
