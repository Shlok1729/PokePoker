import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepoker/Screens/login_screen.dart';
import 'package:pokepoker/Widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController callController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    callController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.yellow[50],
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
                        height: size.height * 0.25,
                        width: size.width * 0.8,
                        child: Lottie.asset('assets/animations/lottie2.json'),
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.12,
                          color: Colors.red[600],
                        ),
                      ),
                      Text(
                        "Enter valid email and phone number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.045,
                          color: Colors.yellow[600],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: callController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
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
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.yellow[800],
                          suffixIcon: callController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  onPressed: () => callController.clear(),
                                  icon: Icon(Icons.close, color: Colors.black),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                        decoration: InputDecoration(
                          hintText: 'abc@gmail.com',
                          hintStyle: TextStyle(
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
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: obscureText,
                        obscuringCharacter: '*',
                        controller: passController,
                        decoration: InputDecoration(
                          hintText: 'Create Password',
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
                          prefixIconColor: Colors.blueGrey[900],
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
                      LoadingAnimatedButton(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.1,
                            color: Colors.yellow[900],
                          ),
                        ),
                        onTap: () => registerUser(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.yellow[700],
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue[800],
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

  void registerUser() {
    if (callController.text.isEmpty ||
        emailController.text.isEmpty ||
        passController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        backgroundColor: Colors.red,
      );
      return;
    }

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        )
        .then((value) {
          if (value.user != null) {
            addUserData(value.user!.uid);
          }
        })
        .catchError((e) {
          Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
        });
  }

  void addUserData(String uid) {
    Map<String, dynamic> usersData = {
      'name': callController.text.trim(),
      'email': emailController.text.trim(),
      'password': passController.text.trim(),
      'uid': uid,
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(usersData)
        .then((value) {
          Fluttertoast.showToast(
            msg: 'Registration Successful',
            backgroundColor: Colors.green,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        })
        .catchError((e) {
          Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
        });
  }
}
