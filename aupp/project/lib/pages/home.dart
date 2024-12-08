import 'dart:async';
import 'package:flutter/material.dart';
import 'coffee.dart'; // Import the CoffeePage
import 'boba.dart'; // Import the BobaPage
import 'alcohol.dart'; // Import the AlcoholPage
import 'juice.dart'; // Import the JuicePage
import 'search.dart'; // Import the SearchPage
import 'notification.dart'; // Import the NotificationsPage
import 'account.dart'; // Import the AccountPage
import 'favorite.dart'; // Import the FavoritesPage
import '../widgets/bottom_nav.dart'; // Import the BottomNavBar widget
import 'brown.dart'; // Import the BrownPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
      viewportFraction: 0.8, initialPage: 1);
  int _currentPage = 1; // Start at the duplicated first page
  final List<Map<String, dynamic>> favoriteStores = []; // List for favorite stores

  final List<String> promoImages = [
    'assets/images/brownad.jpg',
    'assets/images/starbuckad.jpg',
    'assets/images/koiad.jpg',
  ];

  late final List<String> loopedImages;

  final List<Map<String, dynamic>> featuredStores = [
    {
      "image": "assets/images/ga.jpg",
      "title": "Brown Roastery 6A",
      "rating": 4.7,
      "category": "Coffee",
      "reviews": 3076,
    },
    {
      "image": "assets/images/sb.jpeg",
      "title": "Starbucks Chipmong Sensok ",
      "rating": 4.5,
      "category": "Coffee",
      "reviews": 1510,
    },
    {
      "image": "assets/images/koi.png",
      "title": "KOI The Toul Kork",
      "rating": 4.1,
      "category": "Boba",
      "reviews": 2963,
    },
    {
      "image": "assets/images/he.jpg",
      "title": "Heekcaa Toul Kork",
      "rating": 4.0,
      "category": "Boba",
      "reviews": 1830,
    },
    {
      "image": "assets/images/al.jpg",
      "title": "The Alley Aeon Sensok Mall",
      "rating": 4.6,
      "category": "Boba",
      "reviews": 1220,
    },
  ];

  @override
  void initState() {
    super.initState();

    // Duplicate the list for infinite scrolling
    loopedImages = [promoImages.last, ...promoImages, promoImages.first];

    // Timer for auto-scrolling
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void toggleFavorite(Map<String, dynamic> store) {
    setState(() {
      if (favoriteStores.contains(store)) {
        favoriteStores.remove(store);
      } else {
        favoriteStores.add(store);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40), // For status bar padding
          // App Logo and Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/final_logo.png',
                    height: 60,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  child: TextField(
                    enabled: false, // Disable typing in this TextField
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
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Favorites and Offers Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesPage(favorites: favoriteStores),
                    ),
                  );
                },
                child: Column(
                  children: const [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(height: 4),
                    Text("Favorites"),
                  ],
                ),
              ),
              Column(
                children: const [
                  Icon(Icons.local_offer, color: Colors.blue),
                  SizedBox(height: 4),
                  Text("Offers"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Promotions Section with Infinite Scrolling
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;

                  // Handle infinite loop behavior
                  if (index == 0) {
                    _pageController.jumpToPage(loopedImages.length - 2);
                    _currentPage = loopedImages.length - 2;
                  } else if (index == loopedImages.length - 1) {
                    _pageController.jumpToPage(1);
                    _currentPage = 1;
                  }
                });
              },
              itemCount: loopedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(loopedImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoffeePage()),
                    );
                  },
                  child: categoryItem("Coffee", Icons.local_cafe),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlcoholPage()),
                    );
                  },
                  child: categoryItem("Alcohol", Icons.wine_bar),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JuicePage()),
                    );
                  },
                  child: categoryItem("Juice", Icons.local_drink),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BobaPage()),
                    );
                  },
                  child: categoryItem("Boba", Icons.bubble_chart),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // "Featured Stores" Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              "Featured Stores",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List of Featured Stores
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: featuredStores.length,
              itemBuilder: (context, index) {
                final store = featuredStores[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrownPage(
                          store: store,
                          isFavorite: favoriteStores.contains(store),
                          onFavoriteToggle: () {
                            toggleFavorite(store);
                            setState(() {}); // Sync the favorite state
                          },
                        ),
                      ),
                    );
                  },
                  child: storeItem(
                    store: store,
                    isFavorite: favoriteStores.contains(store),
                    onFavoriteToggle: () => toggleFavorite(store),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0, // Highlight the Home tab
        onTap: (index) {
          switch (index) {
            case 0: // Home
              break; // Already on the Home page
            case 1: // Search
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
              break;
            case 2: // Inbox
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()));
              break;
            case 3: // Settings
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountPage()));
              break
              ;
          }
        },
      ),
    );
  }

  Widget categoryItem(String title, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35, // Adjust the size as needed
          color: Colors.black, // Icon color
        ),
        const SizedBox(height: 4),
        Text(title),
      ],
    );
  }


  Widget storeItem({
    required Map<String, dynamic> store,
    required bool isFavorite,
    required VoidCallback onFavoriteToggle,
  }) {
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
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16)),
                child: Image.asset(
                  store['image'],
                  height: 200, // Increased height for better visibility
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
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text("${store['rating']}"),
                        const SizedBox(width: 4),
                        Text("(${store['reviews']})"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(store['category']),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

