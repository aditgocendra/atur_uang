import 'package:flutter/material.dart';

class CardMoney extends StatelessWidget {
  final heightContainer;
  CardMoney({Key? key, required this.heightContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightContainer,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 205, 205, 205),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Uang Anda Sekarang',
              style: TextStyle(
                color: Color.fromARGB(255, 108, 99, 255),
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rp. 325.000.000',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '27 Maret 2022',
                style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
