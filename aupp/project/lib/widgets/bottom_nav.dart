import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int) onTap; // Callback for navigation
  final int currentIndex; // To highlight the selected tab

  const BottomNavBar({
    Key? key,
    required this.onTap,
    this.currentIndex = 0, // Default to the first tab
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap, // Call the onTap function when a tab is tapped
      selectedItemColor: Colors.blue, // Highlight color for the active tab
      unselectedItemColor: Colors.grey, // Color for inactive tabs
      backgroundColor: Colors.white, // Background color of the bar
      showUnselectedLabels: true, // Show labels for unselected items
      type: BottomNavigationBarType.fixed, // Fixed layout for icons and labels
      items: const [
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
    );
  }
}
