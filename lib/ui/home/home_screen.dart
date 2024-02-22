import 'package:flutter/material.dart';
import 'package:pollstar/ui/home/widgets/appbar_widget.dart';
import 'package:pollstar/ui/home/widgets/drawer_widget.dart';
import 'package:pollstar/ui/home/widgets/tab_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: TabWidget(),
    );
  }
}
