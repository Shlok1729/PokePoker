import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PokeDetails extends StatefulWidget {
  final tag;
  final pokedetails;
  final Color color;

  const PokeDetails({
    super.key,
    required this.tag,
    required this.pokedetails,
    required this.color,
  });

  @override
  State<PokeDetails> createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 70,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
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
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.logout, color: Colors.red, size: 25),
                  ],
                ),
              ),
            ),
          ),
          // Back button
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: 50,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          // Pokemon name
          Positioned(
            top: 100,
            left: 20,
            child: Text(
              widget.pokedetails['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          // Pokemon type
          Positioned(
            top: 150,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.pokedetails['type'].join(', '),
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),

          // Pokeball background
          Positioned(
            top: 110,
            right: -30,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                'assets/images/pokeball.png',
                width: 250,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          // Pokemon Image
          Positioned(
            top: 110,
            right: 10,
            child: CachedNetworkImage(
              imageUrl: widget.pokedetails['img'],
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),

          // Bottom white container (scrollable)
          Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.6,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          _infoRow("Name", widget.pokedetails['name']),
                          _infoRow("Height", widget.pokedetails['height']),
                          _infoRow("Weight", widget.pokedetails['weight']),
                          _infoRow(
                            "Spawn Time",
                            widget.pokedetails['spawn_time'],
                          ),
                          _infoRow(
                            "Weakness",
                            widget.pokedetails['weaknesses'].join(', '),
                          ),
                          _infoRow(
                            "Evolution",
                            '${widget.pokedetails['prev_evolution'] != null ? widget.pokedetails['prev_evolution'][0]['name'] : ''}'
                                '${(widget.pokedetails['prev_evolution'] != null && widget.pokedetails['next_evolution'] != null) ? ', ' : ''}'
                                '${widget.pokedetails['next_evolution'] != null ? widget.pokedetails['next_evolution'][0]['name'] : ''}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: Text(
              title,
              style: TextStyle(color: Colors.black45, fontSize: 25),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
