import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/product_item.dart';
import 'package:cashier/screens/gain/gain_cubit.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/model/Product.dart';

class PrintPdf {
  static pw.Column printerItem(
      Product p, int quantity, int index, pw.Font ttf) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 13.h),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          mainAxisSize: pw.MainAxisSize.max,
          children: [
            pw.Expanded(
              child: pw.Center(
                  child: pw.Text('${p.sellPrice * quantity}',
                      style: pw.TextStyle(font: ttf, fontSize: 16),
                      textDirection: pw.TextDirection.rtl)),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text('${p.sellPrice}',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text('$quantity',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(p.name,
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text('(${index + 1})',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
          ],
        ),
        pw.Center(
            child: pw.Text(
                '--------------------------------------------------------------------'))
      ],
    );
  }

  static pw.Column printerList(List<ProductItem> productItems, pw.Font ttf) {
    List<Product> products = [];
    for (var value in productItems) {
      products.add(value.product);
    }
    return pw.Column(
      children: [
        pw.SizedBox(height: 13.h),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          mainAxisSize: pw.MainAxisSize.max,
          children: [
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(' سعر الكمية ',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(' سعر المنتج ',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(' الكمية ',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(' اسم المنتج ',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(' الترتيب ',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl),
              ),
            ),
          ],
        ),
        pw.Column(
            children: List.generate(products.length, (index) {
          return printerItem(
              products[index], productItems[index].quantity, index, ttf);
        }))
      ],
    );
  }

  static Future<pw.Document> printInvoice(List<ProductItem> p,
      [String? time, double total = 0]) async {
    final pw.Font ttf = await fontFromAssetBundle('assets/font2.ttf');
    if (time == null || time == 'null') {
      time = DateTime.now().toString();
    }
    final doc = pw.Document();
    if (total == 0) {
      p.forEach((prod) {
        total += prod.product.sellPrice * prod.quantity;
      });
    }
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(
                child: pw.Text('اولاد مبروك',
                    style: pw.TextStyle(font: ttf, fontSize: 30),
                    textDirection: pw.TextDirection.rtl)),
            pw.Center(
                child: pw.Text(' التاريخ و الوقت $time ',
                    style: pw.TextStyle(font: ttf, fontSize: 12),
                    textDirection: pw.TextDirection.rtl)),
            printerList(p, ttf),
            pw.SizedBox(height: 15.h),
            pw.Center(
                child: pw.Text(
                    '--------------------------------------------------------------------',
                    style: pw.TextStyle(font: ttf, fontSize: 15),
                    textDirection: pw.TextDirection.rtl)),
            pw.SizedBox(height: 15.h),
            pw.Center(
                child: pw.Text(' الاجمالي : $total',
                    style: pw.TextStyle(font: ttf, fontSize: 15),
                    textDirection: pw.TextDirection.rtl))
          ]); // Center
        }));
    return doc;
  }

  static Future<void> checkOut(Invoice v, BuildContext context) async {
    double gain = 0.0;
    List<Product> list = [];
    for (ProductItem product in v.products) {
      gain += product.product.sellPrice - product.product.buyPrice;
      list.add(product.product);
      await SQLHelper.updateProduct(
          product.product.id!,
          product.product.name,
          (product.product.quantity - product.quantity),
          product.product.buyPrice,
          product.product.sellPrice);
    }
    list = v.products.map((e) {
      e.product.quantity = e.quantity;
      return e.product;
    }).toList();
    await SQLHelper.addInvoice(v.price!, list, gain);
    GainCubit.get(context).getInvoices();
    StorageCubit.get(context).getProducts();

    var doc = await printInvoice(
        v.products, v.date.toString().substring(0, 19), v.price ?? -1);
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
    // save to db
  }
}
