import 'package:newJoyo/library/date_picker/src/web_date_picker.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/detail_stock.dart';
import 'package:newJoyo/models/pembelian.dart';
import 'package:newJoyo/models/detail_pembelian.dart';
import 'package:newJoyo/helper/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:newJoyo/models/supplier.dart';
import 'package:provider/provider.dart';

import '../../helper/currency.dart';
import '../../models/stock.dart';
import '../../provider/trigger.dart';

class SupplierAdd extends StatefulWidget {
  const SupplierAdd({super.key});

  @override
  State<SupplierAdd> createState() => _SupplierAddState();
}

class _SupplierAddState extends State<SupplierAdd> {
  String _desc = '';
  String _supplier = '';
  late DateTime _date;
  final TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Stock> _updatedStock = [];
  List<DetailStock> _updatedDetailStock = [
    DetailStock(supplier: '', date: '', price: 0, count: 1, totalPrice: 0)
  ];
  List<String> itemsSupplier = [];
  Widget _buildPartName(int i, BuildContext context) {
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: DropDownField(
                        inputFormatters: const [],
                        required: true,
                        onValueChanged: (val) {
                          if (stocks
                              .map((e) => e.partname)
                              .toList()
                              .contains(val)) {
                            if (_updatedStock.length < i + 1) {
                              _updatedStock.insert(
                                  i,
                                  stocks.firstWhere(
                                      (element) => element.partname == val));
                            }

                            setState(() {});
                          }
                        },
                        strict: true,
                        labelText: 'PartName',
                        items: stocks.map((e) => e.partname).toList(),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'Harga'),
                        onChanged: (value) {
                          if (_updatedStock.isNotEmpty) {
                            _updatedDetailStock[i].price =
                                NumberFormat.currency(
                                        locale: 'id_ID', symbol: 'Rp ')
                                    .parse(value)
                                    .toDouble();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {});
                          if (_updatedDetailStock[i].count > 1) {
                            setState(() {
                              _updatedDetailStock[i].count--;
                              // _updatedStock[i].count--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle)),
                    Text(_updatedDetailStock[i].count.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _updatedDetailStock[i].count++;
                            // _updatedStock[i].count++;
                          });
                        },
                        icon: const Icon(Icons.add_circle)),
                  ],
                )));
  }

  @override
  Widget build(BuildContext context) {
    List<Supplier> suppliers =
        Provider.of<Trigger>(context, listen: false).listSelectedSupplier;
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    List<Penyuplai> penyuplais =
        Provider.of<Trigger>(context, listen: false).listSelectedPenyuplai;

    if (penyuplais.isNotEmpty) {
      for (Penyuplai e in penyuplais) {
        if (!itemsSupplier.contains(e.namaPenyuplai)) {
          itemsSupplier.add(e.namaPenyuplai);
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 79, 117, 134))),
          onPressed: stocks.isEmpty
              ? () {}
              : () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            actionsPadding:
                                const EdgeInsets.only(right: 15, bottom: 15),
                            title: const Text("Tambah Pembelian"),
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  IntrinsicHeight(
                                child: SizedBox(
                                  width: 500,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: DropDownField(
                                                required: true,
                                                inputFormatters: const [],
                                                strict: true,
                                                controller: _controller,
                                                labelText: 'Supplier',
                                                onValueChanged: (v) {
                                                  _supplier = v;
                                                },
                                                items: itemsSupplier,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child:
                                                  WebDatePicker(onChange: (v) {
                                                if (v != null) {
                                                  _date = v;
                                                }
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Deskripsi'),
                                          onChanged: (val) {
                                            _desc = val;
                                          },
                                          maxLines: 3,
                                        ),
                                      ),
                                      ...List.generate(
                                          jumlahOpsi,
                                          (index) =>
                                              _buildPartName(index, context)),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (jumlahOpsi > 1 &&
                                                      jumlahOpsi ==
                                                          _updatedStock
                                                              .length) {
                                                    _updatedStock.removeAt(
                                                        jumlahOpsi - 1);
                                                    _updatedDetailStock
                                                        .removeAt(
                                                            jumlahOpsi - 1);
                                                    jumlahOpsi = jumlahOpsi - 1;
                                                  }
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.remove_circle)),
                                          // Text(jumlahOpsi.toString()),
                                          IconButton(
                                              onPressed: () {
                                                if (jumlahOpsi ==
                                                    _updatedStock.length) {
                                                  setState(() {
                                                    jumlahOpsi = jumlahOpsi + 1;
                                                    _updatedDetailStock.add(
                                                        DetailStock(
                                                            supplier: '',
                                                            date: '',
                                                            price: 0,
                                                            count: 1,
                                                            totalPrice: 0));
                                                  });
                                                }
                                              },
                                              icon:
                                                  const Icon(Icons.add_circle)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  if (_updatedDetailStock
                                      .any((element) => element.price < 1)) {
                                    return;
                                  }
                                  _supplier = _controller.text;
                                  int itemsCount = 0;
                                  double itemsTotalPrice = 0;
                                  Supplier tempSupplier = Supplier(
                                      pihakId: 'SUP/JT/000000'.replaceRange(
                                          13 -
                                              int.parse(((suppliers.length + 1)
                                                      .toString())
                                                  .length
                                                  .toString()),
                                          13,
                                          (suppliers.length + 1).toString()),
                                      date: _date.toIso8601String(),
                                      supplier: _supplier,
                                      desc: _desc,
                                      count: itemsCount,
                                      totalPrice: itemsTotalPrice);
                                  tempSupplier.stockItems.addAll(_updatedStock);
                                  tempSupplier.detailStockItems
                                      .addAll(_updatedDetailStock);

                                  if (_supplier != '' &&
                                      _updatedStock.isNotEmpty) {
                                    //SUPPLEIER HISTORY
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      tempSupplier.items.add(DetailPembelian(
                                          name: _updatedStock[i].name,
                                          partName: _updatedStock[i].partname,
                                          count: _updatedDetailStock[i].count,
                                          price: _updatedDetailStock[i].price,
                                          totalPrice: _updatedDetailStock[i]
                                                  .price *
                                              _updatedDetailStock[i].count));
                                    }

                                    /// UPDATE STOCK HISTORY
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      DetailStock history = DetailStock(
                                          pihakId: 'SUP/JT/000000'.replaceRange(
                                              13 -
                                                  int.parse(
                                                      ((suppliers.length + 1)
                                                              .toString())
                                                          .length
                                                          .toString()),
                                              13,
                                              (suppliers.length + 1)
                                                  .toString()),
                                          supplier: _supplier,
                                          date: _date.toIso8601String(),
                                          price: _updatedDetailStock[i].price,
                                          count: _updatedDetailStock[i].count,
                                          totalPrice:
                                              _updatedDetailStock[i].price *
                                                  _updatedDetailStock[i].count);
                                      //UPDATE STOCK
                                      _updatedStock[i].items.add(history);

                                      _updatedStock[i].totalPrice =
                                          _updatedStock[i].totalPrice +
                                              (_updatedDetailStock[i].price *
                                                  _updatedDetailStock[i].count);

                                      _updatedStock[i].count =
                                          _updatedStock[i].count +
                                              _updatedDetailStock[i].count;
                                      _updatedStock[i].date =
                                          DateTime.now().microsecondsSinceEpoch;

                                      ///ADD SUPPLIER
                                      tempSupplier.count = tempSupplier.count +
                                          _updatedDetailStock[i].count;

                                      tempSupplier.totalPrice =
                                          tempSupplier.totalPrice +
                                              _updatedDetailStock[i].price *
                                                  _updatedDetailStock[i].count;

                                      objectBox.insertStock(_updatedStock[i]);
                                    }

                                    objectBox.insertSupplier(tempSupplier);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Enter"),
                              ),
                            ]);
                      }).then((value) {
                    _desc = '';
                    jumlahOpsi = 1;
                    _updatedStock = [];
                    _supplier = '';
                    _updatedDetailStock = [
                      DetailStock(
                          supplier: '',
                          date: '',
                          price: 0,
                          count: 1,
                          totalPrice: 0)
                    ];
                  });
                },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Tambah Pembelian',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
