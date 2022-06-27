import 'package:auth_buttons/auth_buttons.dart';
import 'package:fireb1/component/color.dart';
import 'package:fireb1/component/component.dart';
import 'package:fireb1/cubit/cubit/chatapp_cubit.dart';
import 'package:fireb1/homepage.dart';
import 'package:fireb1/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    ChatCubit cubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: w,
                      height: h * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Registeration',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: kSecondaryColor),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextfieldWidget(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                label: 'Name'),
                            SizedBox(
                              height: 20,
                            ),
                            TextfieldWidget(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email',
                              validator: (value) {
                                if (value?.length == 0) {
                                  return 'Email Cannot be Empty';
                                }
                                if (RegExp("[a-z-A-Z0-9+_.-]+@[a-zA-Z-]+[a-z]")
                                    .hasMatch(value)) {
                                  return 'Please enter Valid Email';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextfieldWidget(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                ispassword: cubit.isPassword,
                                label: 'Password',
                                suffixIcon: cubit.suffix,
                                suffixPressed: () {
                                  cubit.changePassword();
                                },
                                validator: (value) {
                                  if (value?.length <= 6) {
                                    return 'password should be more than 6';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: h * 0.4,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await cubit.registerByEmailAndPassword(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text);
                                  await ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text('Successfuly Registered'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GoogleAuthButton(
                                  onPressed: () async {
                                    await ChatCubit.get(context)
                                        .signInByGoogle();
                                  },
                                  style: AuthButtonStyle(
                                    buttonType: AuthButtonType.icon,
                                    iconType: AuthIconType.secondary,
                                  ),
                                ),
                                FacebookAuthButton(
                                  onPressed: () {},
                                  style: AuthButtonStyle(
                                    buttonType: AuthButtonType.icon,
                                    iconType: AuthIconType.secondary,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                cubit.Image('cam');
                              },
                              child: Text('choose photo'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account? click to '),
                                GestureDetector(
                                  onTap: (() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()))),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
