import 'dart:convert';
import 'dart:html';
import 'package:pdf/widgets.dart';

Future generatePdf(Document pdf) async {
  List<int> bytes = await pdf.save();

  AnchorElement anchor = AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}");
  anchor.download = 'Laporan-Keuangan.pdf';
  anchor.click();
}
