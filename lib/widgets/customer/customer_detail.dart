import 'package:newJoyo/main.dart';

import 'package:newJoyo/models/customer.dart';
import 'package:newJoyo/models/examples.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:newJoyo/widgets/customer/invoice/invoice_doc.dart';
import 'package:newJoyo/widgets/customer/realization/realization_doc.dart';
import 'package:newJoyo/widgets/customer/spk/spk_doc.dart';
// ignore: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import 'mpi/mpi_doc.dart';

class CustomerDetails extends StatefulWidget {
  // final List<dynamic> CustomersHistory;
  // final bool empty;
  const CustomerDetails({Key? key}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trans.addListener(() {});
    _trans2.addListener(() {});
    _trans3.addListener(() {});
    _trans4.addListener(() {});
  }

  final TransformationController _trans = TransformationController();
 final navigatorKey = GlobalKey<NavigatorState>();
  final TransformationController _trans2 = TransformationController();

  final TransformationController _trans3 = TransformationController();

  final TransformationController _trans4 = TransformationController();
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<Trigger>(builder: (context, value, cshild) {
        return IntrinsicWidth(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.selectedCustomer.customerName,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Customer customer =
                          Provider.of<Trigger>(context, listen: false)
                              .selectedCustomer;
                      objectBox.deleteCustomer(customer.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade900,
                    )),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 40, top: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: 'Alamat : ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: value.selectedCustomer.alamat + '\n',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: value.selectedCustomer.namaKendaraan),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InteractiveViewer(
                  clipBehavior: Clip.none,
                  transformationController: _trans,
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      height: 297,
                      width: 210,
                      child: MouseRegion(
                          cursor: SystemMouseCursors.zoomIn,
                          onExit: (event) {
                            _trans.value = Matrix4.identity();
                          },
                          onEnter: (value) {
                            _trans.value = Matrix4(
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              -100,
                              -150,
                              0,
                              1,
                            );
                          },
                          // onTap: () {
                          //
                          // },
                          child: Center(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => SpkDoc(
                                          customer: value.selectedCustomer),
                                    ));
                                  },
                                  child: PdfPreview(
                                    useActions: false,
                                    shouldRepaint: true,
                                    loadingWidget: Image.asset(
                                      'images/logo.png',
                                      width: 100,
                                    ),
                                    previewPageMargin: const EdgeInsets.all(0),
                                    build: (format) => generateCalendar(
                                        value.selectedCustomer,
                                        value.selectedCustomer.spk.target!),
                                  ))))),
                ),
                InteractiveViewer(
                  clipBehavior: Clip.none,
                  transformationController: _trans2,
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      height: 297,
                      width: 210,
                      child: MouseRegion(
                          cursor: SystemMouseCursors.zoomIn,
                          onExit: (event) {
                            _trans2.value = Matrix4.identity();
                          },
                          onEnter: (value) {
                            _trans2.value = Matrix4(
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              -100,
                              -150,
                              0,
                              1,
                            );
                          },
                          // onTap: () {
                          //
                          // },
                          child: Center(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => MpiDoc(
                                          customer: value.selectedCustomer),
                                    ));
                                  },
                                  child: PdfPreview(
                                    useActions: false,
                                    shouldRepaint: true,
                                    loadingWidget: Image.asset(
                                      'images/logo.png',
                                      width: 100,
                                    ),
                                    previewPageMargin: const EdgeInsets.all(0),
                                    build: (format) => generateCalendar(
                                        value.selectedCustomer,
                                        value.selectedCustomer.spk.target!),
                                  ))))),
                ),
                InteractiveViewer(
                  clipBehavior: Clip.none,
                  transformationController: _trans3,
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8)),
                      height: 297,
                      width: 210,
                      child: MouseRegion(
                          cursor: SystemMouseCursors.zoomIn,
                          onExit: (event) {
                            _trans3.value = Matrix4.identity();
                          },
                          onEnter: (value) {
                            _trans3.value = Matrix4(
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              -100,
                              -150,
                              0,
                              1,
                            );
                          },
                          // onTap: () {
                          //
                          // },
                          child: Center(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RealizationDoc(
                                          customer: value.selectedCustomer),
                                    ));
                                  },
                                  child: PdfPreview(
                                    useActions: false,
                                    shouldRepaint: true,
                                    loadingWidget: Image.asset(
                                      'images/logo.png',
                                      width: 100,
                                    ),
                                    previewPageMargin: const EdgeInsets.all(0),
                                    build: (format) => generateCalendar(
                                        value.selectedCustomer,
                                        value.selectedCustomer.spk.target!),
                                  ))))),
                ),
                InteractiveViewer(
                  clipBehavior: Clip.none,
                  transformationController: _trans4,
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      height: 297,
                      width: 210,
                      child: MouseRegion(
                          cursor: SystemMouseCursors.zoomIn,
                          onExit: (event) {
                            _trans4.value = Matrix4.identity();
                          },
                          onEnter: (value) {
                            _trans4.value = Matrix4(
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              0,
                              0,
                              0,
                              1.8,
                              0,
                              -100,
                              -150,
                              0,
                              1,
                            );
                          },
                          // onTap: () {
                          //
                          // },
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  // if (value.selectedCustomer.realization.target!
                                  //     .done) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InvoiceDoc(
                                            customer: value.selectedCustomer,
                                          )));
                                  // }
                                },
                                child: Hero(
                                    tag: 4,
                                    flightShuttleBuilder: (BuildContext
                                                flightContext,
                                            Animation<double> animation,
                                            HeroFlightDirection flightDirection,
                                            BuildContext fromHeroContext,
                                            BuildContext toHeroContext) =>
                                        Material(child: toHeroContext.widget),
                                    child: PdfPreview(
                                      useActions: false,
                                      shouldRepaint: true,
                                      loadingWidget: Image.asset(
                                        'images/logo.png',
                                        width: 100,
                                      ),
                                      previewPageMargin:
                                          const EdgeInsets.all(0),
                                      build: (format) => generateCalendar(
                                          value.selectedCustomer,
                                          value.selectedCustomer.spk.target!),
                                    ))),
                          ))),
                ),
              ],
            )
          ]),
        );
      }),
    );
  }

  Matrix4 scaleXYZTransform({
    double scaleX = 1.00,
    double scaleY = 1.00,
    double scaleZ = 1.00,
  }) {
    return Matrix4.diagonal3Values(scaleX, scaleY, scaleZ);
  }
}
