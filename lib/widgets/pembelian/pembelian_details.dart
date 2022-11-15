import 'package:newJoyo/models/detail_pembelian.dart';
import 'package:newJoyo/provider/trigger.dart';

// ignore: deprecated_member_use
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newJoyo/widgets/pembelian/pembelian_edit.dart';
import 'package:provider/provider.dart';

class SupplierDetails extends StatefulWidget {
  // final List<dynamic> SuppliersHistory;
  // final bool empty;
  const SupplierDetails({Key? key}) : super(key: key);

  @override
  State<SupplierDetails> createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  Widget build(BuildContext context) {
    return Consumer<Trigger>(builder: (context, value, cshild) {
      final List<DetailPembelian> history =
          value.selectedSupplier.items.reversed.toList();

      return IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.selectedSupplier.supplier,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              SupplierEdit( value.selectedSupplier)
              ],
            ),
            Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 40, top: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(value.selectedSupplier.desc)),
            Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2.7,
              child: DataTable2(
                  headingRowHeight: 30,
                  border: TableBorder.all(
                      width: 2,
                      color: Colors.black,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  sortArrowIcon: Icons.arrow_upward,
                  columnSpacing: 12,
                  dividerThickness: 2,
                  horizontalMargin: 12,
                  columns: const [
                    DataColumn(
                      label: Center(child: Text('PartName')),
                    ),
                    DataColumn(
                      label: Center(child: Text('Harga Peritem')),
                    ),
                    DataColumn2(
                        label: Center(
                            child: Text(
                          'Jumlah',
                        )),
                        size: ColumnSize.S),
                    DataColumn(
                      label: Center(child: Text('Total')),
                    ),
                  ],
                  rows: history.map((e) {
                    return DataRow2(
                        color: MaterialStateProperty.all(
                            history.indexOf(e).isEven
                                ? Colors.amber.shade200
                                : Colors.white),
                        cells: [
                          DataCell(Center(child: Text(e.partName))),
                          DataCell(Center(
                              child: Text(formatCurrency.format(e.price)))),
                          DataCell(Center(
                              child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 2, bottom: 2),
                            // decoration: BoxDecoration(
                            //     color:
                            //          Colors.green.shade400,
                            //     borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              (e.count.toString()),
                              // style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                          DataCell(Center(
                              child:
                                  Text(formatCurrency.format(e.totalPrice)))),
                        ]);
                  }).toList()),
            ))
          ]),
        ),
      );
    });
  }
}
