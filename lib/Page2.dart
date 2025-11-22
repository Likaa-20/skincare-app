import 'package:flutter/material.dart';
import 'User.dart';
import 'skinType.dart';
import 'Page3.dart';

class Page2 extends StatefulWidget {
  final User user;
  const Page2({Key? key, required this.user}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Skin selectedSkin = skins[0];

  void updateSkin(Skin newSkin) {
    setState(() {
      selectedSkin = newSkin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome, ${widget.user.name}!',
          style: TextStyle(color: Colors.white70, fontSize: 24),
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select your skin type:',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 30),

            MyDropdownMenuWidget(updateSkin: updateSkin),

            const SizedBox(height: 40),

            Text(
              'You selected: ${selectedSkin.type}',
              style: TextStyle(
                fontSize: 22,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Page3(
                      user: widget.user,
                      selectedSkin: selectedSkin,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Show Products',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
