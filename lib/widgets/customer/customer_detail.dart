import 'package:newJoyo/main.dart';

import 'package:newJoyo/models/customer.dart';
import 'package:newJoyo/models/examples.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:newJoyo/widgets/customer/invoice/invoice_doc.dart';
import 'package:newJoyo/widgets/customer/realization/realization_doc.dart';
import 'package:newJoyo/widgets/customer/rincian/rincian_doc.dart';
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
    _trans5.addListener(() {});
  }

  final TransformationController _trans = TransformationController();
  final navigatorKey = GlobalKey<NavigatorState>();
  final TransformationController _trans2 = TransformationController();

  final TransformationController _trans3 = TransformationController();

  final TransformationController _trans4 = TransformationController();
  final TransformationController _trans5 = TransformationController();
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  TextStyle idStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4,
          spreadRadius: 3,
          offset: Offset(2, 2),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      margin: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      child: Consumer<Trigger>(builder: (context, value, cshild) {
        return IntrinsicWidth(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      textAlign: TextAlign.left,
                      value.selectedCustomer.customerName,
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
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
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Alamat : ' +
                                    value.selectedCustomer.alamat +
                                    '\n',
                              ),
                              TextSpan(
                                text: 'Kendaraan : ' +
                                    value.selectedCustomer.spk.target!
                                        .namaKendaraan,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                // IconButton(
                //     onPressed: () {
                //       Customer customer =
                //           Provider.of<Trigger>(context, listen: false)
                //               .selectedCustomer;
                //       objectBox.deleteCustomer(customer.id);
                //     },
                //     icon: Icon(
                //       Icons.delete,
                //       color: Colors.red.shade900,
                //     )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.selectedCustomer.spk.target!.jtId,
                      style: idStyle,
                    ),
                    InteractiveViewer(
                      maxScale: 8,
                      clipBehavior: Clip.none,
                      transformationController: _trans,
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          height: 297 * 0.9,
                          width: 210 * 0.9,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.zoomIn,
                              onExit: (event) {
                                _trans.value = Matrix4.identity();
                              },
                              onEnter: (value) {
                                _trans.value = Matrix4(
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
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
                                          previewPageMargin:
                                              const EdgeInsets.all(5),
                                          build: (format) async {
                                            String month = '';
                                            String year = '';
                                            month = DateTime.parse(value
                                                    .selectedCustomer.dateTime)
                                                .month
                                                .toString();
                                            year = DateTime.parse(value
                                                    .selectedCustomer.dateTime)
                                                .year
                                                .toString();

                                            String id = value.selectedCustomer
                                                .spk.target!.jtId
                                                .replaceAll('/', '-');
                                            return await generateCalendar(
                                              value.selectedCustomer,
                                              'D:\\SPK\\$year-$month\\$id.pdf',
                                            );
                                          }))))),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.selectedCustomer.mpi.target!.mpiId,
                      style: idStyle,
                    ),
                    InteractiveViewer(
                        maxScale: 8,
                        clipBehavior: Clip.none,
                        transformationController: _trans2,
                        child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            height: 297 * 0.9,
                            width: 210 * 0.9,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.zoomIn,
                              onExit: (event) {
                                _trans2.value = Matrix4.identity();
                              },
                              onEnter: (value) {
                                _trans2.value = Matrix4(
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
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
                                        previewPageMargin:
                                            const EdgeInsets.all(5),
                                        build: (format) async {
                                          String month = '';
                                          String year = '';
                                          month = DateTime.parse(value
                                                  .selectedCustomer.dateTime)
                                              .month
                                              .toString();
                                          year = DateTime.parse(value
                                                  .selectedCustomer.dateTime)
                                              .year
                                              .toString();

                                          String id = value.selectedCustomer.mpi
                                              .target!.mpiId
                                              .replaceAll('/', '-');
                                          return await generateCalendar(
                                            value.selectedCustomer,
                                            'D:\\MPI\\$year-$month\\$id.pdf',
                                          );
                                        })),
                              ),
                            )))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.selectedCustomer.realization.target!.rlId,
                      style: idStyle,
                    ),
                    InteractiveViewer(
                      maxScale: 8,
                      clipBehavior: Clip.none,
                      transformationController: _trans3,
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(8)),
                          height: 297 * 0.9,
                          width: 210 * 0.9,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.zoomIn,
                              onExit: (event) {
                                _trans3.value = Matrix4.identity();
                              },
                              onEnter: (value) {
                                _trans3.value = Matrix4(
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
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
                                          previewPageMargin:
                                              const EdgeInsets.all(5),
                                          build: (format) async {
                                            String month = '';
                                            String year = '';
                                            month = DateTime.parse(value
                                                    .selectedCustomer.dateTime)
                                                .month
                                                .toString();
                                            year = DateTime.parse(value
                                                    .selectedCustomer.dateTime)
                                                .year
                                                .toString();

                                            String id = value.selectedCustomer
                                                .realization.target!.rlId
                                                .replaceAll('/', '-');
                                            return await generateCalendar(
                                              value.selectedCustomer,
                                              'D:\\Realisasi\\$year-$month\\$id.pdf',
                                            );
                                          }))))),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.selectedCustomer.inv.target!.invId,
                      style: idStyle,
                    ),
                    InteractiveViewer(
                      maxScale: 8,
                      clipBehavior: Clip.none,
                      transformationController: _trans4,
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          height: 297 * 0.9,
                          width: 210 * 0.9,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.zoomIn,
                              onExit: (event) {
                                _trans4.value = Matrix4.identity();
                              },
                              onEnter: (value) {
                                _trans4.value = Matrix4(
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => InvoiceDoc(
                                                    customer:
                                                        value.selectedCustomer,
                                                  )));
                                      // }
                                    },
                                    child: Hero(
                                        tag: 4,
                                        flightShuttleBuilder: (BuildContext
                                                    flightContext,
                                                Animation<double> animation,
                                                HeroFlightDirection
                                                    flightDirection,
                                                BuildContext fromHeroContext,
                                                BuildContext toHeroContext) =>
                                            Material(
                                                child: toHeroContext.widget),
                                        child: PdfPreview(
                                            useActions: false,
                                            shouldRepaint: true,
                                            loadingWidget: Image.asset(
                                              'images/logo.png',
                                              width: 100,
                                            ),
                                            previewPageMargin:
                                                const EdgeInsets.all(5),
                                            build: (format) async {
                                              String month = '';
                                              String year = '';
                                              month = DateTime.parse(value
                                                      .selectedCustomer
                                                      .dateTime)
                                                  .month
                                                  .toString();
                                              year = DateTime.parse(value
                                                      .selectedCustomer
                                                      .dateTime)
                                                  .year
                                                  .toString();

                                              String id = value.selectedCustomer
                                                  .inv.target!.invId
                                                  .replaceAll('/', '-');
                                              return await generateCalendar(
                                                value.selectedCustomer,
                                                'D:\\Invoice\\$year-$month\\$id.pdf',
                                              );
                                            }))),
                              ))),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.selectedCustomer.rcp.target!.rcpId,
                      style: idStyle,
                    ),
                    InteractiveViewer(
                      maxScale: 8,
                      clipBehavior: Clip.none,
                      transformationController: _trans5,
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          height: 297 * 0.9,
                          width: 210 * 0.9,
                          child: MouseRegion(
                              cursor: SystemMouseCursors.zoomIn,
                              onExit: (event) {
                                _trans5.value = Matrix4.identity();
                              },
                              onEnter: (value) {
                                _trans5.value = Matrix4(
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  2.1,
                                  0,
                                  -200,
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => RincianDoc(
                                                    customer:
                                                        value.selectedCustomer,
                                                  )));
                                      // }
                                    },
                                    child: Hero(
                                        tag: 5,
                                        flightShuttleBuilder: (BuildContext
                                                    flightContext,
                                                Animation<double> animation,
                                                HeroFlightDirection
                                                    flightDirection,
                                                BuildContext fromHeroContext,
                                                BuildContext toHeroContext) =>
                                            Material(
                                                child: toHeroContext.widget),
                                        child: PdfPreview(
                                            useActions: false,
                                            shouldRepaint: true,
                                            loadingWidget: Image.asset(
                                              'images/logo.png',
                                              width: 100,
                                            ),
                                            previewPageMargin:
                                                const EdgeInsets.all(5),
                                            build: (format) async {
                                              String month = '';
                                              String year = '';
                                              month = DateTime.parse(value
                                                      .selectedCustomer
                                                      .dateTime)
                                                  .month
                                                  .toString();
                                              year = DateTime.parse(value
                                                      .selectedCustomer
                                                      .dateTime)
                                                  .year
                                                  .toString();

                                              String id = value.selectedCustomer
                                                  .rcp.target!.rcpId
                                                  .replaceAll('/', '-');
                                              return await generateCalendar(
                                                value.selectedCustomer,
                                                'D:\\Rincian Pembayaran\\$year-$month\\$id.pdf',
                                              );
                                            }))),
                              ))),
                    ),
                  ],
                ),
              ],
            ),const Spacer(),
            Container(margin: const EdgeInsets.only(bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        printKosongan('images/SPK.pdf');
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('SPK Kosong')),

                  ElevatedButton.icon(
                      onPressed: () async {
                        printKosongan('images/MPI.pdf');
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('MPI Kosong')),

                  ElevatedButton.icon(
                      onPressed: () async {
                        printKosongan('images/Realisasi.pdf');
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Realisasi Kosong')),
                  ElevatedButton.icon(
                      onPressed: () async {
                        printKosongan('images/Invoice.pdf');
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Invoice Kosong')),
                  ElevatedButton.icon(
                      onPressed: () async {
                        printKosongan('images/Rincian.pdf');
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Rincian Kosong'))
                ],
              ),
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
