import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:oru_phones/src/view/home/widgets/SortBottomSheet.dart';
import 'package:oru_phones/src/view/home/widgets/top_brand_bottom_sheet.dart';

class Body1 extends StatefulWidget {
  const Body1({super.key});

  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  int adsNo = 0;
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {

      if (adsNo < 4) {
        adsNo++;
      } else {
        adsNo = 0;
      }
      _pageController.animateToPage(
        adsNo,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        SizedBox(
          height: 200,
          child: _bannerListView(),
        ),
        _pageIndicatorView(),
        SizedBox(height: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "What's on your mind?",
                style: TextStyle(fontSize: 22, color: Color(0xFF525252)),
              ),
            ),
            SizedBox(
              height: 120,
              child: _serviceListMenu(),
            ),
          ],
        ),
        SizedBox(height: 25),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Brands",
                    style: TextStyle(fontSize: 22, color: Color(0xFF525252)),
                  ),
                  IconButton(
                    onPressed: () {
                      _showTopBrandBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: _topBrandsList(),
            ),
          ],
        ),
      ],
    );
  }

  void _showTopBrandBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      // Allows full screen height handling
      builder: (context) {
        return SizedBox(height: 400,child: TopBrandBottomSheet());
      },
    );
  }

  Widget _pageIndicatorView() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                shape: BoxShape.circle,
                color: index == adsNo ? Colors.grey : Colors.transparent,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bannerListView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          adsNo = index;
        });
      },
      scrollDirection: Axis.horizontal,

      itemCount: 5,
      itemBuilder: (context, index) {
        return Image.asset(
          "assets/banner${index + 1}.png",
          scale: .98,
        );
      },
    );
  }

  Widget _topBrandsList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Image.asset(
          "assets/icons/Brand-${6 - index + 1}.png",
          fit: BoxFit.contain,
          width: 92,
        );
      },
    );
  }

  Widget _serviceListMenu() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 17,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: index < 3 ? 0 : 25),
          child: Image.asset(
            "assets/frame/Frame${index + 3}.png",
            fit: BoxFit.fitWidth,
            width: index < 3 ? 100 : 72,
          ),
        );
      },
    );
  }
}
