import 'package:flutter/material.dart';
import 'package:oru_phones/src/app/app.locator.dart';
import 'package:oru_phones/src/service/auth_service.dart';
import 'package:oru_phones/src/view/auth/login_screen.dart';
import 'package:oru_phones/src/view_model/auth_view_model.dart';
import 'package:stacked/stacked.dart';

Widget CusAppBar(BuildContext context) {
  return ViewModelBuilder.reactive(
      viewModelBuilder: () => AuthViewModel(locator<AuthService>()),
      builder: (context, viewModel, child) {
        return AppBar(
          surfaceTintColor: Colors.transparent,
          leadingWidth: 140,
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 32,
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    "assets/logo.png",
                    width: 80,
                  )
                ],
              ),
            ),
          ),
          actions: [
            Text(
              "India",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.location_on_outlined,
              size: 28,
            ),
            if (viewModel.isAuthenticated)
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none_outlined),
              ),
            if (!viewModel.isAuthenticated) SizedBox(width: 18),
            if (!viewModel.isAuthenticated)
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFF6C018),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            SizedBox(width: 12),
          ],
        );
      });
}
