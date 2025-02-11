import 'package:flutter/material.dart';

class CusSearchBar extends StatelessWidget {
  const CusSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 20,
                width: 1,
                color: Colors.grey,
              ),
              SizedBox(width: 8),
              Icon(Icons.mic_none),
            ],
          ),
          hintText: "Search phones with make, model...",
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFF6C018),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFB8B8B8),
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(
              color: Color(0xFFB8B8B8),
            ),
          ),
        ),
      ),
    );
  }
}
