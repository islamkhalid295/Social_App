import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/component.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/network/local/cache_helper.dart';

import '../layout/home_layout.dart';


class LoginCubit extends Cubit<AppStates> {
  LoginCubit(super.initialState);



  static LoginCubit get(context) => BlocProvider.of(context);

  void login(String email, String password, BuildContext context) {
    emit(LodingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      toast('تم تسجيل الدخول بنجاح', Colors.green);
      CacheHelper.sharedPreferences.setString('uId',value.user!.uid);
      Appcubit.get(context).getUser(value.user!.uid);
      user.uId = value.user!.uid;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout(),));
      emit(LoginSucssesState());
    });

  }

  void register(String name, String email, String password, String phone, BuildContext context) {
    emit(LodingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      toast('تم تسجيل الدخول بنجاح', Colors.green);
      createser(name,email,phone,value.user!.uid,context);
      emit(RegisterSucssesState());
    }).catchError((error){
      toast(error.toString(), Colors.red);
      emit(RegisterErorrState(error));
    });

  }
  String defaultProfile = 'https://mc.webpcache.epapr.in/mcms.php?size=medium&in=https://mcmscache.epapr.in/post_images/website_350/post_15704806/thumb.jpg';
  String defaultCover = 'https://mc.webpcache.epapr.in/mcms.php?size=medium&in=https://mcmscache.epapr.in/post_images/website_350/post_15704806/thumb.jpg';
  void createser(String name, String email, String phone,String uId,BuildContext context) {
    user = UserModel(name, email, phone, uId, defaultProfile, defaultCover,"Bio...");
    CacheHelper.sharedPreferences.setString('uId',uId);
    emit(CreateUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).set(
      user!.toMap()).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout(),));
      emit(CreateUserSucssesState());
    });
  }



}
