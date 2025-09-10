import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.titles});
  
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        tabs: titles.map((title) => Tab(text: title,)).toList(),
        labelColor: Colors.blue.shade800,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.blue.shade900,

    );
  }
}
