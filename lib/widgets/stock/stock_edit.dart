import 'package:flutter/material.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/stock.dart';

class StockEdit extends StatelessWidget {
  final Stock stock;
  const StockEdit(this.stock);

  @override
  Widget build(BuildContext context) {
    Stock _stock = stock;

    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 79, 117, 134),
                        borderRadius: BorderRadius.circular(10)),
                    height: 400,
                    width: 570,
                  ),
                  AlertDialog(
                    actionsPadding:
                        const EdgeInsets.only(right: 15, bottom: 15),
                    title: const Text("Edit Part Number"),
                    content: IntrinsicHeight(
                      child: SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                initialValue: _stock.partname,
                                decoration: const InputDecoration(
                                  hintText: 'Part Number',
                                ),
                                onChanged: (val) {
                                  _stock.partname = val.toString();
                                },
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                  initialValue: _stock.name,
                                  onChanged: (val) {
                                    _stock.name = val.toString();
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                        height: 2),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                  initialValue: _stock.desc,
                                  onChanged: (val) {
                                    _stock.desc = val.toString();
                                  },
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                        height: 2),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          if ((_stock.partname.isNotEmpty ||
                              _stock.desc.isNotEmpty ||
                              _stock.name.isNotEmpty)) {
                            // for (var i = 0; i < 10000; i++) {
                            // _stock.name = 'id$i';
                            //  _stock.partname = 'part$i';
                            // stock.id = i;
                            _stock.date=DateTime.now().microsecondsSinceEpoch;
                            objectBox.insertStock(_stock);
                            Navigator.of(context).pop();
                            Provider.of<Trigger>(context)
                                .selectStock(stock,true);
                            // }
                            //  objectBox.insertStock(stock);
                            //  objectBox.deleteAllStock();

                          }
                        },
                        child: const Text("Edit   "),
                      ),
                    ],
                  ),
                ],
              );
            });
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.green,
      ),
    );
  }
}
