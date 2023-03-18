import 'dart:collection';
import 'package:cashier/data/model/Invoice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/model/Product.dart';

class PrintPdf {
  static pw.Column printerItem(Product p, int quantity, int index , pw.Font ttf) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 13.h),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          mainAxisSize: pw.MainAxisSize.max,
          children: [
            pw.Text('${p.sellPrice * quantity}', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
            pw.Text('${p.sellPrice}', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
            pw.Text('$quantity', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
            pw.Text(p.name , style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl) ,
            pw.Text('(${index + 1})', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
          ],
        ),
        pw.Center(child: pw.Text('--------------------------------------------------------------------'))
    ],
    );
  }
  static pw.Column printerList(HashMap<Product, int> p , pw.Font ttf){
    List<Product> items = [];
    p.forEach((key, value) {items.add(key);});
    return pw.Column(
      children: [
        pw.SizedBox(height: 13.h),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          mainAxisSize: pw.MainAxisSize.max,
          children: [
            pw.Text(' سعر الكمية ', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
            pw.Text(' سعر المنتج ', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
            pw.Text(' الكمية ', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
            pw.Text(' اسم المنتج ' , style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl) ,
            pw.Text(' الترتيب ', style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl),
          ],
        ),
        pw.Column(children: List.generate(items.length, (index) {
          return printerItem(items[index], p[items[index]]??0, index, ttf);
        }))
      ],
    );
  }
  static Future<pw.Document> printInvoice(HashMap<Product, int> p, [String? time, double total =0]) async {
    final pw.Font ttf = await fontFromAssetBundle('assets/font2.ttf');
    if(time == null || time == 'null' ) {
      time = DateTime.now().toString();
    }
    final doc = pw.Document();
    if(total == 0) {
      p.forEach((key, value) {
        total += key.sellPrice * value;
      });
    }
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(child: pw.Text( 'اولاد مبروك'
                , style: pw.TextStyle(font: ttf, fontSize: 30),
                textDirection: pw.TextDirection.rtl)),
            pw.Center(child: pw.Text( ' التاريخ و الوقت $time '
                , style: pw.TextStyle(font: ttf, fontSize: 12),
                textDirection: pw.TextDirection.rtl)),
            printerList(p, ttf),
            pw.SizedBox(height: 15.h),
            pw.Center(child: pw.Text('--------------------------------------------------------------------'
                , style: pw.TextStyle(font: ttf, fontSize: 15),
                textDirection: pw.TextDirection.rtl)),
            pw.SizedBox(height: 15.h),
            pw.Center(child: pw.Text(' الاجمالي : $total'
                , style: pw.TextStyle(font: ttf, fontSize: 15),
                textDirection: pw.TextDirection.rtl))
          ]); // Center
        }));
    return doc;
  }
  static Future<void> checkOut(Invoice v) async {
    // var doc = await printInvoice(v.products,
    //     v.timestamp.toString(),v.price?? -1 );
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());
    // save to db
  }

}
