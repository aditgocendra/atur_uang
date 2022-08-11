import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 205, 205, 205),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const ListTile(
            title: Text(
              'Uang Masuk',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Minggu, 30 Juni 2022',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              'Rp. 45.000',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 108, 99, 255),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 205, 205, 205),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const ListTile(
            title: Text(
              'Uang Keluar',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Minggu, 30 Juni 2022',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              'Rp. 70.000',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 108, 99, 255),
              ),
            ),
          ),
        )
      ],
    );
  }
}
