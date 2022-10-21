
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/stock_history.dart';
import 'package:newJoyo/provider/trigger.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/stock.dart';

class StockRemove extends StatefulWidget {
  const StockRemove({Key? key}) : super(key: key);

  @override
  State<StockRemove> createState() => _StockRemoveState();
}

class _StockRemoveState extends State<StockRemove> {
  int _reduce = 1;
  String _reduceDes = '';
 

  @override
  Widget build(BuildContext context) {
    Stock stock = Provider.of<Trigger>(context, listen: false).selectedStock;
    return Row(
      children: [
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  alignment: Alignment.centerRight,
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed:stock.count==0?(){}: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          actionsPadding:
                              const EdgeInsets.only(right: 15, bottom: 15),
                          title: const Text("Reduce Stock"),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    IntrinsicHeight(
                              child: SizedBox(
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_reduce > 1) {
                                                  _reduce = _reduce - 1;
                                                }
                                              });
                                            },
                                            icon: const Icon(Icons.remove_circle)),
                                        Text(_reduce.toString()),
                                        IconButton(
                                            onPressed: () {
                                              if (_reduce < stock.count) {
                                                setState(() {
                                                  _reduce = _reduce + 1;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.add_circle)),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: TextFormField(
                                          onChanged: (val) {
                                            _reduceDes = val;
                                          },
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: 'Description',
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    bottom: 10),
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 15,
                                                height: 2),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                late StockHistory history;
                                history = StockHistory(
                                    supplier: _reduceDes,
                                    date: DateTime.now().toIso8601String(),
                                    price: -stock.lastPrice,
                                    count: -_reduce,
                                    totalPrice: -stock.lastPrice * _reduce);
                                stock.count = stock.count - _reduce;

                                stock.items.add(history);
                                objectBox.insertStock(stock);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Reduce"),
                            ),
                          ]);
                    }).then((value) {
                  _reduce = 1;
                  _reduceDes = '';
                });
              },
              icon: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              label: const Text(
                'Accident',
                style: TextStyle(color: Colors.red),
              )),
        ),
      ],
    );
  }
}
