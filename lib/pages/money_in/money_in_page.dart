import 'package:atur_uang/model/money.dart';
import 'package:atur_uang/model/user_data.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MoneyInPage extends StatefulWidget {
  MoneyInPage({Key? key}) : super(key: key);

  @override
  State<MoneyInPage> createState() => _MoneyInPageState();
}

class _MoneyInPageState extends State<MoneyInPage> {
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

  Future saveMoneyIn() async {
    String selectedDay;
    int totalMoney;
    String desc;

    // Validation Form
    if (selectDayTec.text.isEmpty) {
      snackbarMessage('Tanggal belum dipilih');
      return;
    }

    if (totalMoneyInTec.text.isEmpty) {
      snackbarMessage('Jumlah uang masih kosong');
      return;
    }

    if (descTec.text.isEmpty) {
      desc = '-';
    } else {
      desc = descTec.text;
    }

    selectedDay = selectDayTec.text;
    totalMoney = int.parse(totalMoneyInTec.text);

    var boxMoney = await Hive.openBox('money');
    var money = MoneyModel('Uang Masuk', selectedDay, totalMoney, desc);

    await boxMoney.add(money);

    // update data user
    var boxUser = await Hive.openBox('user_data');
    UserData userData = boxUser.getAt(0);
    await boxUser.putAt(
      0,
      UserData(userData.username, userData.myMoney + totalMoney),
    );

    Navigator.pop(context);
  }

  void snackbarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
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
          'Uang Masuk',
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
              saveMoneyIn();
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 108, 99, 255),
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(45),
            ),
            child: const Text(
              'Simpan Pemasukan',
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
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 108, 99, 255)),
                        ),
                        hintText: 'Tanggal',
                      ),
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
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 108, 99, 255)),
                  ),
                  hintText: 'Jumlah Uang',
                ),
              ),
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
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 108, 99, 255)),
                  ),
                  hintText: 'Keterangan (Optional)',
                ),
              ),
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
