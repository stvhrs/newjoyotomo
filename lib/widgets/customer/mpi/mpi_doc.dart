import 'package:newJoyo/helper/currency.dart';

import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/mpi.dart';
import 'package:newJoyo/models/mpi/mpiItem.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../helper/sparated_column.dart';
import '../../../models/customer.dart';

class MpiDoc extends StatefulWidget {
  final Customer customer;
  const MpiDoc({super.key, required this.customer});

  @override
  State<MpiDoc> createState() => _MpiDocState();
}

class _MpiDocState extends State<MpiDoc> {
  late List<MpiItem> data;
  List<MpiItem> data2 = [];
  @override
  void initState() {
    data = widget.customer.mpi.target!.items;
    super.initState();
  }

  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: Row(children: [
          const Spacer(),
          Padding(
              padding: const EdgeInsets.all(5),
              child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.blue.shade600,
                  child: const Icon(Icons.save_as_rounded),
                  onPressed: () {
                    Customer asu = widget.customer;
                    asu.mpi.target =
                        Mpi(mpiId: widget.customer.mpi.target!.mpiId);
                    for (var element in data) {
                      asu.mpi.target!.items.add(MpiItem(
                          category: element.category,
                          name: element.name,
                          attention: element.attention,
                          price: element.price,
                          remark: element.remark));
                    }

                    objectBox.insertCustomer(asu);
                  })),
          Padding(
              padding: const EdgeInsets.all(5),
              child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.red.shade400,
                  child: const Icon(Icons.picture_as_pdf),
                  onPressed: () {})),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.green,
                child: const Icon(Icons.print),
                onPressed: () {}),
          )
        ]),
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Center(
        child:Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/icon.jpg',
                        ),
                        opacity: 0.3,
                        repeat: ImageRepeat.repeat,
                        scale: 20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Container( height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height / 1.4142,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 78, 77, 77)
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                         
                          child: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: constraints.maxHeight / 1.4,
          height: constraints.maxHeight,
          child: InteractiveViewer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "MULTI POINT INSPETION `MPI`",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green, border: Border.all()),
                    child: const Text('Checked and Okay',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    width: constraints.maxHeight / 1.4 / 3.3,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.yellow, border: Border.all()),
                    child: const Text('Attention Recomended',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    width: constraints.maxHeight / 1.4 / 3.3,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: Colors.red, border: Border.all()),
                    child: const Text('Attention Required',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    width: constraints.maxHeight / 1.4 / 3.3,
                  )
                ],
              ),
              Container(
                width: constraints.maxHeight / 1.4,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                    bottom: BorderSide(
                        width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        width: constraints.maxHeight / 1.4 / 3.2,
                        child: const Text('BRAKES - TIRES - ALIGNMENT',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        width: constraints.maxHeight / 1.4 / 4,
                       
                        child: Text('PRICE',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                       Container(
                        padding: const EdgeInsets.all(4),
                        width: constraints.maxHeight / 1.4 / 4,
                      
                        child: Text('REMARK',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              SeparatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  separatorBuilder: (context, index) {
                    if (data[index].category != data[index + 1].category) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          children: [
                            Text(data[index + 1].category,
                                style: const TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            const Spacer()
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                  children: data.mapIndexed((index, element) {
                    return Container(
                        width: constraints.maxHeight / 1.4,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: constraints.maxHeight / 1.4 / 2.9,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Transform.scale(
                                        alignment: Alignment.centerLeft,
                                        scale: 0.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              height: 16,
                                              child: Checkbox(
                                                  activeColor: Colors.green,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value:
                                                      data[index].attention ==
                                                          1,
                                                  onChanged: (sd) {
                                                    setState(() {});
                                                    if (data[index].attention ==
                                                        1) {
                                                      data[index].attention = 0;
                                                    } else {
                                                      data[index].attention = 1;
                                                    }
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 16,
                                              child: Checkbox(
                                                  activeColor: Colors.yellow,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value:
                                                      data[index].attention ==
                                                          2,
                                                  onChanged: (sd) {
                                                    setState(() {});
                                                    if (data[index].attention ==
                                                        2) {
                                                      data[index].attention = 0;
                                                    } else {
                                                      data[index].attention = 2;
                                                    }
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 16,
                                              child: Checkbox(
                                                  activeColor: Colors.red,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value:
                                                      data[index].attention ==
                                                          3,
                                                  onChanged: (sd) {
                                                    setState(() {});
                                                    if (data[index].attention ==
                                                        3) {
                                                      data[index].attention = 0;
                                                    } else {
                                                      data[index].attention = 3;
                                                    }
                                                  }),
                                            )
                                          ],
                                        )),
                                    Positioned(
                                      left: 55,
                                      top: 1,
                                      child: Text(
                                        data[index].name,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 100,
                                margin: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                    onChanged: (value) {
                                      data[index].price = NumberFormat.currency(
                                              locale: 'id_ID', symbol: 'Rp ')
                                          .parse(value)
                                          .toDouble();
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    scrollPadding: const EdgeInsets.all(0),
                                    decoration: const InputDecoration(
                                      isDense: true, //
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    initialValue:
                                        data[index].price.toString() == '0.0'
                                            ? 'Rp 0,00'
                                            : formatCurrendcy
                                                .format(data[index].price)
                                                .toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                    )),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 200,
                                // margin: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                    onChanged: (v) {
                                      data[index].remark = v;
                                    },
                                    scrollPadding: const EdgeInsets.all(0),
                                    decoration: const InputDecoration(
                                      isDense: true, //
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    initialValue: data[index].remark,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    )),
                              ),
                            ],
                          ),
                        ));
                  }).toList()),
            ],
          )),
        ),
      )])));
    }));
  }
}
