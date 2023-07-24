import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splash_screen.dart'; // Import your splash screen file

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If there is no current user, you can handle the case accordingly.
      // For now, let's just display a loading indicator.
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    String userEmail = user.email ?? "No Email";

    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.lightGreen,
          automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/default_avatar.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                user.displayName ?? 'User',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
              ),
              SizedBox(height: 10),
              Text(
                userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  // Implement log out functionality here
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SplashScreen()), // Replace with your splash screen route
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
