import 'package:flutter/material.dart';
import 'package:todo_c13_monday/screens/login.dart';

class RigisterScreen extends StatelessWidget {
  static const String routeName = "register";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
   RigisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register",style: Theme.of(context).textTheme.titleMedium,),

      ),
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
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
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
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: repasswordController,
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
                    // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already Have Account ? ",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        TextSpan(
                          text: " Login",
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
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
