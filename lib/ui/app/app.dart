import 'package:financial_planner_mobile/ui/app/assets/assets.dart';
import 'package:financial_planner_mobile/ui/app/expenses/expenses.dart';
import 'package:financial_planner_mobile/ui/app/expenses/expenses_action_button_add.dart';
import 'package:financial_planner_mobile/ui/app/expenses/expenses_action_button_options.dart';
import 'package:financial_planner_mobile/ui/app/income/income.dart';
import 'package:financial_planner_mobile/ui/app/info/info.dart';
import 'package:financial_planner_mobile/ui/app/liabilities/liabilities.dart';
import 'package:financial_planner_mobile/ui/app/income/income_action_button.dart';
import 'package:financial_planner_mobile/ui/app/liabilities/liabilities_action_button.dart';
import 'package:financial_planner_mobile/ui/app/settings/settings.dart';
import 'package:financial_planner_mobile/util/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'assets/asset_action_button.dart';
import 'drawer/Drawer.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selected = 0;
  void UpdateSelected(int value) {
    setState(() {
      selected = value;
    });
  }

  final List<String> nameList = ['Income', 'Expenses', 'Assets', 'Liabilities'];

  final List<List<Widget>?> buttonList = [
    [const IncomeActionButton()], // Income page buttons
    [
      const ExpensesActionButtonAdd(),
      const ExpensesActionButtonOptions()
    ], // Expenses page buttons
    [const AssetActionButton()], // Assets page buttons
    [const LiabilitiesActionButton()] // Liabilities page buttons
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selected,
        children: const [
          IncomePage(),
          ExpensesPage(),
          AssetsPage(),
          LiabilitiesPage(),
        ],
      ),
      appBar: AppBar(
        title: Text(nameList[selected],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: darkTheme.surfaceContainer,
        actions: [
          if (buttonList[selected] != null) ...buttonList[selected]!,
          PopupMenuButton(
            onSelected: (value) async {
              if (value == "settings") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              }
              if (value == "logout") {
                await FirebaseAuth.instance.signOut();
              } else if (value == "info") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const InfoPage()));
              }
            },
            color: darkTheme.surfaceBright,
            offset: const Offset(0, 50),
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Log out'),
                ),
                PopupMenuItem(
                  value: 'info',
                  child: Text('About'),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: Drawers(selected: selected, onItemSelected: UpdateSelected),
    );
  }
}
