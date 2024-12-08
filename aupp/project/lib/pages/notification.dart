import 'package:flutter/material.dart';
import 'search.dart'; // Import the SearchPage
import 'account.dart'; // Import the AccountPage
import 'home.dart'; // Import the HomePage
import '../widgets/bottom_nav.dart'; // Import the BottomNavBar widget

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        "image": "assets/images/logo.jpg",
        "title": "PROMOTION",
        "description": "Enjoy your drinks today with 30% discount using code STARBUCKS",
      },
      {
        "image": "assets/images/logo.jpg",
        "title": "NEW DRINKS",
        "description": "We added a new drink to our menus, please come check it out!",
      },
    ];

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
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(notifications[index]["image"]!),
              ),
              title: Text(
                notifications[index]["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notifications[index]["description"]!),
              trailing: const Icon(Icons.notifications_active, color: Colors.amber),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2, // Highlight the Inbox tab
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
            // Already on the Inbox page
              break;
            case 3: // Settings
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
                    (route) => false,
              );
              break;
          }
        },
      ),
    );
  }
}
