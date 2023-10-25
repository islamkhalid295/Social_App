import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import '../cubit/states.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  IconData eyeIcon = Icons.visibility;
  bool showPassword = false;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(InitState()),
      child: BlocConsumer<LoginCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(backgroundColor: (Colors.orange.shade300)),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Register Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'name',
                          labelStyle: TextStyle(color: Colors.orange.shade300),
                          icon: const Icon(
                            Icons.person,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.orange.shade300),
                          icon: const Icon(
                            Icons.email_outlined,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: !showPassword,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).login(
                              emailController.text,
                              passwordController.text,
                              context,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(eyeIcon),
                              onPressed: () {
                                setState(() {
                                  showPassword
                                      ? eyeIcon = Icons.visibility
                                      : eyeIcon = Icons.visibility_off;
                                  showPassword = !showPassword;
                                });
                              }),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.orange.shade300),
                          icon: const Icon(
                            Icons.password_rounded,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'phone can\'t be empty';
                          } else {
                            return null;
                          }
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Colors.orange.shade300),
                          icon: const Icon(
                            Icons.phone,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: ConditionalBuilderRec(
                          condition: state is! LodingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).register(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    phoneController.text,
                                    context);
                              }
                            },
                            color: Colors.orange.shade300,
                            child: const Text('REGISTER',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: Colors.orange.shade300,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
