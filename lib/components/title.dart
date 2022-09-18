import 'package:flutter/material.dart';

class TitleList extends StatelessWidget {
  const TitleList({Key? key, this.title = 'Repositories'}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        child: Text(title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5)));
  }
}
