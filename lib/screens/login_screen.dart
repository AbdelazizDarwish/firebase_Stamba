import 'package:auth_buttons/auth_buttons.dart';
import 'package:fireb1/component/color.dart';
import 'package:fireb1/component/component.dart';
import 'package:fireb1/cubit/cubit/chatapp_cubit.dart';
import 'package:fireb1/homepage.dart';
import 'package:fireb1/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ChatCubit cubit = ChatCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: h * 0.85,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(130),
                          topRight: Radius.circular(130),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 25),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120, left: 60),
                      child: Container(
                        height: h * 0.60,
                        width: w * 0.75,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  offset: Offset(0, 3))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(90),
                                bottomRight: Radius.circular(90))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
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
                                  if (RegExp(
                                          "[a-z-A-Z0-9+_.-]+@[a-zA-Z-]+[a-z]")
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
                                  obsecureText: true,
                                  label: 'Password',
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
                                width: h * 0.2,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await cubit.login(emailController.text,
                                        passwordController.text);
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GoogleAuthButton(
                                    onPressed: () {},
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Dont have an account? click to '),
                                  GestureDetector(
                                    onTap: (() => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()))),
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
