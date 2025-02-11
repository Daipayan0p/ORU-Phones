import 'package:flutter/material.dart';
import 'package:oru_phones/src/app/app.locator.dart';
import 'package:oru_phones/src/service/auth_service.dart';
import 'package:oru_phones/src/view/auth/login_screen.dart';
import 'package:oru_phones/src/view_model/auth_view_model.dart';
import 'package:stacked/stacked.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> iconsName = [
      "How to Buy",
      "Refund Policy",
      "FAQs",
      "Privacy Policy",
      "About Us",
      "Oru Guide"
    ];

    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = screenWidth < 600 ? 0.9 : 1.0;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AuthViewModel(locator<AuthService>()),
      builder: (context, viewModel, child) {
        return Drawer(
          child: SafeArea(
            child: Column(
              children: [
                // Header Section
                Container(
                  color: Color(0xECEAEAEA),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/logo.png",
                              width: 62,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        if (viewModel.isAuthenticated)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "John",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Joined: Feb 11 2025",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        if (!viewModel.isAuthenticated)
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF3F3E8F),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              width: double.infinity,
                              height: 35,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Login/SignUp', // Fixed typo
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20 * textScaleFactor,
                                      // Adjusted font size
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Sell Button
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 3,
                        blurRadius: 20,
                      )
                    ],
                    color: Color(0xFFF6C018),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Sell Your Phone",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20 * textScaleFactor, // Adjusted font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.feed_outlined, size: 26),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Blogs",
                        style: TextStyle(fontSize: 20 * textScaleFactor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Icon(Icons.support_agent, size: 26),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Support",
                        style: TextStyle(fontSize: 20 * textScaleFactor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.store_mall_directory_outlined,
                        size: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Register Store",
                        style: TextStyle(
                          fontSize: 20 * textScaleFactor,
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 6, // Total number of items
                      itemBuilder: (context, index) {
                        return _widgetCard(
                            index + 1, iconsName[index], textScaleFactor);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _widgetCard(int no, String text, double textScaleFactor) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/sidebar/icon$no.png", width: 40, height: 40),
          Text(
            text,
            style: TextStyle(fontSize: 12 * textScaleFactor),
            // Adjusted font size
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
