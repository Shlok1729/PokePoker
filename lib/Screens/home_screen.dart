import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokepoker/Screens/pokemon_details.dart';
import 'package:pokepoker/main.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List poke = [];
  @override
  void initState() {
    // TODO: implement initState
    if (mounted) {
      fetchData();
    }
    super.initState();
  }

  var pokepokerApi =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -20,
            right: -30,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 130,
            left: 20,
            child: Text(
              "PokePoker",
              style: TextStyle(
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: <Color>[Colors.orange, Colors.red],
                  ).createShader(const Rect.fromLTWH(0, 0.0, 190.0, 70.0)),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8,
                  right: 5,
                  left: 5,
                ),
                child: Row(
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 25, color: Colors.yellow),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.logout, color: Colors.yellow, size: 25),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                poke != null
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                              ),
                          itemCount: poke.length,
                          itemBuilder: (context, index) {
                            var type = poke[index]['type'][0];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: type == 'Grass'
                                        ? Colors.greenAccent
                                        : type == 'Fire'
                                        ? Colors.redAccent
                                        : type == 'Water'
                                        ? Colors.blueAccent
                                        : type == 'Electric'
                                        ? Colors.orange
                                        : type == 'Rock'
                                        ? Colors.grey
                                        : type == 'Ground'
                                        ? Colors.brown
                                        : type == 'Psychic'
                                        ? Colors.indigo
                                        : type == 'Fighthing'
                                        ? Colors.orange
                                        : type == 'Bug'
                                        ? Colors.lightGreen
                                        : type == 'Ghost'
                                        ? Colors.deepPurple
                                        : type == 'Normal'
                                        ? Colors.black26
                                        : type == 'Poison'
                                        ? Colors.deepPurpleAccent
                                        : Colors.pink,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: -10,
                                        right: -10,

                                        child: Image.asset(
                                          'assets/images/pokeball.png',
                                          width: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                        top: 2,
                                        left: 10,
                                        child: Text(
                                          poke[index]['name'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 40,
                                        left: 10,
                                        child: Container(
                                          width: 60,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.white30,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              type.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 3,
                                        right: 3,
                                        child: CachedNetworkImage(
                                          width: 100,
                                          imageUrl: poke[index]['img'],
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PokeDetails(
                                        tag: index,
                                        pokedetails: poke[index],
                                        color: type == 'Grass'
                                            ? Colors.greenAccent
                                            : type == 'Fire'
                                            ? Colors.redAccent
                                            : type == 'Water'
                                            ? Colors.blueAccent
                                            : type == 'Electric'
                                            ? Colors.orange
                                            : type == 'Rock'
                                            ? Colors.grey
                                            : type == 'Ground'
                                            ? Colors.brown
                                            : type == 'Psychic'
                                            ? Colors.indigo
                                            : type == 'Fighthing'
                                            ? Colors.orange
                                            : type == 'Bug'
                                            ? Colors.lightGreen
                                            : type == 'Ghost'
                                            ? Colors.deepPurple
                                            : type == 'Normal'
                                            ? Colors.black26
                                            : type == 'Poison'
                                            ? Colors.deepPurpleAccent
                                            : Colors.pink,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchData() {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedData = jsonDecode(value.body);
        poke = decodedData['pokemon'];
        setState(() {});
      }
      print(value.body);
    });
  }
}
