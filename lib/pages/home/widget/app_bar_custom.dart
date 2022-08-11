import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text(
        'Aditya Gocendra',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      trailing: Image.asset(
        'assets/images/icons/icon_profile.png',
        width: 64,
      ),
    );
  }
}
