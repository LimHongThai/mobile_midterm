import 'dart:async';
import 'package:flutter/material.dart';
import 'shops.dart'; // Import the BrownPage
import 'search.dart'; // Import the SearchPage
import 'notification.dart'; // Import the NotificationsPage
import 'account.dart'; // Import the AccountPage
import 'favorite.dart'; // Import the FavoritesPage
import '../widgets/bottom_nav.dart'; // Import the BottomNavBar

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;

  final List<String> promoImages = [
    'assets/images/brownad.jpg',
    'assets/images/starbuckad.jpg',
    'assets/images/koiad.jpg',
  ];

  late final List<String> loopedImages;

  final List<Map<String, String>> trendingStores = [
    {"image": "assets/images/logo.jpg", "title": "BROWN"},
    {"image": "assets/images/starbuck-logo.jpg", "title": "Starbuck"},
    {"image": "assets/images/luna-logo.jpg", "title": "Luna"},
    {"image": "assets/images/amazon-logo.jpg", "title": "Amazon"},
  ];

  final List<Map<String, String>> awesomeLocalStores = [
    {"image": "assets/images/bridge-logo.png", "title": "Bridge Coffee"},
    {"image": "assets/images/cupid-logo.jpg", "title": "Cupid Coffee"},
    {"image": "assets/images/pop-logo.jpg", "title": "Pop Coffee"},
    {"image": "assets/images/dark-logo.jpg", "title": "Dark Night Cafe"},
  ];

  @override
  void initState() {
    super.initState();

    // Create the looped images list
    loopedImages = [promoImages.last, ...promoImages, promoImages.first];

    // Auto-scrolling timer
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < loopedImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 1;
        _pageController.jumpToPage(_currentPage);
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
        title: const Text(
          "Coffee",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
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
                      builder: (context) => FavoritesPage(
                        favorites: [],
                      ),
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
          // Promotions Section with Looping Images
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;

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
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
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
          // Trending Section
          const Text(
            "TRENDING",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trendingStores.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final store = trendingStores[index];
              return GestureDetector(
                onTap: () {
                  if (store["title"] == "BROWN") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrownPagee(),
                      ),
                    );
                  }
                },
                child: promoItem(store["image"]!, store["title"]!),
              );
            },
          ),
          const SizedBox(height: 16),
          // Awesome Local Section
          const Text(
            "AWESOME LOCAL",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: awesomeLocalStores.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return promoItem(
                awesomeLocalStores[index]["image"]!,
                awesomeLocalStores[index]["title"]!,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: (index) {
          switch (index) {
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
              break;
          }
        },
      ),
    );
  }

  Widget promoItem(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
