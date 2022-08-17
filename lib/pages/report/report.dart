// import 'dart:convert';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:atur_uang/globals/global_function.dart';
import 'package:atur_uang/globals/global_style.dart';
import 'package:atur_uang/model/money.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:atur_uang/globals/pdf_generate_web.dart'
    if (dart.library.io) 'package:atur_uang/globals/pdf_generate_android.dart'
    as generator_pdf;

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  var month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  var boxMoney = Hive.box('money');
  List<MoneyModel> dataMoney = [];

  String? monthSelected;
  TextEditingController yearTec = TextEditingController();

  void filterData() {
    setState(() {
      if (monthSelected == null) {
        return;
      }

      if (yearTec.text.isEmpty) {
        return;
      }

      dataMoney.clear();
      for (var money in boxMoney.values) {
        String dateDay = money.dateDay;
        String year = dateDay.substring(dateDay.length - 4, dateDay.length);
        String month =
            dateDay.substring(dateDay.length - 8, dateDay.length - 5);

        if (yearTec.text == year && monthSelected == month) {
          dataMoney.add(money);
        }
      }
    });
  }

  @override
  void initState() {
    for (var element in boxMoney.values) {
      dataMoney.add(element);
    }
    super.initState();
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
          'Laporan Keuangan',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          width: 50,
                          child: const Divider(
                            thickness: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            controller: yearTec,
                            maxLength: 4,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            cursorColor:
                                const Color.fromARGB(255, 108, 99, 255),
                            style: const TextStyle(fontSize: 14),
                            decoration:
                                GlobalStyle.textFieldDecoration('Tahun'),
                          ),
                        ),
                        DropdownSearch<String>(
                          items: month,
                          onChanged: (String? value) {
                            monthSelected = value;
                          },
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            fit: FlexFit.loose,
                            menuProps: const MenuProps(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            containerBuilder: (ctx, popupWidget) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Flexible(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                      child: popupWidget,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.blue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              labelText: "Bulan",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              filterData();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 108, 99, 255),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              minimumSize: const Size.fromHeight(45),
                            ),
                            child: const Text(
                              'Filter',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              FontAwesomeIcons.sort,
              size: 19,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              final pdf = pw.Document();

              var data =
                  await rootBundle.load("assets/fonts/Poppins-Medium.ttf");

              final ttf = pw.Font.ttf(data.buffer.asByteData());

              const tableHeaders = [
                'Tipe',
                'Hari / Tanggal',
                'Jumlah Uang',
                'Keterangan'
              ];

              pdf.addPage(
                pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (pw.Context context) {
                    return pw.Container(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                        children: [
                          pw.Table.fromTextArray(
                            border: null,
                            cellAlignment: pw.Alignment.centerLeft,
                            headerDecoration: const pw.BoxDecoration(
                              borderRadius:
                                  pw.BorderRadius.all(pw.Radius.circular(2)),
                            ),
                            headerHeight: 25,
                            cellHeight: 40,
                            cellAlignments: {
                              0: pw.Alignment.center,
                              1: pw.Alignment.center,
                              2: pw.Alignment.center,
                              3: pw.Alignment.center,
                            },
                            headerStyle: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize: 10,
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            cellStyle: pw.TextStyle(
                              color: PdfColors.black,
                              font: ttf,
                              fontSize: 10,
                            ),
                            rowDecoration: const pw.BoxDecoration(
                              border: pw.Border(
                                bottom: pw.BorderSide(
                                  width: .5,
                                ),
                              ),
                            ),
                            headers: List<String>.generate(
                              tableHeaders.length,
                              (col) => tableHeaders[col],
                            ),
                            data: List<List<String>>.generate(
                              dataMoney.length,
                              (row) => List<String>.generate(
                                tableHeaders.length,
                                (col) => dataMoney[row].getIndex(col),
                              ),
                            ),
                          )
                        ],
                      ),
                    ); // Center
                  },
                ),
              );
              generator_pdf.generatePdf(pdf);

              if (!kIsWeb) {
                // ignore: use_build_context_synchronously
                GlobalFunction.snackbarMessage(context,
                    'Laporan berhasil dibuat silahkan cek di folder unduhan');
              }
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 108, 99, 255),
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(45),
            ),
            child: const Text(
              'Buat Laporan',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: dataMoney.isEmpty
            ? Container(
                margin: const EdgeInsets.all(16),
                child: const Center(child: Text('Belum ada satupun data')),
              )
            : ListView.builder(
                itemCount: dataMoney.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Container(
                    key: UniqueKey(),
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 205, 205, 205),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        dataMoney[index].title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        dataMoney[index].dateDay,
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp. ',
                          decimalDigits: 0,
                        ).format(dataMoney[index].totalMoney),
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
      ),
    );
  }
}
