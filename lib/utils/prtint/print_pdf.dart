import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintPdf extends StatelessWidget {
  const PrintPdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () async {
      final doc = pw.Document();

      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text('Hello World'),
            ); // Center
          })); // Page
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => doc.save());
    }, child: const Text('حفظ و طباعة الفاتورة'));
  }
}
