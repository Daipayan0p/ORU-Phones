import 'package:flutter/material.dart';

class CusOutlinedButton extends StatelessWidget {
  const CusOutlinedButton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFFB8B8B8),
        ),
      ),
      child: Center(child: child),
    );
  }
}

class ListViewOutLinedButton extends StatelessWidget {
  const ListViewOutLinedButton({super.key, required this.itemList});

  final List<Widget> itemList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CusOutlinedButton(
            child: itemList[index],
          ),
        );
      },
    );
  }
}
