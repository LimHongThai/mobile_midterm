import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/widgets/bottom_nav.dart';
import 'search.dart';
import 'notification.dart';
import 'account.dart';

class BrownPage extends StatefulWidget {
  final Map<String, dynamic> store;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  BrownPage({
    required this.store,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  _BrownPageState createState() => _BrownPageState();
}

class _BrownPageState extends State<BrownPage> {
  late final List<String> storeImages;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final double latitude = 11.5927675;
  final double longitude = 104.9294939;

  final MapController _mapController = MapController();
  double _currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    storeImages = [
      'assets/images/ga.jpg',
      'assets/images/brown6a.jpg',
      'assets/images/brown6aa.jpg',
    ];
  }

  Future<void> _openGoogleMaps() async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              widget.store['title'],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Container(
              height: 2,
              width: 50,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: widget.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: widget.onFavoriteToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image carousel
            SizedBox(
              height: 280,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: storeImages.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 240,
                          width: Curves.easeOut.transform(value) * 330,
                          child: child,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        storeImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Dot indicator
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                storeImages.length,
                    (index) =>
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.black : Colors
                            .grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
              ),
            ),
            SizedBox(height: 16),
            // Map Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            center: LatLng(latitude, longitude),
                            zoom: _currentZoom,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(latitude, longitude),
                                  builder: (ctx) =>
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Zoom Buttons
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            heroTag: 'zoom_in',
                            mini: true,
                            onPressed: () {
                              setState(() {
                                _currentZoom += 1;
                                _mapController.move(
                                    _mapController.center, _currentZoom);
                              });
                            },
                            child: Icon(Icons.zoom_in),
                          ),
                          SizedBox(height: 8),
                          FloatingActionButton(
                            heroTag: 'zoom_out',
                            mini: true,
                            onPressed: () {
                              setState(() {
                                _currentZoom -= 1;
                                _mapController.move(
                                    _mapController.center, _currentZoom);
                              });
                            },
                            child: Icon(Icons.zoom_out),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Address and details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _openGoogleMaps,
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.store['address'] ??
                                    "6A Road, Phnom Penh",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            widget.store['phone'] ?? "+855 98 888 331",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.store['hours'] ?? "7am - 9pm",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(Icons.star,
                                  color: Colors.orange, size: 20);
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
}
