import 'package:flutter/material.dart';
import 'package:todo_c13_monday/firebase/firebase_manager.dart';
import 'package:todo_c13_monday/screens/login.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is Required";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                          .hasMatch(value);

                      if (emailValid == false) {
                        return "Email not Valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is Required";
                      }
                      if (value.length < 6) {
                        return "Password should be at least 6 Char";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: rePasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Re-Password is Required";
                      }
                      if (value.length < 6) {
                        return "Password should be at least 6 Char";
                      }

                      if (passwordController.text != value) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "RePassword",
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseManager.createAccount(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                    Center(child: CircularProgressIndicator()),
                                backgroundColor: Colors.transparent,
                              ),
                            );
                          },
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          (message) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: Text("Something went Wrong"),
                                content: Text(message),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    child: Text("Create Account",
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
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already Have Account ? ",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          TextSpan(
                            text: " Login",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
