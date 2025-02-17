import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.buttonText,
      required this.icon,
      required this.onpress});
  final String buttonText;
  final Widget icon;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onpress();
      },
      child: ListTile(
        title: Text(buttonText),
        leading: icon,
      ),
    );
  }
}
