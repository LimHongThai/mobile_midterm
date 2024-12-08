import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage for accessing the favorite list
import '../widgets/bottom_nav.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favorites; // Receive favorites from HomePage

  FavoritesPage({required this.favorites});

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
            Navigator.pop(context); // Go back to HomePage
          },
        ),
        title: const Text(
          "My Favorites",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final store = favorites[index];
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        store["image"],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store["title"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text("${store["rating"]}"),
                              const SizedBox(width: 4),
                              Text("(${store["reviews"]})"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(store["category"]),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      // Remove the item from the favorites
                      favorites.remove(store);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritesPage(favorites: favorites),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pop(context);
              break;
            case 1: // Search
            // Navigate to search page
              break;
            case 2: // Inbox
            // Navigate to inbox
              break;
            case 3: // Account
            // Navigate to account
              break;
          }
        },
      ),
    );
  }
}
