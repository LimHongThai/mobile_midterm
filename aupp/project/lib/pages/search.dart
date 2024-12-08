import 'package:flutter/material.dart';
import 'notification.dart'; // Import the NotificationsPage
import 'account.dart'; // Import the AccountPage
import 'home.dart'; // Import the HomePage
import '../widgets/bottom_nav.dart'; // Import the BottomNavBar widget

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, String>> popularSearches = [
    {"image": "assets/images/alley-logo.jpg", "title": "The Alley"},
    {"image": "assets/images/ancha-logo.png", "title": "An Cha"},
    {"image": "assets/images/starbuck-logo.jpg", "title": "Starbuck"},
    {"image": "assets/images/amazon-logo.jpg", "title": "Amazon"},
    {"image": "assets/images/koi-logo.jpg", "title": "Koi The"},
    {"image": "assets/images/luna-logo.jpg", "title": "Luna"},
    {"image": "assets/images/ROUND1.jpg", "title": "ROUND1"},
    {"image": "assets/images/logo.jpg", "title": "Brown"},
  ];

  String? selectedOption; // Variable to store selected dropdown option
  final List<String> dropdownOptions = [
    "All Stores",
    "Coffee",
    "Boba",
    "Juice",
    "Alcohol",
  ]; // Dropdown menu options

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
        title: Image.asset('assets/images/final_logo.png', height: 40),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: "Search for stores",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              // Implement search logic here if needed
            },
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: selectedOption,
            hint: const Text("Filter by category"),
            isExpanded: true,
            items: dropdownOptions.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            "Popular Searches",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: popularSearches.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      popularSearches[index]["image"]!,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    popularSearches[index]["title"]!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // Highlight the Search tab
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
            // Already on the Search page
              break;
            case 2: // Inbox
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
                    (route) => false,
              );
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
