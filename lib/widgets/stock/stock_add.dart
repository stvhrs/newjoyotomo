import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/stock.dart';

class AddPartName extends StatelessWidget {
  const AddPartName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String p = '';
    String n = '';
    String d = '';

    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 79, 117, 134))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Stack(alignment: Alignment.center,
                  children: [Container(decoration: BoxDecoration( color: const Color.fromARGB(255, 79, 117, 134),borderRadius: BorderRadius.circular(10)),height: 400,width:570,),
                    AlertDialog(
                      actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                      title: const Text("Tambah Partnumber"),
                      content: IntrinsicHeight(
                        child: SizedBox(
                          width: 500,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Partnumber',
                                  ),
                                  onChanged: (val) {
                                    p = val.toString();
                                  },
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(
                                    onChanged: (val) {
                                      n = val.toString();
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
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade300),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(
                                    onChanged: (val) {
                                      d = val.toString();
                                    },
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Deskripsi',
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                          height: 2),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade300),
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
                            if ((p.isNotEmpty || d.isNotEmpty || n.isNotEmpty)) {
                              Stock stock = Stock(
                                  
                                  partname: p,
                                  name: n,
                                  desc: d,date: DateTime.now().microsecondsSinceEpoch,
                                  count: 0,
                                  totalPrice: 0);
                              // for (var i = 0; i < 10000; i++) {
                              // stock.name = 'id$i';
                              //  stock.partname = 'part$i';
                              // stock.id = i;
                              objectBox.insertStock(stock);
                              // }
                              //  objectBox.insertStock(stock);
                              //  objectBox.deleteAllStock();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Tambah Stock"),
                        ),
                      ],
                    ),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Partnumber'));
  }
}
