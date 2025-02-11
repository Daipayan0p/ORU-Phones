import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Selected Index: $_selectedIndex",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Yellow Circle
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
          ),
          // Inner Black Circle with Text
          FloatingActionButton(
            onPressed: () {
              _onItemTapped(2);
            },
            backgroundColor: Colors.black,
            shape: CircleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 24),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.list, "My Listings", 1),
              _buildNavItem(Icons.list, "Sell", 2),
              _buildNavItem(Icons.settings, "Services", 3),
              _buildNavItem(Icons.person, "Account", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (index != 2)
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.black : Colors.grey,
              size: 24,
            ),
          if (index == 2)
            SizedBox(
              height: 25,
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: _selectedIndex == index ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
