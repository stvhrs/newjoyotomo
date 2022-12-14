import 'dart:developer';

import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/detail_stock.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:newJoyo/widgets/stock/stock_edit.dart';
import 'package:newJoyo/widgets/stock/stock_remove.dart';
// ignore: deprecated_member_use
import 'package:data_table_2/paginated_data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog.dart';
import '../../models/stock.dart';

class StockDetails extends StatefulWidget {
  // final List<dynamic> stocksHistory;
  // final bool empty;
  const StockDetails({Key? key}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  Widget build(BuildContext context) {
    return Consumer<Trigger>(builder: (context, value, cshild) {
      final List<DetailStock> history =
          value.selectedStock.items.reversed.toList();

      log(history.toString());
      return IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.selectedStock.partname,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
               StockEdit(value.selectedStock),
                IconButton(
                    onPressed: () {    Stock stock = Provider.of<Trigger>(context, listen: false)
                          .selectedStock;
                         showDialog(
                                    context: context,
                                    builder: (context) {
                                      return dialog(
                                          onClickAction: () {
                                         
                      objectBox.deleteStock(stock.id);
                                          },
                                          string:
                                              'Stock ${stock.partname} Akan Dihapus Selamanya',
                                          context: context);
                                    },
                                  )
                    ;
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade900,
                    )),
              ],
            ),
            Text(
              value.selectedStock.name,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            Container(
          
              width: MediaQuery.of(context).size.width / 2.35,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 40, top: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(value.selectedStock.desc)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Riwayat Stock',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ),
                (value.selectedStock.count > 0)
                    ? const IntrinsicWidth(child: StockRemove())
                    : const SizedBox(),
              ],
            ),
            Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2.31,
              child: DataTable2(
                  headingRowHeight: 50,
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
                      label: Center(child: Text('Transaksi')),
                    ),
                    DataColumn(
                      label: Center(child: Text('Tanggal')),
                    ),
                    DataColumn(
                      label: Center(child: Text('Pihak')),
                    ),
                    DataColumn(
                      label: Center(child: Text(textAlign: TextAlign.center,'Harga\nBeli')),
                    ),
                     DataColumn(
                      label: Center(child: Text(textAlign: TextAlign.center,'Harga\nJual')),
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
                  rows: value.selectedStock.items.isEmpty
                      ? []
                      : history.map((e) {
                          return DataRow2(
                              color: MaterialStateProperty.all(
                                  history.indexOf(e).isEven
                                      ? Colors.amber.shade200
                                      : Colors.white),
                              cells: [
                                DataCell(Text(
                                  e.pihakId.contains('SUP')?'Pembelian': 'Pemakaian',
                                  style: TextStyle(
                                      color:    e.pihakId.contains('SUP')?Colors.green: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )),
                                DataCell(
                                  Center(
                                    child: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(e.date)),
                                        style: const TextStyle(fontSize: 11)),
                                  ),
                                ),
                                DataCell(Center(
                                  child: Text(
                                    e.supplier,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(formatCurrency.format(e.buyPrice),
                                      style: const TextStyle(fontSize: 11)),
                                )),
                                DataCell(Center(
                                  child: Text(formatCurrency.format(e.sellPrice),
                                      style: const TextStyle(fontSize: 11)),
                                )),
                                DataCell(Center(
                                    child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                      // color: e.count < 0
                                      //     ? Colors.red.shade400
                                      //     : Colors.green.shade400,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    (e.count.toString()),
                                    style: const TextStyle(fontSize: 11),
                                    // style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ))),
                                DataCell(Center(
                                    child: Text(
                                        formatCurrency.format(e.totalPrice),
                                        style: TextStyle(fontSize: 11,color: e.pihakId.contains('SUP')?Colors.green: Colors.red, fontWeight: FontWeight.bold)))),
                              ]);
                        }).toList()),
            )),
          ]),
        ),
      );
    });
  }
}
