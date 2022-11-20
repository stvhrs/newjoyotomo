
import 'package:intl/intl.dart';
import 'package:newJoyo/helper/border2.dart';
import 'package:newJoyo/library/date_picker/src/web_date_picker.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/payment.dart';
import 'package:newJoyo/models/rincian_pembayaran.dart';
import 'package:newJoyo/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newJoyo/library/pdf/lib/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../helper/currency.dart';
import '../../../models/customer.dart';
import '../../../models/examples.dart';
import '../../../provider/trigger.dart';

class RincianDoc extends StatefulWidget {
  final Customer customer;
  const RincianDoc({Key? key, required this.customer}) : super(key: key);
  @override
  State<RincianDoc> createState() => _RincianDocState();
}

class _RincianDocState extends State<RincianDoc> {
  String defaul = 'Masih Kosong';
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  var asu = pw.Document();
  WidgetsToImageController controller = WidgetsToImageController();
  final bold = const TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
  final small = const TextStyle(fontSize: 10);
  List<Payment> payments = [];

  @override
  void initState() {
    widget.customer.rcp.target!.payments[0] = Payment(
        date: widget.customer.realization.target!.selesai,
        keterangan: 'Grand Total',
        saldo: widget.customer.realization.target!.biyaya,
        pay: 0);

    jumlahOpsi = widget.customer.rcp.target!.payments.length;
    payments.addAll(widget.customer.rcp.target!.payments);
    super.initState();
  }

  rebuild() {
    setState(() {});
  }

  late int jumlahOpsi;
  Widget _buildRincian(int i, BuildContext context, Payment payment) {
    return StatefulBuilder(builder: (
      BuildContext context,
      StateSetter setState,
    ) {
      totaling() {  
        if (i != 0) {
          payment.saldo = payments[i - 1].saldo - payment.pay;
          payments[i].saldo = payments[i - 1].saldo - payment.pay;
          if (payment.saldo.isNegative) {
            payments[i].saldo = 0;
            payment.saldo = 0;
          }
          Future.delayed(
            const Duration(milliseconds: 200),
            () {
              rebuild();
            },
          );
        }
      }

      return Container(
          margin: const EdgeInsets.only(
            top: 5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: WebDatePicker(
                    small: true,
                    initialDate: payment.date == 'DD/MM/YYYY'
                        ? null
                        : DateTime.parse(payment.date),
                    style: small,
                    onChange: (DateTime? value) {
                      if (value != null) {
                        payment.date = value.toIso8601String();
                        payments[i].date = value.toIso8601String();

                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                  initialValue: payment.keterangan,
                  style: small,
                  onChanged: (v) {
                    payments[i].keterangan = v;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                    readOnly: i == 0,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
                    initialValue:
                        i == 0 ? '' : formatCurrendcy.format(payment.pay),
                    onChanged: (v) {
                      payment.pay =
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                              .parse(v)
                              .toDouble();
                      payments[i].pay =
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                              .parse(v)
                              .toDouble();
                      totaling();
                      setState(() {});
                    },
                    style: small),
              ),
              Expanded(
                child: Text(
                    textAlign: TextAlign.right,
                    formatCurrendcy.format(payment.saldo),
                    style: small),
              ),
            ],
          ));
    });
  }

  bool showPrint = true;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.all(0),
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 251, 251, 251),
                  fontSize: 15,
                  height: 2),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none),
        ),
        child: Scaffold(
          floatingActionButton: Row(children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 100,
              ),
              child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 79, 117, 134),
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(5),
                child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.blue.shade600,
                    child: const Icon(Icons.save_as_rounded),
                    onPressed: () {
                      Customer cs = widget.customer;
                      cs.rcp.target!.payments.clear();
                      cs.rcp.target = RincianPembayarran(
                          rcpId: widget.customer.rcp.target!.rcpId);
                      cs.rcp.target!.payments.addAll(payments);
                      cs.proses = 'Pembayaran';
                      objectBox.insertCustomer(cs);
                    })),
            Padding(
                padding: const EdgeInsets.all(5),
                child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.red.shade400,
                    child: const Icon(Icons.picture_as_pdf),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Loading.....')));
                      widget.customer.proses = 'Pembayaran';
                      showPrint = false;
                      setState(() {});
                      Customer cs = widget.customer;
                      cs.rcp.target!.payments.clear();
                      cs.rcp.target = RincianPembayarran(
                          rcpId: widget.customer.rcp.target!.rcpId);
                      cs.rcp.target!.payments.addAll(payments);

                      final bytes = await controller.capture();
                      await createSpk(bytes!, cs.rcp.target!.rcpId, context,
                          'Rincian Pembayaran');
                      Provider.of<Trigger>(context, listen: false)
                          .selectCustomer(widget.customer, true);

                      objectBox.insertCustomer(cs);
                    })),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.print),
                  onPressed: () async {
                    final bytes = await controller.capture();
                    printPdf(bytes!);
                  }),
            )
          ]),
          body: Hero(
            tag: 4,
            child: Center(
              child:
                  LayoutBuilder(builder: (context, BoxConstraints constraints) {
                return Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
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
                          Container(
                              height: MediaQuery.of(context).size.height,
                              width:
                                  MediaQuery.of(context).size.height / 1.4142,
                              padding: const EdgeInsets.all(20),
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 10),
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
                              child: WidgetsToImage(
                                controller: controller,
                                child: Container(
                                    alignment: Alignment.center,
                                    //  padding: const EdgeInsets.all(20),

                                    width: constraints.maxHeight / 1.4,
                                    height: constraints.maxHeight,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Kop(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              widget.customer.rcp.target!.rcpId,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Kotak2(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'CUSTOMER',
                                                              style: bold,
                                                            ),
                                                          ],
                                                        ),
                                                        const Divider(
                                                          height: 2,
                                                          color: Colors.black,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            textAlign:
                                                                TextAlign.right,
                                                            widget.customer
                                                                .customerName,
                                                            style: bold,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            widget.customer
                                                                .alamat,
                                                            style: bold,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Kotak2(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'CAR DETAILS',
                                                              style: bold,
                                                            ),
                                                          ],
                                                        ),
                                                        const Divider(
                                                          height: 2,
                                                          color: Colors.black,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3),
                                                                      child:
                                                                          Text(
                                                                        'Kendaraan:',
                                                                        style:
                                                                            small,
                                                                      )),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(3),
                                                                    child: Text(
                                                                      'Nomor Rangka:',
                                                                      style:
                                                                          small,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3),
                                                                      child:
                                                                          Text(
                                                                        'Tipe:',
                                                                        style:
                                                                            small,
                                                                      )),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(3),
                                                                    child: Text(
                                                                      'Tanggal Invoce: ',
                                                                      style:
                                                                          small,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(3),
                                                                    child: Text(
                                                                      'Tanggal Garansi: ',
                                                                      style:
                                                                          small,
                                                                    ),
                                                                  ),
                                                                ]),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 40,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                                  child: Text(
                                                                    '${widget.customer.spk.target!.namaKendaraan} ',
                                                                    style:
                                                                        small,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 40,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                                  child: Text(
                                                                    widget
                                                                        .customer
                                                                        .spk
                                                                        .target!
                                                                        .noRangka,
                                                                    style:
                                                                        small,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            40,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    child: Text(
                                                                      widget.customer.spk.target!.tipeKendaraan,
                                                                      style:
                                                                          small,
                                                                    )),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            40,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    child: Text(
                                                                      DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(
                                                                        DateTime.parse(widget
                                                                            .customer
                                                                            .inv
                                                                            .target!
                                                                            .invoiceDate),
                                                                      ),
                                                                      style:
                                                                          small,
                                                                    )),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            40,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    child: Text(
                                                                      DateFormat('dd/MM/yyyy').format(DateTime.parse(widget
                                                                          .customer
                                                                          .inv
                                                                          .target!
                                                                          .soDate)),
                                                                      style:
                                                                          small,
                                                                    ))
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                top(),
                                                const Divider(
                                                  height: 2,
                                                  color: Colors.black,
                                                ),
                                                ...List.generate(
                                                    jumlahOpsi,
                                                    (index) => _buildRincian(
                                                        index,
                                                        context,
                                                        payments[index])),
                                                const Divider(
                                                  height: 2,
                                                  color: Colors.black,
                                                ),
                                                showPrint
                                                    ? Row(
                                                        children: [
                                                          IconButton(
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (jumlahOpsi >
                                                                          1 &&
                                                                      jumlahOpsi ==
                                                                          payments
                                                                              .length) {
                                                                    payments.removeAt(
                                                                        jumlahOpsi -
                                                                            1);
                                                                    jumlahOpsi =
                                                                        jumlahOpsi -
                                                                            1;
                                                                  }
                                                                });
                                                              },
                                                              icon: const Icon(Icons
                                                                  .remove_circle)),
                                                          IconButton(
                                                              color:
                                                                  Colors.green,
                                                              onPressed: () {
                                                                print('asu');
                                                                setState(() {
                                                                  payments.add(Payment(
                                                                      date: DateTime
                                                                              .now()
                                                                          .toIso8601String(),
                                                                      keterangan:
                                                                          'Keterangan',
                                                                      saldo: widget
                                                                          .customer
                                                                          .realization
                                                                          .target!
                                                                          .biyaya,
                                                                      pay: 0));
                                                                  jumlahOpsi =
                                                                      jumlahOpsi +
                                                                          1;
                                                                });

                                                                setState(() {});
                                                              },
                                                              icon: const Icon(Icons
                                                                  .add_circle)),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                                (payments.last.saldo < 1)
                                                    ? Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Image.asset(
                                                          'images/lunas.png',scale: 3,),
                                                    )
                                                    : const Text(
                                                        'BELUM LUNAS',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30,
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ])),
                              ))
                        ]));
              }),
            ),
          ),
        ));
  }

  Widget top() => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: const [
            Expanded(
              child: Text(
                "Tanggal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Keterangan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            Expanded(
              child: Text(
                "Jumlah Bayar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.right,
                "Saldo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ],
        ),
      );
}
