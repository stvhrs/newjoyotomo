import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/stock_history.dart';
import 'package:newJoyo/models/supplier.dart';
import 'package:newJoyo/models/supplier_history.dart';
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
  
SupplierEdit(this.supplier);

  @override
  State<SupplierEdit> createState() => _SupplierEditState();
}

class _SupplierEditState extends State<SupplierEdit> {
  String _desc = '';
  String _supplier = '';

  final TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Stock> _updatedStock = [];
  List<StockHistory> _updatedStockHistory = [
    StockHistory(supplier: '', date: '', price: 0, count: 1, totalPrice: 0)
  ];

  Widget _buildPartName(int i, BuildContext context) {
    
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;

    return StatefulBuilder(
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
                  child: TextField(
                    onChanged: (value) {
                      if (_updatedStock.isNotEmpty) {
                        _updatedStockHistory[i].price = NumberFormat.currency(
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
                      if (_updatedStockHistory[i].count > 1) {
                        setState(() {
                          _updatedStockHistory[i].count--;
                          // _updatedStock[i].count--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle)),
                Text(_updatedStockHistory[i].count.toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _updatedStockHistory[i].count++;
                        // _updatedStock[i].count++;
                      });
                    },
                    icon: const Icon(Icons.add_circle)),
              ],
            ));
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
                        return
                        AlertDialog(
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
                                                      _updatedStockHistory
                                                          .removeAt(
                                                              jumlahOpsi - 1);
                                                      jumlahOpsi =
                                                          jumlahOpsi - 1;
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
                                                      jumlahOpsi =
                                                          jumlahOpsi + 1;
                                                      _updatedStockHistory.add(
                                                          StockHistory(
                                                              supplier: '',
                                                              date: '',
                                                              price: 0,
                                                              count: 1,
                                                              totalPrice: 0));
                                                    });
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.add_circle)),
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
                                    if (_updatedStockHistory
                                        .any((element) => element.price < 1)) {
                                      return;
                                    }
                                    _supplier = _controller.text;
                                    int itemsCount = 0;
                                    double itemsTotalPrice = 0;
                                    Supplier tempSupplier = Supplier(
                                        date: DateTime.now().toIso8601String(),
                                        supplier: _supplier,
                                        desc: _desc,
                                        count: itemsCount,
                                        totalPrice: itemsTotalPrice);

                                    if (_supplier != '' &&
                                        _updatedStock.isNotEmpty) {
                                      //SUPPLEIER HISTORY
                                      for (var i = 0;
                                          i < _updatedStock.length;
                                          i++) {
                                        tempSupplier.items.add(SupplierHistory(
                                            name: _updatedStock[i].name,
                                            partName: _updatedStock[i].partname,
                                            count:
                                                _updatedStockHistory[i].count,
                                            price:
                                                _updatedStockHistory[i].price,
                                            totalPrice: _updatedStockHistory[i]
                                                    .price *
                                                _updatedStockHistory[i].count));
                                      }

                                      /// UPDATE STOCK HISTORY
                                      for (var i = 0;
                                          i < _updatedStock.length;
                                          i++) {
                                        StockHistory history = StockHistory(
                                            supplier: _supplier,
                                            date: DateTime.now()
                                                .toIso8601String(),
                                            price:
                                                _updatedStockHistory[i].price,
                                            count:
                                                _updatedStockHistory[i].count,
                                            totalPrice: _updatedStockHistory[i]
                                                    .price *
                                                _updatedStockHistory[i].count);
                                        //UPDATE STOCK
                                        _updatedStock[i].items.add(history);

                                        _updatedStock[i].totalPrice =
                                            _updatedStock[i].totalPrice +
                                                (_updatedStockHistory[i].price *
                                                    _updatedStockHistory[i]
                                                        .count);

                                        _updatedStock[i].count =
                                            _updatedStock[i].count +
                                                _updatedStockHistory[i].count;

                                        ///ADD SUPPLIER
                                        tempSupplier.count =
                                            tempSupplier.count +
                                                _updatedStockHistory[i].count;

                                        tempSupplier.totalPrice = tempSupplier
                                                .totalPrice +
                                            _updatedStockHistory[i].price *
                                                _updatedStockHistory[i].count;

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
                    _updatedStockHistory = [
                      StockHistory(
                          supplier: '',
                          date: '',
                          price: 0,
                          count: 1,
                          totalPrice: 0)
                    ];
                  });
                },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: const Text(
            'Edit',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
