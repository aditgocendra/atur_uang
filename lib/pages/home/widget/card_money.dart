import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class CardMoney extends StatelessWidget {
  final heightContainer;
  CardMoney({Key? key, required this.heightContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxUser = Hive.box('user_data');

    return ValueListenableBuilder(
      valueListenable: boxUser.listenable(),
      builder: (context, value, child) {
        if (boxUser.length == 0) {
          return Container();
        }
        return Container(
          height: heightContainer,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 203, 177, 177),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
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
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp. ',
                        decimalDigits: 0,
                      ).format(boxUser.getAt(0).myMoney),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat('EEEE, d MMM y', 'id').format(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
