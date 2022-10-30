import 'dart:developer';

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:newJoyo/helper/border.dart';
import 'package:newJoyo/helper/border2.dart';
import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:newJoyo/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../models/customer.dart';

class InvoiceDoc extends StatefulWidget {
  final Customer customer;
  InvoiceDoc({Key? key, required this.customer}) : super(key: key);
  @override
  State<InvoiceDoc> createState() => _InvoiceDocState();
}

class _InvoiceDocState extends State<InvoiceDoc> {
  String defaul = 'Masih Kosong';
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  var asu = pw.Document();

  buildPdf() async {
    asu = pw.Document();
    double base = 2700;
    var img = (await rootBundle.load('images/logo.png')).buffer.asUint8List();

    asu = pw.Document();
    asu.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: ((pw.Context context) => pw.Container(
            height: base * 1.4,
            width: base,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
                          child: pw.Image(pw.MemoryImage(img), width: 80)),
                      pw.Column(
                        children: [
                          pw.Text(
                            textAlign: pw.TextAlign.justify,
                            'JOYOTOMO',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 23,
                                fontStyle: pw.FontStyle.italic),
                          ),
                          pw.Text(
                            textAlign: pw.TextAlign.justify,
                            'Gemolong, Gandurejo, 4567',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Text(defaul)
                ])))));

    log(defaul);
    var year = DateTime.now().year;
    var month = DateTime.now().month;
    Directory('D:/Invoice/$month-$year').create()
        // The created directory is returned as a Future.
        .then((Directory directory) async {
      final file = File("${directory.path}/$defaul.pdf");
      await file.writeAsBytes(await asu.save());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved: ${file.path}')));
    });
  }

  printPdf() async {
    log(defaul);
    var img = (await rootBundle.load('images/logo.png')).buffer.asUint8List();
    var asu2 = pw.Document();
    String s = defaul;
    asu2.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: ((pw.Context context) => pw.Center(
            child: pw.Container(
                height: 2700 * 1.4,
                width: 2700,
                child: pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
                          child: pw.Image(pw.MemoryImage(img), width: 80)),
                      pw.Column(
                        children: [
                          pw.Text(
                            textAlign: pw.TextAlign.justify,
                            'JOYOTOMO',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 23,
                                fontStyle: pw.FontStyle.italic),
                          ),
                          pw.Text(
                            textAlign: pw.TextAlign.justify,
                            'Gemolong, Gandurejo, 4567',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Text(s)
                ]))))));
    Printing.layoutPdf(
        usePrinterSettings: true,
        name: 'Steve',
        onLayout: (PdfPageFormat format) async => asu2.save());
  }

  final bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 11);
  final small= TextStyle(fontSize: 10);

  Widget _buildPartName(int i, BuildContext context, StockRalization stocks) {
    return StatefulBuilder(
      builder: (
        BuildContext context,
        StateSetter setState,
      ) =>
          Container(
              margin: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Text(stocks.partname,style: small),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(width: 100, child: Text(stocks.name,style: small)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Text(
                        formatCurrendcy.format(stocks.servicePrice),style: small
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Text(
                        formatCurrendcy.format(stocks.price),style: small
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Text(stocks.count.toString(),style: small),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(
                      formatCurrendcy.format(stocks.toalPrice),style: small,
                    ),
                  ),
                ],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 4,
        child: Center(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/icon.jpg',
                        ),
                        opacity: 0.3,
                        repeat: ImageRepeat.repeat,
                        scale: 20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Container( height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height / 1.4142,
                          padding: const EdgeInsets.all(20  ),
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 78, 77, 77)
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                         
                          child:Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(border: Border.all()),
                width: constraints.maxHeight / 1.4,
                height: constraints.maxHeight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Kop(),
                      Row(
                        children: [
                          Kotak2(
                              child: Column(
                                children: [
                                  Text(
                                    'CUSTOMER',
                                    style: bold,
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              height: 270,
                              width: 250),
                          Kotak2(
                              child: Column(
                                children: [
                                  Text(
                                    'CAR DETAILS',
                                    style: bold,
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              height: 270,
                              width: 250),
                        ],
                      ),
                      top,
                      ...List.generate(
                          widget.customer.realization.target!.stockItems.length,
                          (index) => _buildPartName(
                              index,
                              context,
                              widget.customer.realization.target!
                                  .stockItems[index])),
                    ])))]));
          }),
        ),
      ),
    );
  }

  Widget top = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Partname",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Service",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Count",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Total",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
    ],
  );
}
