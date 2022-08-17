import 'package:atur_uang/globals/global_function.dart';
import 'package:atur_uang/globals/global_style.dart';
import 'package:atur_uang/model/money.dart';
import 'package:atur_uang/model/user_data.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MoneyOutPage extends StatefulWidget {
  MoneyOutPage({Key? key}) : super(key: key);

  @override
  State<MoneyOutPage> createState() => _MoneyOutPageState();
}

class _MoneyOutPageState extends State<MoneyOutPage> {
  late TextEditingController selectDayTec;
  late TextEditingController totalMoneyInTec;
  late TextEditingController descTec;

  var configDatePicker = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.single,
    selectedDayHighlightColor: Colors.purple[800],
    shouldCloseDialogAfterCancelTapped: true,
  );

  List<DateTime?> singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  Future saveMoneyOut() async {
    String selectedDay;
    int totalMoney;
    String desc;

    // Validation Form
    if (selectDayTec.text.isEmpty) {
      GlobalFunction.snackbarMessage(context, 'Tanggal belum dipilih');
      return;
    }

    if (totalMoneyInTec.text.isEmpty) {
      GlobalFunction.snackbarMessage(context, 'Jumlah uang masih kosong');
      return;
    }

    if (descTec.text.isEmpty) {
      desc = '-';
    } else {
      desc = descTec.text;
    }

    selectedDay = selectDayTec.text;
    totalMoney = int.parse(totalMoneyInTec.text);

    var box = await Hive.openBox('money');
    var money = MoneyModel('Uang Keluar', selectedDay, totalMoney, desc);

    // update data user
    var boxUser = await Hive.openBox('user_data');

    UserData userData = boxUser.getAt(0);

    if (userData.myMoney - totalMoney < 0) {
      GlobalFunction.snackbarMessage(
          context, 'Total jumlah uang anda kurang dari 0');
      return;
    }
    await boxUser.putAt(
      0,
      UserData(userData.username, userData.myMoney - totalMoney),
    );

    await box.add(money);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Uang Keluar',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              saveMoneyOut();
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 108, 99, 255),
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(45),
            ),
            child: const Text(
              'Simpan Pengeluaran',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: selectDayTec,
                      readOnly: true,
                      style: const TextStyle(fontSize: 14),
                      decoration:
                          GlobalStyle.textFieldDecoration('Hari / Tanggal'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 108, 99, 255),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      var datePick = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: configDatePicker,
                        dialogSize: const Size(325, 400),
                        borderRadius: 15,
                        initialValue: singleDatePickerValueWithDefaultValue,
                        dialogBackgroundColor: Colors.white,
                      );

                      if (datePick == null) {
                        return;
                      }

                      initializeDateFormatting();

                      setState(() {
                        selectDayTec.text = DateFormat('EEEE, d MMM y', 'id')
                            .format(datePick[0]!);
                      });
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 108, 99, 255),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                  controller: totalMoneyInTec,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  cursorColor: const Color.fromARGB(255, 108, 99, 255),
                  style: const TextStyle(fontSize: 14),
                  decoration: GlobalStyle.textFieldDecoration('Jumlah Uang')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                  controller: descTec,
                  minLines: 6,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: const Color.fromARGB(255, 108, 99, 255),
                  style: const TextStyle(fontSize: 14),
                  decoration:
                      GlobalStyle.textFieldDecoration('Keterangan (Optional)')),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    selectDayTec = TextEditingController();
    totalMoneyInTec = TextEditingController();
    descTec = TextEditingController();

    String dateNow = DateFormat('EEEE, d MMM y', 'id').format(DateTime.now());

    setState(() {
      selectDayTec.text = dateNow;
    });

    super.initState();
  }

  @override
  void dispose() {
    selectDayTec.dispose();
    totalMoneyInTec.dispose();
    descTec.dispose();
    super.dispose();
  }
}
