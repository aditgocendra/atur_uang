import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'money.g.dart';

@HiveType(typeId: 0)
class MoneyModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String dateDay;
  @HiveField(2)
  int totalMoney;
  @HiveField(3)
  String desc;

  MoneyModel(this.title, this.dateDay, this.totalMoney, this.desc);

  String getIndex(int index) {
    switch (index) {
      case 0:
        return title;
      case 1:
        return dateDay;
      case 2:
        return NumberFormat.currency(
          locale: 'id',
          symbol: 'Rp. ',
          decimalDigits: 0,
        ).format(totalMoney);
      case 3:
        return desc;
    }
    return '';
  }
}
