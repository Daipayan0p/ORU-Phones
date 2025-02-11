import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oru_phones/src/view/home/widgets/app_bar.dart';
import 'package:oru_phones/src/view/home/widgets/body1.dart';
import 'package:oru_phones/src/view/home/widgets/body2.dart';
import 'package:oru_phones/src/view/home/widgets/body3.dart';
import 'package:oru_phones/src/view/home/widgets/drawer.dart';
import 'package:oru_phones/src/view/home/widgets/outlined_button.dart';
import 'package:oru_phones/src/view/home/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();
  String scrollPosition = "Initial";
  int _selectedIndex = 0;
  bool _isScrolling = false;
  Timer? _scrollTimer;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    controller.addListener(_detectScrolling);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.removeListener(_detectScrolling);
    controller.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _detectScrolling() {
    if (!(controller.offset <= 0) &&
        !(controller.offset >= controller.position.maxScrollExtent - 150)) {
      _scrollTimer?.cancel();
      _isScrolling = true;
      _scrollTimer = Timer(Duration(milliseconds: 200), () {
        _isScrolling = false;
        if (mounted) setState(() {});
      });
    }
  }

  void _scrollListener() {
    if (controller.offset <= 0) {
      if (scrollPosition != "Initial") {
        setState(() {
          scrollPosition = "Initial";
        });
      }
    } else if (controller.offset >= controller.position.maxScrollExtent) {
      if (scrollPosition != "Bottom") {
        setState(() {
          scrollPosition = "Bottom";
        });
      }
    } else {
      if (scrollPosition != "Scrolling") {
        setState(() {
          scrollPosition = "Scrolling";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            AnimatedPositioned(
              top: scrollPosition == "Initial" ? 0 : -60,
              left: 0,
              right: 0,
              duration: Duration(milliseconds: 250), // Increased duration
              curve: Curves.easeOut, // Smooth transition
              child: CusAppBar(context),
            ),
            AnimatedPositioned(
              top: scrollPosition == "Initial" ? 60 : 0,
              left: 0,
              right: 0,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: CusSearchBar(),
            ),
            AnimatedPositioned(
              top: scrollPosition == "Initial" ? 120 : 60,
              left: 0,
              right: 0,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: SizedBox(
                height: 35,
                child: _topNavBar(),
              ),
            ),
            Positioned.fill(
              top: scrollPosition == "Initial" ? 160 : 100,
              child: SingleChildScrollView(
                controller: controller,
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Body1(),
                    SizedBox(height: 20),
                    Body2(),
                    Body3(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedContainer(
        height: !_isScrolling ? 90 : 0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut, // Smooth easing
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Color(0xFFF6C018),
                shape: BoxShape.circle,
              ),
            ),
            FloatingActionButton(
              onPressed: () => _onItemTapped(2),
              backgroundColor: Colors.black,
              shape: CircleBorder(),
              child: Center(
                child: Icon(Icons.add, color: Color(0xFFF6C018), size: 34),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedContainer(
        height: !_isScrolling ? 90 : 0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Wrap(children: [
          BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 0),
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
        ]),
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

  Widget _topNavBar() {
    final List<Widget> navItems = [
      Text("Sell Used Phones"),
      Text("Buy Used Phones"),
      Text("My Profile"),
      Text("My Listings"),
      Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6565F1),
                  Color(0xFFB152E9),
                  Color(0xFFE9489D),
                ],
              ),
            ),
            child: Text(
              "New",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 8),
          Text("Register your Store"),
        ],
      ),
      Text("Get the App"),
    ];

    return ListViewOutLinedButton(itemList: navItems);
  }
}
