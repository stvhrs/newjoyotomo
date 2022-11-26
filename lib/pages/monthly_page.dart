import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/customer.dart';

class MonthlyPagae extends StatefulWidget {
  const MonthlyPagae({super.key});

  @override
  State<MonthlyPagae> createState() => _MonthlyPagaeState();
}

class _MonthlyPagaeState extends State<MonthlyPagae> {
  List<Customer> _elements = [];
  List months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  void initState() {
    _elements = objectBox.fetchCustomer();

    _elements.removeWhere((element) =>
        element.realization.target!.dateOut == 'DD/MM/YYYY' ||
        element.spk.target!.date == 'DD/MM/YYYY');
        _elements.sort((a, b) => b.realization.target!.dateOut.compareTo(a.realization.target!.dateOut),);

    super.initState();
  }

  repairType(int i) {
    if (i == 1) {
      return 'Ringan';
    }
    if (i == 2) {
      return 'Sedang';
    }
    if (i == 3) {
      return 'Berat';
    }
  }

  getColorProses(int i) {
    if (i == 1) {
      return Colors.green;
    }
    if (i == 2) {
      return Colors.amber ;
    }
    if (i == 3) {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> filterDuplicate = [];
    late Map<String, List<Customer>> data = {};

    _elements
        .map((e) =>
            months[DateTime.parse(e.realization.target!.dateOut).month - 1] +DateTime.parse(e.realization.target!.dateOut).year.toString())
        .toList()
        .forEach((element) {
      if (filterDuplicate.contains(element)) {
      } else {
        filterDuplicate.add(element);
      }
    });
    // filterDuplicate.sort(
    //   (a, b) => months.indexOf(b).compareTo(months.indexOf(a)),
    // );
    for (var element in filterDuplicate) {
      data[element] = [];
      for (var cs in _elements) {
        if (months[DateTime.parse(cs.realization.target!.dateOut).month - 1]  +DateTime.parse(cs.realization.target!.dateOut).year.toString()==
            element) {
          data[element]!.add(cs);
        }
      }
    }

    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                spreadRadius: 3,
                offset: Offset(0, 2),
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                const Expanded(
                  child: Text(
                    'Laporan Bulanan Kendaraan Keluar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 13,
                  child: GroupListView(
                    sectionsCount: data.keys.length,
                    countOfItemInSection: (int section) {
                      return data.values.toList()[section].reversed.toList().length;
                    },
                    itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: index.index.isEven
                              ? const Color.fromARGB(255, 193, 216, 226)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Text((index.index + 1).toString())),
                            Expanded(
                                flex: 11,
                                child: Text(data.values
                                    .toList()[index.section][index.index]
                                    .spk
                                    .target!
                                    .jtId)),
                            Expanded(
                                flex: 11,
                                child: Text(data.values
                                    .toList()[index.section][index.index]
                                    .customerName)),
                            Expanded(
                                flex: 11,
                                child: IntrinsicWidth(
                                  child: Container(padding: const EdgeInsets.all(3),alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 80),
                                    decoration: BoxDecoration(
                                        color: getColorProses(data.values
                                            .toList()[index.section]
                                                [index.index]
                                            .spk
                                            .target!
                                            .levelPekerjaan),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      repairType(data.values
                                          .toList()[index.section][index.index]
                                          .spk
                                          .target!
                                          .levelPekerjaan),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 11,
                                child: Text(DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(data.values
                                        .toList()[index.section][index.index]
                                        .spk
                                        .target!
                                        .date)))),
                            Expanded(
                                flex: 11,
                                child: Text(DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(data.values
                                        .toList()[index.section][index.index]
                                        .realization
                                        .target!
                                        .dateOut)))),
                            Expanded(
                                flex: 9,
                                child: Text(
                                  data.values
                                              .toList()[index.section]
                                                  [index.index]
                                              .rcp
                                              .target!
                                              .payments
                                              .first
                                              .saldo ==
                                          1
                                      ? '_____'
                                      : formatCurrency.format(data.values
                                          .toList()[index.section][index.index]
                                          .rcp
                                          .target!
                                          .payments
                                          .first
                                          .saldo),
                                )),
                            Expanded(
                                flex: 9,
                                child: Text(textAlign: TextAlign.right,
                                  data.values
                                              .toList()[index.section]
                                                  [index.index]
                                              .rcp
                                              .target!
                                              .payments
                                              .last
                                              .saldo ==
                                          1
                                      ? '_____'
                                      : formatCurrency.format(data.values
                                          .toList()[index.section][index.index]
                                          .rcp
                                          .target!
                                          .payments
                                          .last
                                          .saldo),
                                )),
                          ],
                        )),
                    // _divier_,
                    // const CustomerDetails(),

                    groupHeaderBuilder: (BuildContext context, int section) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            months[DateTime.parse(data.values
                                            .toList()[section][0]
                                            .realization
                                            .target!
                                            .dateOut)
                                        .month -
                                    1] +
                                ' ' +
                                DateTime.parse(data.values
                                        .toList()[section][0]
                                        .realization
                                        .target!
                                        .dateOut)
                                    .year
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            color: Colors.grey.shade300,
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(flex: 5, child: Text('No')),
                                Expanded(flex: 11, child: Text('Faktur SPK')),
                                Expanded(flex: 11, child: Text('Nama')),
                                Expanded(flex: 11, child: Text('Repair Type')),
                                Expanded(flex: 11, child: Text('Date In')),
                                Expanded(flex: 11, child: Text('Date Out')),
                                Expanded(flex: 9, child: Text('Tagihan')),
                                Expanded(flex: 9, child: Text(textAlign: TextAlign.right,'Saldo')),
                              ],
                            ),
                          ),
                        ],
                      );
                    },

                    sectionSeparatorBuilder: (context, section) {
                      double totalAmount = 0;
                      double totalSalod = 0;
                      for (var element in data.values.toList()[section]) {
                        totalAmount =
                            totalAmount + (element.rcp.target!.payments.first.saldo==1?0:element.rcp.target!.payments.first.saldo);
                        totalSalod = totalSalod +
                            (element.rcp.target!.payments.last.saldo == 1
                                ? 0
                                : element.rcp.target!.payments.last.saldo);
                      }
                      return Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     blurRadius: 1,
                            //     spreadRadius: 1,
                            //     offset: Offset(3, 3),
                            //   ),
                            // ],
                            color: Colors.amber.shade200,
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(7),
                            //     bottomRight: Radius.circular(7)

                            //     )
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 60,
                                  child: Text(
                                    'Total ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                           
                              Expanded(
                                flex: 9,
                                child: Text(
                                  formatCurrency.format(totalAmount),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  flex: 9,
                                  child: Text(textAlign: TextAlign.right,
                                    formatCurrency
                                        .format(totalSalod)
                                    ,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ));
                    },
                  ),
                ),
              ],
            )));
  }
}
