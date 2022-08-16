import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  String name;
  AppBarCustom({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        name,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      trailing: Image.asset(
        'assets/images/icons/icon_profile.png',
        width: 48,
      ),
    );
  }
}
