import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.deepOrange),
        ),
        centerTitle: true,
        title: Text("My First App", style: TextStyle(color: Colors.deepOrange)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.deepOrange),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.deepOrange),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images.jpeg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ahmed Ali',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 22, color: Colors.deepOrange),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.facebook, color: Colors.blueAccent),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_rounded, color: Colors.redAccent),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.snapchat, color: Colors.yellow),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.telegram, color: Colors.blueAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
