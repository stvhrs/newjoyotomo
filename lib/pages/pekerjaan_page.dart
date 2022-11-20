// ignore_for_file: deprecated_member_use

import 'package:intl/intl.dart';
import 'package:newJoyo/helper/styling.dart';
import 'package:newJoyo/models/customer.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:newJoyo/widgets/customer/customer_add.dart';
import 'package:newJoyo/widgets/customer/customer_detail.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:collection/collection.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late Stream<List<Customer>> _streamcustomers;
  final int _currentIndex = 0;
  late Customer _selectedCustomers;
  String _search = '';

  @override
  void initState() {
    _streamcustomers = objectBox.getCustomers();
    var data = objectBox.fetchPelanggan();
    Provider.of<Trigger>(context, listen: false)
        .selectListPelanggan(data, false);
    super.initState();
  }

  Route _createRoute(Customer c) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CustomerDetails(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  getColorProses(String p) {
    if (p == 'SPK') {
      return Colors.orange;
    }
    if (p == 'MPI') {
      return Colors.grey;
    }
    if (p == 'Invoice') {
      return Colors.green;
    }
    if (p == 'Realisasi') {
      return Colors.blue;
    }
    if (p == 'Pembayaran') {
      return Colors.green.shade700;
    }
  }

  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
          return StreamBuilder<List<Customer>>(
              stream: _streamcustomers,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: CustomerAdd(
                    csId: 1,
                  ));
                } else {
                  List<Customer> customers = [];
                  if (_search != '') {
                    for (Customer element in snapshot.data!) {
                      if (element.customerName
                              .toLowerCase()
                              .startsWith(_search.toLowerCase()) ||
                          element.namaKendaraan
                              .toLowerCase()
                              .startsWith(_search.toLowerCase())) {
                        customers.add(element);
                      }
                    }
                  } else {
                    customers = snapshot.data!.reversed.toList();
                    _selectedCustomers = customers[_currentIndex];
                    Provider.of<Trigger>(context, listen: false)
                        .selectCustomer(_selectedCustomers, false);
                    Provider.of<Trigger>(context, listen: false)
                        .selectListCustomer(customers, false);
                  }

                  return Consumer<Trigger>(builder: (context, val, c) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                spreadRadius: 3,
                                offset: Offset(2, 2),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 15, right: 15),
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 10, bottom: 10),
                                      height: 50,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 0),
                                              child: TextFormField(
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        if (customers
                                                            .isNotEmpty) {
                                                          _selectedCustomers =
                                                              customers[0];
                                                        }
                                                        // _streamcustomers =
                                                        //     objectBox.getcustomers(
                                                        //         val.toString());
                                                        _search =
                                                            val.toString();
                                                        // }
                                                      },
                                                    );
                                                  },
                                                  decoration: input))),
                                    ),
                                    CustomerAdd(csId: customers.length + 1),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(flex: 11, child: Text('Faktur')),
                                    Expanded(flex: 11, child: Text('Nama')),
                                    Expanded(
                                        flex: 11, child: Text('Kendaraan')),
                                    Expanded(flex: 11, child: Text('Proses')),
                                    Expanded(flex: 9, child: Text('Tagihan')),
                                    Expanded(flex: 9, child: Text('Saldo')),
                                    Expanded(flex: 5, child: Text('Lunas')),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: SizedBox(
                                      child: ListView(
                                children: customers.mapIndexed((i, e) {
                                  Customer _selectedCustomers =
                                      Provider.of<Trigger>(context,
                                              listen: true)
                                          .selectedCustomer;
                                  return InkWell(
                                    onDoubleTap: () {},
                                    onTap: () {
                                      Provider.of<Trigger>(context,
                                              listen: false)
                                          .selectCustomer(e, false);
                                      Navigator.of(context)
                                          .push(_createRoute(e));
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: i.isEven
                                              ? const Color.fromARGB(
                                                  255, 193, 216, 226)
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 11, child: Text(e.csId)),
                                            Expanded(
                                                flex: 11,
                                                child: Text(e.customerName)),
                                            Expanded(
                                                flex: 11,
                                                child: Text(e.spk.target!
                                                    .namaKendaraan)),
                                            Expanded(
                                                flex: 11,
                                                child: Container(padding: const EdgeInsets.all(3),
                                                    margin: const EdgeInsets.only(
                                                        right: 90),
                                                    decoration: BoxDecoration(
                                                        color: getColorProses(
                                                            e.proses),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      e.proses,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ))),
                                            Expanded(
                                                flex: 9,
                                                child: Text(
                                                  e.rcp.target!.payments.first
                                                              .saldo ==
                                                          1
                                                      ? '_____'
                                                      : formatCurrency.format(e
                                                          .realization.target!.biyaya),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Expanded(
                                                flex: 9,
                                                child: Text(
                                                  e.rcp.target!.payments.last
                                                              .saldo ==
                                                          1
                                                      ? '_____'
                                                      : formatCurrency.format(e
                                                          .rcp
                                                          .target!
                                                          .payments
                                                          .last
                                                          .saldo),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: IntrinsicWidth(
                                                  child: Container(padding: const EdgeInsets.all(3),
                                                    margin: const EdgeInsets.only(
                                                        right: 30),
                                                    decoration: BoxDecoration(
                                                        color: e
                                                                    .rcp
                                                                    .target!
                                                                    .payments
                                                                    .last
                                                                    .saldo ==
                                                                0
                                                            ? Colors
                                                                .green.shade400
                                                            : Colors
                                                                .red.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      e.rcp.target!.payments
                                                                  .last.saldo ==
                                                              0
                                                          ? 'Lunas'
                                                          : 'Belum',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )),
                                  );
                                }).toList(),
                              )))
                            ]),
                        // _divier_,
                        // const CustomerDetails(),
                      ),
                    );
                  });
                }
              });
        }),
      ),
    );
  }
}

Widget get _divier_ => Row(
      children: const [
        VerticalDivider(
          color: Color.fromARGB(255, 79, 117, 134),
          thickness: 2.5,
          width: 4,
        ),
        VerticalDivider(
          color: Color.fromARGB(255, 79, 117, 134),
          thickness: 2.5,
          width: 4,
        ),
      ],
    );
