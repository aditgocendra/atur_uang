import 'dart:io';
import 'package:pdf/widgets.dart';

Future generatePdf(Document pdf) async {
  Directory dir = Directory('/storage/emulated/0/Download');

  final file = File("${dir.path}/laporan-keuangan.pdf");
  await file.writeAsBytes(await pdf.save());
}
