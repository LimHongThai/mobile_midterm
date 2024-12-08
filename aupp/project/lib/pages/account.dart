import 'package:flutter/material.dart';
import 'search.dart'; // Import the SearchPage
import 'notification.dart'; // Import the NotificationsPage
import 'home.dart'; // Import the HomePage
import '../widgets/bottom_nav.dart'; // Import the BottomNavBar widget

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back to the HomePage
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
            );
          },
        ),
        title: const Text(
          "My Account",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 40),
              ),
              title: const Text("HENG HONGHAY"),
              subtitle: const Text("User since Sept 17, 2017"),
            ),
            const Divider(),
            SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: const Text("Notification"),
            ),
            ListTile(
              title: const Text("Change Password"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Terms Of Use"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("About us"),
              onTap: () {},
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("LOGOUT"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(child: Text("App version: 1.0.0")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Highlight the Settings tab
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
              );
              break;
            case 1: // Search
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
                    (route) => false,
              );
              break;
            case 2: // Inbox
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
                    (route) => false,
              );
              break;
            case 3: // Settings
            // Already on the Settings page
              break;
          }
        },
      ),
    );
  }
}
