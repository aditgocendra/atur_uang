import 'package:atur_uang/globals/global_style.dart';
import 'package:atur_uang/model/money.dart';
import 'package:atur_uang/model/user_data.dart';
import 'package:atur_uang/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({Key? key}) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  TextEditingController nameTec = TextEditingController();
  TextEditingController moneyTec = TextEditingController();

  Future saveUserData(ctx) async {
    if (nameTec.text.isEmpty) {
      snackbarMessage('Nama tidak boleh kosong');
      return;
    }

    if (moneyTec.text.isEmpty) {
      snackbarMessage('Masukan jumlah uang anda');
      return;
    }

    var boxUserData = Hive.box('user_data');

    await boxUserData.add(UserData(nameTec.text, int.parse(moneyTec.text)));

    var boxMoney = Hive.box('money');
    var money = MoneyModel(
        'Uang Masuk',
        DateFormat('EEEE, d MMM y', 'id').format(DateTime.now()),
        int.parse(moneyTec.text),
        '-');

    await boxMoney.add(money);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 108, 99, 255),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(160))),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 108, 99, 255),
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(140))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/art/art_image.png',
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                    controller: nameTec,
                    cursorColor: const Color.fromARGB(255, 108, 99, 255),
                    style: const TextStyle(fontSize: 14),
                    decoration: GlobalStyle.textFieldDecoration('Nama Anda')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: moneyTec,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  cursorColor: const Color.fromARGB(255, 108, 99, 255),
                  style: const TextStyle(fontSize: 14),
                  decoration: GlobalStyle.textFieldDecoration(
                      'Jumlah Uang Anda Sekarang'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  saveUserData(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 108, 99, 255),
                  minimumSize: const Size.fromHeight(45),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameTec.dispose();
    moneyTec.dispose();
    super.dispose();
  }
}
