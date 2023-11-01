import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constans/constats.dart';
import 'package:social_app/cubit/bloc_observer.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';

import 'cubit/app_cubit.dart';
import 'cubit/states.dart';
late Widget myPage;
String? uId;
Future <void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  uId = CacheHelper.sharedPreferences.getString('uId');
  await Firebase.initializeApp();

  if (uId != null) {
    myPage = HomeLayout();
  } else
    myPage = LoginScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Appcubit(InitState())..getUser(uId!)..getPosts(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          textTheme: TextTheme(labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.grey,
          ),),
          appBarTheme: AppBarTheme(
              color: Colors.amber.withAlpha(20)
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(color: Colors.amber),
            selectedLabelStyle: TextStyle(color: Colors.amber),
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            unselectedIconTheme: IconThemeData(color: Colors.grey),

          ),
          useMaterial3: true,
        ),
        home: myPage,
      ),
    );
  }
}

