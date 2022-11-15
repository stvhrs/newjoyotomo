import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newJoyo/models/customer.dart';
import 'package:flutter/services.dart';
import 'package:newJoyo/models/spk.dart';
import 'package:newJoyo/library/pdf/lib/pdf.dart';

import 'package:newJoyo/library/pdf/lib/widgets.dart' as pw;
import 'package:newJoyo/widgets/customer/spk/spk_doc.dart';
import 'package:printing/printing.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void printKosongan(String name) async {
  final pdf = await rootBundle.load(name);
  await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
}

void printPdf(Uint8List uint8list) async {
  final document = pw.Document();
  final pw.MemoryImage memoryImage = pw.MemoryImage(uint8list);
  // if (await File(filepath).exists()) {
  //   return;
  // }

  document.addPage(pw.Page(
      margin: const pw.EdgeInsets.all(20),
      pageFormat: PdfPageFormat.a4,
      build: ((pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.topCenter,
          child: pw.Image(memoryImage),
        );
      })));

  Printing.layoutPdf(
    usePrinterSettings: true,
    onLayout: (format) async => document.save(),
  );
}

Future<Uint8List> generateCalendar(Customer customer, String filepath) async {
  //Create a PDF document.

  final document = pw.Document();
  pw.MemoryImage image;
  if (await File(filepath).exists()) {
    return File(filepath).readAsBytesSync();
  } else {
    image = pw.MemoryImage(
      (await rootBundle.load('images/logo.png')).buffer.asUint8List(),
    );

    document.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: ((pw.Context context) => pw.Container(
              height: 1000 * 1.4,
              width: 1000,
              child: pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Image(
                    image,
                  )),
            ))));

    return document.save();
  }
}

createSpk(Uint8List uint8list, String fileName, BuildContext context,
    String folder) async {
  final document2 = pw.Document();

  final pw.MemoryImage memoryImage = pw.MemoryImage(uint8list);
  document2.addPage(pw.Page(
      margin: pw.EdgeInsets.all(20),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.topCenter,
          child: pw.Image(memoryImage),
        );
      }));
  document2.save();
  var year = DateTime.now().year;
  var month = DateTime.now().month;
  fileName = fileName.replaceAll('/', '-');
  Directory('D:/$folder/$year-$month').create()
      // The created directory is returned as a Future.
      .then((Directory directory) async {
    final file = File("${directory.path}/$fileName.pdf");
    await file.writeAsBytes(await document2.save());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Saved: ${file.path}')));
  });
}







  // build(){
  
//       return pw.Center(
//         child:  pw.Container(
//             decoration: pw.BoxDecoration(border: pw.Border.all()),
//             // width: constraints.maxHeight / 1.4,
//             // height: constraints.maxHeight,
//             child: pw.SizedBox(
//                 child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
               
//                     pw. Text('SAVE'),
//                pw. Center(
                 
//                     child: pw.Text(
//                       "MULTI POINT INSPETION `MPI`",
//                       style:
//                           pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 17),
//                     ),
                
//                 ),
//                pw. Row(
//                   mainAxisAlignment:pw. MainAxisAlignment.spaceEvenly,
//                   children: [
//               pw.      Container(
//                       margin: pw.EdgeInsets.only(top: 10, bottom: 10),
//                       alignment: pw.Alignment.center,
//                       decoration:pw. BoxDecoration(
//                           color:PdfColor.fromRYB(1,3, 2), border:pw. Border.all()),
//                       child:pw. Text('Checked and Okay',
//                           style:  pw.TextStyle(
//                               fontSize: 11, fontWeight:pw. FontWeight.bold)),
//                        width: constraints.maxHeight / 1.4 / 3.2,
//                     ),
//                    pw. Container(
//                       alignment: pw.Alignment.center,
//                       decoration: pw.BoxDecoration(
//                           color: Colors.yellow, border: pw.Border.all()),
//                       child:pw. Text('Attention Recomended',
//                           style: pw. TextStyle(
//                               fontSize: 11, fontWeight:pw. FontWeight.bold)),
//                       width: constraints.maxHeight / 1.4 / 3.2,
//                     ),
//                    pw. Container(
//                       alignment:pw. Alignment.center,
//                       decoration: pw.BoxDecoration(
//                           color: Colors.red, border:pw. Border.all()),
//                       child: pw.Text('Attention Required',
//                           style:pw.TextStyle(
//                               fontSize: 11, fontWeight: pw.FontWeight.bold)),
//                       width: constraints.maxHeight / 1.4 / 3.2,
//                     )
//                   ],
//                 ),
//                pw. Container(
//                   width: constraints.maxHeight / 1.4,
//                   decoration: pw. BoxDecoration(
//                     border:pw. Border(
//                       top: pw.BorderSide(
//                           width: 1, color: Color.fromARGB(255, 0, 0, 0)),
//                       bottom: pw.BorderSide(
//                           width: 1, color: Color.fromARGB(255, 0, 0, 0)),
//                     ),
//                   ),
//                   child:pw. Row(
//                       children: [
//                        pw. Container(
//                           padding:pw. EdgeInsets.all(4),
//                           width: constraints.maxHeight / 1.4 / 2.928,
//                           child: pw. Text('BRAKES - TIRES - ALIGNMENT',
//                               style:pw. TextStyle(
//                                   fontSize: 11, fontWeight:pw. FontWeight.bold)),
//                         ),
//                       pw.  VerticalDivider(
//                           color: Colors.black,
//                         ),
//                       pw.  Container(
//                           width: 102.5,
//                           child:pw. Text('PRICE',
//                               style: pw.TextStyle(
//                                   fontSize: 11, fontWeight:pw. FontWeight.bold)),
//                         ),
//                       pw.VerticalDivider(
//                           color: Colors.black,
//                         ),
//                       pw.  Container(
//                           width: 100,
//                           child: pw.Text('REMARK',
//                               style: TextStyle(
//                                   fontSize: 11, fontWeight: FontWeight.bold)),
//                         ),
//                       ],
//                     ),
//                   ),
                
//                 pw.SeparatedColumn(
                   
//                     separatorBuilder: (context, index) {
//                       if (data[index].category != data[index + 1].category) {
//                         return Container(
//                           decoration: const BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                   width: 1,
//                                   color: Color.fromARGB(255, 0, 0, 0)),
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: Row(
//                             children: [
//                               Text(data[index + 1].category,
//                                   style: const TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.bold)),
//                               Spacer()
//                             ],
//                           ),
//                         );
//                       }
//                       return const SizedBox();
//                     },
//                     children: data.mapIndexed((index, element) {
//                       return Container(
//                           width: constraints.maxHeight / 1.4,
//                           decoration: const BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                   width: 1,
//                                   color: Color.fromARGB(255, 0, 0, 0)),
//                             ),
//                           ),
//                           child: IntrinsicHeight(
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: constraints.maxHeight / 1.4 / 2.8,
//                                   decoration: const BoxDecoration(
//                                     border: Border(
//                                       right: BorderSide(
//                                           width: 1,
//                                           color: Color.fromARGB(255, 0, 0, 0)),
//                                     ),
//                                   ),
//                                   child: Stack(
//                                     clipBehavior: Clip.none,
//                                     children: [
//                                       Transform.scale(
//                                           alignment: Alignment.centerLeft,
//                                           scale: 0.6,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 width: 30,
//                                                 height: 16,
//                                                 child: Checkbox(
//                                                     activeColor: Colors.green,
//                                                     materialTapTargetSize:
//                                                         MaterialTapTargetSize
//                                                             .shrinkWrap,
//                                                     value:
//                                                         data[index].attention ==
//                                                             1,
//                                                     onChanged: (sd) {
//                                                       setState(() {});
//                                                       if (data[index]
//                                                               .attention ==
//                                                           1) {
//                                                         data[index].attention =
//                                                             0;
//                                                       } else {
//                                                         data[index].attention =
//                                                             1;
//                                                       }
//                                                     }),
//                                               ),
//                                               SizedBox(
//                                                 width: 30,
//                                                 height: 16,
//                                                 child: Checkbox(
//                                                     activeColor: Colors.yellow,
//                                                     materialTapTargetSize:
//                                                         MaterialTapTargetSize
//                                                             .shrinkWrap,
//                                                     value:
//                                                         data[index].attention ==
//                                                             2,
//                                                     onChanged: (sd) {
//                                                       setState(() {});
//                                                       if (data[index]
//                                                               .attention ==
//                                                           2) {
//                                                         data[index].attention =
//                                                             0;
//                                                       } else {
//                                                         data[index].attention =
//                                                             2;
//                                                       }
//                                                     }),
//                                               ),
//                                               SizedBox(
//                                                 width: 30,
//                                                 height: 16,
//                                                 child: Checkbox(
//                                                     activeColor: Colors.red,
//                                                     materialTapTargetSize:
//                                                         MaterialTapTargetSize
//                                                             .shrinkWrap,
//                                                     value:
//                                                         data[index].attention ==
//                                                             3,
//                                                     onChanged: (sd) {
//                                                       setState(() {});
//                                                       if (data[index]
//                                                               .attention ==
//                                                           3) {
//                                                         data[index].attention =
//                                                             0;
//                                                       } else {
//                                                         data[index].attention =
//                                                             3;
//                                                       }
//                                                     }),
//                                               )
//                                             ],
//                                           )),
//                                       Positioned(
//                                         left: 55,
//                                         top: 1,
//                                         child: Text(
//                                           data[index].name,
//                                           textAlign: TextAlign.left,
//                                           style: const TextStyle(fontSize: 10),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 100,
//                                   margin: EdgeInsets.only(left: 10),
//                                   child: TextFormField(
//                                       onChanged: (value) {
//                                         data[index].price =
//                                             NumberFormat.currency(
//                                                     locale: 'id_ID',
//                                                     symbol: 'Rp ')
//                                                 .parse(value)
//                                                 .toDouble();
                                                
//                                       },
//                                       inputFormatters: [
//                                         FilteringTextInputFormatter.digitsOnly,
//                                         CurrencyInputFormatter(),
//                                       ],
//                                       scrollPadding: EdgeInsets.all(0),
//                                       decoration: const InputDecoration(
//                                         isDense: true, //
//                                         border: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         enabledBorder: InputBorder.none,
//                                         errorBorder: InputBorder.none,
//                                         disabledBorder: InputBorder.none,
//                                         contentPadding: EdgeInsets.all(0),
//                                       ),
//                                       initialValue:
//                                           data[index].price.toString() == '0.0'
//                                               ? 'Rp 0,00'
//                                               :  formatCurrendcy
//                                                 .format(data[index].price).toString(),
//                                       style: const TextStyle(
//                                         fontSize: 10,
//                                       )),
//                                 ),
//                                 const VerticalDivider(
//                                   color: Colors.black,
//                                 ),
//                                 Container(
//                                   width: 200,
//                                   // margin: EdgeInsets.only(left: 10),
//                                   child: TextFormField(
//                                       onChanged: (v) {
//                                         data[index].remark = v;
//                                       },
//                                       scrollPadding: EdgeInsets.all(0),
//                                       decoration: const InputDecoration(
//                                         isDense: true, //
//                                         border: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         enabledBorder: InputBorder.none,
//                                         errorBorder: InputBorder.none,
//                                         disabledBorder: InputBorder.none,
//                                         contentPadding: EdgeInsets.all(0),
//                                       ),
//                                       initialValue: data[index].remark,
//                                       style: const TextStyle(
//                                         fontSize: 10,
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ));
//                     }).toList()),
//               ],
//             )),
//           ),
        
//       );
    
// }