import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/detail_stock.dart';
import 'package:newJoyo/models/pembelian.dart';
import 'package:newJoyo/models/detail_pembelian.dart';
import 'package:newJoyo/helper/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper/currency.dart';
import '../../models/stock.dart';
import '../../provider/trigger.dart';

class SupplierEdit extends StatefulWidget {
  final Supplier supplier;
  const SupplierEdit(this.supplier);

  @override
  State<SupplierEdit> createState() => _SupplierEditState();
}

class _SupplierEditState extends State<SupplierEdit> {
  String _desc = '';
  String _supplier = '';

  final TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Stock> _updatedStock = [
    Stock(
        partname: 'partname',
        name: ' name',
        desc: ' desc',
        count: 0,
        totalPrice: 0)
  ];
  List<DetailStock> _updatedDetailStock = [
    DetailStock(supplier: '', date: '', price: 0, count: 1, totalPrice: 0)
  ];
  @override
  void didChangeDependencies() {
    jumlahOpsi = jumlahOpsi + widget.supplier.detailStockItems.length;
    _controller.text = widget.supplier.supplier;

    _updatedDetailStock.addAll(widget.supplier.detailStockItems);
    _updatedStock.addAll(widget.supplier.stockItems);
    super.didChangeDependencies();
  }

  Widget _buildPartName(int i, BuildContext context) {
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    TextEditingController dpdController = TextEditingController();
    dpdController.text = _updatedStock[i].partname;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: DropDownField(
              controller: dpdController,
              inputFormatters: const [],
              required: true,
              onValueChanged: (val) {
                if (stocks.map((e) => e.partname).toList().contains(val)) {
                 if (_updatedStock.isNotEmpty) {
                  _updatedStock[i].partname =
                      val;
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
              initialValue: _updatedDetailStock[i].price.toString(),
              onChanged: (value) {
                if (_updatedStock.isNotEmpty) {
                  _updatedDetailStock[i].price =
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
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
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Supplier> suppliers =
        Provider.of<Trigger>(context, listen: false).listSelectedSupplier;
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    List<String> itemsSupplier = [];
    if (suppliers.isNotEmpty) {
      for (Supplier e in suppliers) {
        if (!itemsSupplier.contains(e.supplier)) {
          itemsSupplier.add(e.supplier);
        }
      }
    } else {
      itemsSupplier.add(_supplier);
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
                            title: const Text("Inventory"),
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
                                      DropDownField(
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
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: TextFormField(
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
                                                    _updatedStock.add(Stock(
                                                        partname: 'partname',
                                                        name: ' name',
                                                        desc: ' desc',
                                                        count: 0,
                                                        totalPrice: 0));
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

                                  widget.supplier.date =
                                      DateTime.now().toIso8601String();
                                  widget.supplier.desc = _desc;
                                  widget.supplier.supplier = _supplier;
                                  widget.supplier.items.clear();
                                  widget.supplier.count = 0;
                                  widget.supplier.totalPrice = 0;
                                  widget.supplier.stockItems.clear();
                                  widget.supplier.detailStockItems.clear();
                                  widget.supplier.stockItems
                                      .addAll(_updatedStock);
                                  widget.supplier.detailStockItems
                                      .addAll(_updatedDetailStock);
                                  if (_supplier != '' &&
                                      _updatedStock.isNotEmpty) {
                                    //SUPPLEIER HISTORY
                                    for (var i = 0;
                                        i < _updatedStock.length;
                                        i++) {
                                      widget.supplier.items.add(DetailPembelian(
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
                                          supplier: _supplier,
                                          date:
                                              DateTime.now().toIso8601String(),
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

                                      ///ADD SUPPLIER
                                      widget.supplier.count =
                                          widget.supplier.count +
                                              _updatedDetailStock[i].count;

                                      widget.supplier.totalPrice =
                                          widget.supplier.totalPrice +
                                              _updatedDetailStock[i].price *
                                                  _updatedDetailStock[i].count;

                                      objectBox.insertStock(_updatedStock[i]);
                                    }
                                    objectBox.insertSupplier(widget.supplier);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Enter"),
                              ),
                            ]);
                      }).then((value) {
                    // _desc = '';
                    // jumlahOpsi = 1;
                    // _updatedStock = [];
                    // _supplier = '';
                    // _updatedDetailStock = [
                    //   DetailStock(
                    //       supplier: '',
                    //       date: '',
                    //       price: 0,
                    //       count: 1,
                    //       totalPrice: 0)
                    // ];
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
