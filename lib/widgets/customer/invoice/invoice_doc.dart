import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:newJoyo/helper/border2.dart';
import 'package:newJoyo/library/date_picker/src/web_date_picker.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/invoice.dart';
import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:newJoyo/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:newJoyo/library/pdf/lib/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../models/customer.dart';
import '../../../models/examples.dart';
import '../../../provider/trigger.dart';

class InvoiceDoc extends StatefulWidget {
  final Customer customer;
  const InvoiceDoc({Key? key, required this.customer}) : super(key: key);
  @override
  State<InvoiceDoc> createState() => _InvoiceDocState();
}

class _InvoiceDocState extends State<InvoiceDoc> {
  String defaul = 'Masih Kosong';
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  var asu = pw.Document();
  final WidgetsToImageController _widgetsToImageController =
      WidgetsToImageController();
  Widget buildAttention(int i) {
    if (i == 1) {
      return const Icon(
        Icons.check,
        color: Colors.green,
      );
    } else if (i == 2) {
      return const Icon(
        Icons.warning,
        color: Colors.yellow,
      );
    } else {
      return const Icon(
        Icons.dangerous_rounded,
        color: Colors.red,
      );
    }
  }

  double totalMpiService = 0;

  final bold = const TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
  final small = const TextStyle(fontSize: 10);

  Widget _buildPartName(int i, BuildContext context, StockRalization stocks) {
    return StatefulBuilder(
      builder: (
        BuildContext context,
        StateSetter setState,
      ) =>
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 32,
                    child: Text(stocks.partname, style: small),
                  ),
                  Expanded(
                    flex: 32,
                    child: Text(stocks.name, style: small),
                  ),
                
                  Expanded(
                    flex: 30,
                    child: Text(formatCurrendcy.format(stocks.price),
                        style: small),
                  ),
                  Expanded(
                    flex: 15,
                    child: Text(
                      textAlign: TextAlign.center,
                      stocks.count.toString(),
                      style: small,
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Text(
                      textAlign: TextAlign.right,
                      formatCurrendcy.format(stocks.toalPrice),
                      style: small,
                    ),
                  ),
                ],
              )),
    );
  }

  @override
  void initState() {
    for (var element in widget.customer.mpi.target!.items) {
      totalMpiService = totalMpiService + element.price;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
          ),
          child: FloatingActionButton(
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
                  Customer asu = widget.customer;
                  asu.inv.target = Invoice(
                      invId: widget.customer.inv.target!.invId,
                      invoiceTotal: widget.customer.inv.target!.invoiceTotal,
                      partTotal: widget.customer.inv.target!.partTotal,
                      serviceTotal: widget.customer.inv.target!.serviceTotal,
                      soDate: widget.customer.inv.target!.soDate,
                      invoiceDate: widget.customer.inv.target!.invoiceDate);

                  asu.proses = 'Invoice';
                  // asu.rcp.target!.payments.add(Payment(date: widget.customer.dateTime,keterangan: 'Grand Total',saldo: widget.customer.realization.target!.biyaya,pay: 0))
                  Provider.of<Trigger>(context, listen: false)
                      .selectCustomer(asu, true);
                  objectBox.insertCustomer(asu);
                })),
        Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.red.shade400,
                child: const Icon(Icons.picture_as_pdf),
                onPressed: () async {
                  Customer asu = widget.customer;
                  asu.inv.target = Invoice(
                      invoiceTotal: widget.customer.inv.target!.invoiceTotal,
                      partTotal: widget.customer.inv.target!.partTotal,
                      serviceTotal: widget.customer.inv.target!.serviceTotal,
                      invId: widget.customer.inv.target!.invId,
                      soDate: widget.customer.inv.target!.soDate,
                      invoiceDate: widget.customer.inv.target!.invoiceDate);

                  asu.proses = 'Invoice';
                  Provider.of<Trigger>(context, listen: false)
                      .selectCustomer(asu, true);
                  objectBox.insertCustomer(asu);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Loading.....')));
                  final bytes = await _widgetsToImageController.capture();
                  await createSpk(bytes!, widget.customer.inv.target!.invId,
                      context, 'Invoice');
                  Provider.of<Trigger>(context, listen: false)
                      .selectCustomer(widget.customer, true);
                })),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.green,
              child: const Icon(Icons.print),
              onPressed: () async {
                final bytes = await _widgetsToImageController.capture();
                printPdf(bytes!);
              }),
        )
      ]),
      body: Hero(
        tag: 4,
        child:  InteractiveViewer(
          child: Center(
            child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
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
                          width: MediaQuery.of(context).size.height / 1.4142,
                          padding: const EdgeInsets.all(20),
                         
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
                            controller: _widgetsToImageController,
                            child: Container(
                              alignment: Alignment.center,
                              //  padding: const EdgeInsets.all(20),
        
                              width: constraints.maxHeight / 1.4,
                              height: constraints.maxHeight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Kop(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.customer.inv.target!.invId,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                        children: [
                                          Expanded(
                                            child: Kotak2(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
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
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      textAlign: TextAlign.right,
                                                      widget.customer.customerName,
                                                      style: bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      widget.customer.alamat,
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
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
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
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                child: Text(
                                                                  'Kendaraan:',
                                                                  style: small,
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3),
                                                              child: Text(
                                                                'Nomor Rangka:',
                                                                style: small,
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                child: Text(
                                                                  'Tipe:',
                                                                  style: small,
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3),
                                                              child: Text(
                                                                'Tanggal Invoice: ',
                                                                style: small,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3),
                                                              child: Text(
                                                                'Tanggal Garansi: ',
                                                                style: small,
                                                              ),
                                                            ),
                                                          ]),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40,
                                                                    top: 3,
                                                                    bottom: 3),
                                                            child: Text(
                                                              '${widget.customer.spk.target!.namaKendaraan} ',
                                                              style: small,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40,
                                                                    top: 3,
                                                                    bottom: 3),
                                                            child: Text(
                                                              widget.customer.spk
                                                                  .target!.noRangka,
                                                              style: small,
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 40,
                                                                      top: 3,
                                                                      bottom: 3),
                                                              child: Text(
                                                                widget.customer.spk.target!.tipeKendaraan,
                                                                style: small,
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40,
                                                                    top: 3,
                                                                    bottom: 3),
                                                            child: WebDatePicker(
                                                                dateformat:
                                                                    'dd/MM/yyy',
                                                                initialDate: DateTime
                                                                    .parse(widget
                                                                        .customer
                                                                        .inv
                                                                        .target!
                                                                        .invoiceDate),
                                                                small: true,
                                                                onChange: (v) {
                                                                  if (v == null) {
                                                                    return;
                                                                  }
                                                                  widget
                                                                          .customer
                                                                          .inv
                                                                          .target!
                                                                          .invoiceDate =
                                                                      v.toIso8601String();
                                                                }),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40,
                                                                    top: 3,
                                                                    bottom: 3),
                                                            child: WebDatePicker(
                                                                dateformat:
                                                                    'dd/MM/yyy',
                                                                initialDate: DateTime
                                                                    .parse(widget
                                                                        .customer
                                                                        .inv
                                                                        .target!
                                                                        .soDate),
                                                                small: true,
                                                                onChange: (v) {
                                                                  if (v == null) {
                                                                    return;
                                                                  }
                                                                  widget
                                                                          .customer
                                                                          .inv
                                                                          .target!
                                                                          .soDate =
                                                                      v.toIso8601String();
                                                                }),
                                                          )
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
                               
                               
                                Flexible(flex: 3,
                                  child: Column(children: [
                                        const Divider(
                                          height: 0,
                                          color: Colors.black,
                                        ),
                                        top2,
                                        const Divider(
                                          height: 0,
                                          color: Colors.black,
                                        ),
                                        ...widget.customer.mpi.target!.items
                                            .mapIndexed((i, element) => element
                                                        .attention ==
                                                    0
                                                ? const Center()
                                                : SizedBox(
                                                    width:
                                                        constraints.maxHeight / 1.4,
                                                    child: IntrinsicHeight(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Transform.scale(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              scale: 0.5,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                      child: buildAttention(
                                                                          element
                                                                              .attention))
                                                                ],
                                                              )),
                                                          Expanded(
                                                            flex: 6,
                                                            child: Text(
                                                              element.name,
                                                              maxLines: 2,
                                                              textAlign:
                                                                  TextAlign.left,
                                                              style: small,
                                                            ),
                                                          ),
                                                          Expanded(
                                                              flex: 5,
                                                              child: Text(
                                                                formatCurrendcy
                                                                    .format(element
                                                                        .price),
                                                                style: small,
                                                              )),
                                                          Expanded(
                                                              flex: 5,
                                                              child: Text(
                                                                textAlign:
                                                                    TextAlign.right,
                                                                element.remark,
                                                                style: small,
                                                              ))
                                                        ],
                                                      ),
                                                    )))
                                            .toList(),
                                        const Divider(
                                          height: 0,
                                          color: Colors.black,
                                        ),
                                         Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            top,
                                            const Divider(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            ...List.generate(
                                                widget.customer.realization.target!
                                                    .stockItems.length,
                                                (index) => _buildPartName(
                                                    index,
                                                    context,
                                                    widget
                                                        .customer
                                                        .realization
                                                        .target!
                                                        .stockItems[index])),  const Divider(
                                        
                                          color: Colors.black,
                                        ),
                                           
                                          ],
                                        ),
                                      ),
                                                             
                                  Column(
                                      children: [
                                        top3, 
                                         const Divider(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                      ],
                                    ),
                                      ]),
                                ),
                                  
                                  
         Container(
                                      margin: const EdgeInsets.only(bottom: 30),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, right: 40),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'Service Total',
                                                      style: bold,
                                                    ),
                                                    Text(
                                                      'Part Total',
                                                      style: bold,
                                                    ),
                                                    Text(
                                                      'Sub Total',
                                                      style: bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    formatCurrendcy.format(widget
                                                        .customer
                                                        .inv
                                                        .target!
                                                        .serviceTotal),
                                                    style: bold,
                                                  ),
                                                  Text(
                                                      formatCurrendcy.format(
                                                        widget.customer.inv.target!
                                                            .partTotal,
                                                      ),
                                                      style: bold),
                                                  Text(
                                                    formatCurrendcy.format(widget
                                                            .customer
                                                            .inv
                                                            .target!
                                                            .partTotal +
                                                        widget.customer.inv.target!
                                                            .serviceTotal),
                                                    style: bold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  
                                ],
                              ),
                            ),
                          ),
                        )
                      ]));
            }),
          ),
        ),
      ),
    );
  }

  Widget top2 = Container(
    margin: const EdgeInsets.only(top: 5),
    child: Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            child: const Text(
              textAlign: TextAlign.left,
              "Inspection",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ),
        const Expanded(
          flex: 4,
          child: Text(
            "Service",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        const Expanded(
          flex: 5,
          child: Text(
            textAlign: TextAlign.right,
            "Catatan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        )
      ],
    ),
  );
  
  Widget top= Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              flex: 8,
              child: Text(
                "Partname",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            Expanded(
              flex: 8,
              child: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          
            Expanded(
              flex: 8,
              child: Text(
                "Harga",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            Expanded(
              flex: 8,
              child: Text(
                "Jumlah",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            Text(
              "Total",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ],
        ),
      );
      Widget top3 = Container(margin: EdgeInsets.only(top: 10),
        child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
        Expanded(
          flex: 3,
          child: Container(
           
            child: const Text(
              "Repair Partname",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: const Text(
              "Harga Repair",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: const Text(
              "Harga Service",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: const Text(
              textAlign: TextAlign.center,
              "Remark",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ),
    ],
  ),
      );
}
