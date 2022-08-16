import 'package:atur_uang/model/money.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxMoney = Hive.box('money');

    if (boxMoney.length == 0) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: const Center(child: Text('Belum ada data ditemukan')),
      );
    }

    return ValueListenableBuilder(
      valueListenable: boxMoney.listenable(),
      builder: (context, value, child) => ListView.builder(
        itemCount: boxMoney.length,
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          MoneyModel moneyData = boxMoney.getAt(index);
          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 205, 205, 205),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Text(
                moneyData.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                moneyData.dateDay,
                style: const TextStyle(fontSize: 12),
              ),
              trailing: Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp. ',
                  decimalDigits: 0,
                ).format(moneyData.totalMoney),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 108, 99, 255),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
