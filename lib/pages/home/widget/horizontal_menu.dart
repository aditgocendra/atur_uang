import 'package:atur_uang/pages/home/home_page.dart';
import 'package:atur_uang/pages/money_in/money_in_page.dart';
import 'package:atur_uang/pages/money_out/money_out_page.dart';
import 'package:atur_uang/pages/report/report.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class HorizontalMenu extends StatelessWidget {
  const HorizontalMenu({Key? key}) : super(key: key);

  Future resetData(ctx) async {
    await Hive.box('user_data').clear();
    await Hive.box('money').clear();
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoneyInPage(),
                    ),
                  ),
                  child: Menu(
                    icon: FontAwesomeIcons.moneyCheck,
                    titleMenu: 'Uang Masuk',
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoneyOutPage(),
                    ),
                  ),
                  child: Menu(
                    icon: FontAwesomeIcons.handsHolding,
                    titleMenu: 'Uang Keluar',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        title: const Text('Pengaturan Ulang'),
                        content: const Text(
                            'Semua data akan direset, Apakah anda yakin untuk mengatur ulang semuanya ?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              resetData(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Menu(
                    icon: FontAwesomeIcons.recycle,
                    titleMenu: 'Atur Ulang',
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Report(),
                    ),
                  ),
                  child: Menu(
                    icon: FontAwesomeIcons.moneyBillTransfer,
                    titleMenu: 'Laporan Keuangan',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  IconData icon;
  String titleMenu;

  Menu({Key? key, required this.icon, required this.titleMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 205, 205, 205),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color.fromARGB(255, 108, 99, 255),
            ),
            Text(
              titleMenu,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
