import 'dart:developer';

import 'dart:io';
import 'package:newJoyo/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceDoc extends StatefulWidget {
  const InvoiceDoc({Key? key}) : super(key: key);
  @override
  State<InvoiceDoc> createState() => _InvoiceDocState();
}

class _InvoiceDocState extends State<InvoiceDoc> {
  String defaul = 'Masih Kosong';

  var asu = pw.Document();

  buildPdf() async {
    asu = pw.Document();
    double base = 1000;
    var img = (await rootBundle.load('images/logo.png')).buffer.asUint8List();

    asu = pw.Document();
    asu.addPage(pw.Page(margin: const pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: ((pw.Context context) =>  pw.Container(
                height: base * 1.4,
                width: base,
                child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,
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
    var year =DateTime.now().year;
    var month=DateTime.now().month;
    Directory('D:/Invoice/$month-$year').create()
    // The created directory is returned as a Future.
    .then((Directory directory) async{

      final file = File("${directory.path}/$defaul.pdf");
    await file.writeAsBytes(await asu.save());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved: ${file.path}')));
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
                height: 1000 * 1.4,
                width: 1000,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Row(children: [
      //   const Spacer(),
      //   FloatingActionButton(
      //       child: const Text('Save PDF'),
      //       onPressed: () {
      //         buildPdf();
      //       }),
      //   FloatingActionButton(
      //       child: const Text('Print PDF'),
      //       onPressed: () async {
      //         await printPdf();
      //       })
      // ]),
      body: Hero(tag: 4,
        child: Center(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(border: Border.all()),
                width: constraints.maxHeight / 1.4,
                height: constraints.maxHeight,
                child: Column(children: [
                  const Kop(),
                  TextFormField(
                    initialValue: defaul,
                    onChanged: (value) {
                      setState(() {
                        defaul = value.toString();
                      });
                    },
                  )
                ]));
          }),
        ),
      ),
    );
  }
}
