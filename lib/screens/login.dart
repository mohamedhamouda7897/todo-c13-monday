import 'package:flutter/material.dart';
import 'package:todo_c13_monday/screens/register.dart';

import 'forget_password.dart';
import 'home/home.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/login_image.png",
                  width: 136,
                  height: 186,
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPassword.routeName);
                      },
                      child: Text(
                        "Forget Password?",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                      )),
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  child: Text("login",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RigisterScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don’t Have Account ?",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        TextSpan(
                          text: " Create Account",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(child: Divider(
                        color: Theme.of(context).primaryColor,
                      indent: 10,
                      endIndent: 40,
            
                    )),
                    Text(
                      textAlign: TextAlign.center,
                      "OR",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                    Expanded(child: Divider(
                        color: Theme.of(context).primaryColor,
                      indent: 40,
                      endIndent: 10,
            
                    )),
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
