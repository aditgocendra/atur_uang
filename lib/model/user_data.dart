import 'package:hive/hive.dart';
part 'user_data.g.dart';

@HiveType(typeId: 1)
class UserData {
  @HiveField(0)
  String username;
  @HiveField(1)
  int myMoney;

  UserData(this.username, this.myMoney);
}
