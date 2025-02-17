import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../util/theme.dart';
import 'drawer_item.dart';

class Drawers extends StatefulWidget {
  const Drawers({
    super.key,
    required this.selected,
    required this.onItemSelected,
  });
  final int selected;
  final Function(int) onItemSelected;
  @override
  State<Drawers> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Drawers> {
  int? value;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: darkTheme.surfaceContainer,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 65,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Column(
            children: [
              DrawerItem(
                buttonText: 'Income',
                icon: Icon(Icons.attach_money),
                onpress: () => widget.onItemSelected(0),
              ),
              DrawerItem(
                buttonText: 'Expenses',
                icon: Icon(Icons.shopping_bag),
                onpress: () {
                  widget.onItemSelected(1);
                },
              ),
              DrawerItem(
                buttonText: 'Assets',
                icon: Icon(Icons.house),
                onpress: () {
                  widget.onItemSelected(2);
                },
              ),
              DrawerItem(
                buttonText: 'Liabilities',
                icon: Icon(Icons.payment),
                onpress: () {
                  widget.onItemSelected(3);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
