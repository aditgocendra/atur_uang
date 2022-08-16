import 'package:atur_uang/model/money.dart';
import 'package:atur_uang/model/user_data.dart';
import 'package:atur_uang/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocDir.path);
  initializeDateFormatting();

  Hive.registerAdapter(MoneyModelAdapter());
  Hive.registerAdapter(UserDataAdapter());

  await Hive.openBox('user_data');
  await Hive.openBox('money');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
