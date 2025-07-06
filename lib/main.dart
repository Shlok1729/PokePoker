import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pokepoker/Screens/home_screen.dart';
import 'package:pokepoker/Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Get shared prefs
  final prefs = await SharedPreferences.getInstance();

  // Check if app is cold-started (first launch after kill)
  bool wasKilled = prefs.getBool('wasKilled') ?? true;

  if (wasKilled) {
    // Mark app as now running
    await prefs.setBool('wasKilled', false);

    // Sign out on fresh launch
    await FirebaseAuth.instance.signOut();
  }

  runApp(pokepoker());
}

class pokepoker extends StatefulWidget {
  const pokepoker({super.key});

  @override
  State<pokepoker> createState() => _pokepokerState();
}

class _pokepokerState extends State<pokepoker> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('wasKilled', true); // Mark app as killed
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen()
          : LoginScreen(),
    );
  }
}
