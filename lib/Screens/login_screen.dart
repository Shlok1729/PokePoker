import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepoker/Screens/home_screen.dart';
import 'package:pokepoker/Widgets/button.dart';
import 'package:pokepoker/Widgets/buttonlogin.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[100],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: IntrinsicHeight(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Container(
                        height: size.height * 0.3,
                        width: size.width * 0.8,
                        child: Lottie.asset('assets/animations/lottie1.json'),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.12,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        "Enter valid email and password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.045,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'abc@gmail.com',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[900],
                            fontSize: size.width * 0.045,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.yellow.shade800,
                            ),
                          ),
                          prefixIcon: Icon(Icons.mail),
                          prefixIconColor: Colors.green[900],
                          suffixIcon: emailController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  onPressed: () => emailController.clear(),
                                  icon: Icon(Icons.close, color: Colors.black),
                                ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: obscureText,
                        obscuringCharacter: '*',
                        controller: passController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                            fontSize: size.width * 0.045,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.yellow.shade800,
                            ),
                          ),
                          prefixIcon: Icon(Icons.key),
                          prefixIconColor: Colors.blueAccent,
                          suffixIcon: passController.text.isEmpty
                              ? Container(width: 0)
                              : GestureDetector(
                                  child: Icon(Icons.remove_red_eye_outlined),
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      LoadingAnimatedButton1(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.1,
                            color: Colors.teal,
                          ),
                        ),
                        onTap: () {
                          loginUser();
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                                fontSize: size.width * 0.045,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() {
    if (passController.text.isEmpty || emailController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Email and Password cannot be blank',
        backgroundColor: Colors.red,
      );
      return;
    }

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        )
        .then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        })
        .catchError((e) {
          Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
        });
  }
}
