import 'package:flutter/material.dart';
import 'boba.dart';
import 'brown.dart';
class BrownPagee extends StatefulWidget {
  @override
  _BrownPageeState createState() => _BrownPageeState();
}

class _BrownPageeState extends State<BrownPagee> {
  // Sample data for the stores
  final List<Map<String, dynamic>> stores = [
    {
      "image": "assets/images/ga.jpg",
      "title": "Brown Roastery 6A",
      "price": "\$\$\$",
      "category": "Coffee",
      "rating": 5.0,
      "reviews": "3000+",
      "isFavorite": false,
    },
    {
      "image": "assets/images/ga.jpg",
      "title": "Brown Roastery Exchange Square",
      "price": "\$\$\$",
      "category": "Coffee",
      "rating": 4.2,
      "reviews": "100+",
      "isFavorite": false,
    },
    {
      "image": "assets/images/ga.jpg",
      "title": "Brown Treeline",
      "price": "\$\$\$",
      "category": "Coffee",
      "rating": 4.7,
      "reviews": "300+",
      "isFavorite": false,
    },
  ];

  // Function to toggle the favorite status
  void toggleFavorite(int index) {
    setState(() {
      stores[index]['isFavorite'] = !stores[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Brown",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Coffee and Bakery",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BrownPage(
                    store: store,
                    isFavorite: store['isFavorite'],
                    onFavoriteToggle: () {
                      setState(() {
                        store['isFavorite'] = !store['isFavorite'];
                      });
                    },
                  ),
                ),
              );
            },
            child: Container(
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
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          store['image'],
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
                              store['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${store['price']} • ${store['category']}",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text("${store['rating']}"),
                                const SizedBox(width: 4),
                                Text("(${store['reviews']})"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => toggleFavorite(index),
                      child: Icon(
                        Icons.favorite,
                        color: store['isFavorite'] ? Colors.red : Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
