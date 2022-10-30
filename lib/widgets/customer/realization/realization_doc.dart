import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:newJoyo/helper/styling.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/mpi.dart';
import 'package:newJoyo/models/realization.dart';

import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:provider/provider.dart';
import '../../../helper/currency.dart';
import '../../../helper/dropdown.dart';
import '../../../models/customer.dart';
import '../../../models/mpi/mpiItem.dart';
import '../../../models/stock.dart';
import '../../../provider/trigger.dart';
import 'dart:math' as mh;
import 'package:collection/collection.dart';

class RealizationDoc extends StatefulWidget {
  final Customer customer;
  const RealizationDoc({super.key, required this.customer});

  @override
  State<RealizationDoc> createState() => _RealizationDocState();
}

class _RealizationDocState extends State<RealizationDoc> {
  Widget buildAttention(int i) {
    if (i == 1) {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else if (i == 2) {
      return Icon(
        Icons.warning,
        color: Colors.yellow,
      );
    } else {
      return Icon(
        Icons.dangerous_rounded,
        color: Colors.red,
      );
    }
    return SizedBox();
  }

  TextStyle small = TextStyle(fontSize: 12);
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  int jumlahOpsi = 1;

  final List<TextEditingController> _partValue = [TextEditingController()];
  final List<TextEditingController> _nameValue = [TextEditingController()];
  final List<TextEditingController> _priceValue = [TextEditingController()];
  List<StockRalization> _stockRealization = [StockRalization()];
  Widget _buildPartName(int i, BuildContext context) {
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    stocks.removeWhere((element) => element.count == 0);

    log('message');
    totaling() {
      _stockRealization[i].toalPrice =
          (_stockRealization[i].price * _stockRealization[i].count) +
              _stockRealization[i].servicePrice;
    }

    changePrice(Stock element) {
      _priceValue[i].text = formatCurrency
          .format(element.totalPrice / element.count * 1.3 +
              1000 -
              (element.totalPrice / element.count * 1.3 % 1000))
          .toString();
      _stockRealization[i].price = element.totalPrice / element.count * 1.3 +
          1000 -
          (element.totalPrice / element.count * 1.3 % 1000);
    }

    changeName(
      String val,
    ) {
      _nameValue[i].text = stocks.firstWhere((element) {
        return element.partname == val;
      }).name;
      _stockRealization[i].name = _nameValue[i].text;
    }

    changePart(
      String val,
    ) {
      _partValue[i].text = stocks.firstWhere((element) {
        return element.name == val;
      }).partname;
      _stockRealization[i].partname = _partValue[i].text;
    }

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 8,
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: DropDownField(
                        itemsVisibleInDropdown: 1,
                        textStyle: small,
                        labelStyle: small,
                        controller: _partValue[i],
                        required: true,
                        value: _stockRealization[i].partname,
                        onValueChanged: (val) {
                          if (stocks
                              .map((e) => e.partname)
                              .toList()
                              .contains(val)) {
                            Stock found = stocks.firstWhere((element) {
                              return element.partname == val;
                            });
                            if (found.count < 1) {
                              return;
                            }
                            changeName(
                              val,
                            );
                            changePrice(found);
                            totaling();

                            setState(() {});
                          }
                        },
                        items: stocks.map((e) => e.partname).toList(),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 100,
                      child: DropDownField(
                        textStyle: small,
                        labelStyle: small,
                        inputFormatters: [],
                        controller: _nameValue[i],
                        value: _stockRealization[i].name,
                        onValueChanged: (val) {
                          if (stocks
                              .map((e) => e.name)
                              .toList()
                              .contains(val)) {
                            Stock found = stocks.firstWhere((element) {
                              return element.name == val;
                            });
                            if (found.count < 1) {
                              return;
                            }
                            changePart(
                              val,
                            );
                            changePrice(found);
                            totaling();

                            setState(() {});
                          }
                        },
                        strict: true,
                        items: stocks.map((e) => e.name).toList(),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: TextFormField(
                        initialValue: formatCurrency
                            .format(_stockRealization[i].servicePrice),
                        style: small,
                        onChanged: (value) {
                          if (_stockRealization.isNotEmpty &&
                              value.isNotEmpty) {
                            _stockRealization[i].servicePrice =
                                NumberFormat.currency(
                                        locale: 'id_ID', symbol: 'Rp ')
                                    .parse(value)
                                    .toDouble();
                            totaling();

                            setState(() {});
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: TextFormField(
                        style: small,
                        controller: _priceValue[i],
                        onChanged: (value) {
                          if (_stockRealization.isNotEmpty &&
                              value.isNotEmpty) {
                            _stockRealization[i].price = NumberFormat.currency(
                                    locale: 'id_ID', symbol: 'Rp ')
                                .parse(value)
                                .toDouble();
                            totaling();
                            setState(() {});
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: TextFormField(
                      style: small,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _stockRealization[i].count = int.parse(value);

                          totaling();
                          setState(() {});
                        }
                      },
                      initialValue: '1',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )),
                  )),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.center,
                    child: Text(
                      formatCurrency.format(_stockRealization[i].toalPrice =
                          (_stockRealization[i].price *
                                  _stockRealization[i].count) +
                              _stockRealization[i].servicePrice),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Transform.scale(
                      scale: 0.6,
                      child: ChoiceChip(
                        shape: CircleBorder(),
                        label: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(0),
                        selectedColor: Colors.green,
                        selected: _stockRealization[i].done,
                        onSelected: (v) {
                          _stockRealization[i].done =
                              !_stockRealization[i].done;
                          setState(() {});
                        },
                      ),
                    )),
              )
            ],
          )),
    );
  }

  TextEditingController dateinput = TextEditingController();
  late List<MpiItem> data;
  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  void initState() {
    data = widget.customer.mpi.target!.items;

    dateinput.text = widget.customer.realization.target!.dateOut;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customer.realization.target!.stockItems.isNotEmpty) {
      _stockRealization = widget.customer.realization.target!.stockItems;
      jumlahOpsi = widget.customer.realization.target!.stockItems.length;
      for (var i = 0; i < _stockRealization.length; i++) {
        _partValue.add(TextEditingController());
        _nameValue.add(TextEditingController());
        _priceValue.add(TextEditingController());
        _partValue[i].text = _stockRealization[i].partname;
        _nameValue[i].text = _stockRealization[i].name;
        _priceValue[i].text = formatCurrency.format(_stockRealization[i].price);
      }
    } else {}

    log('fuck');
    return Scaffold(
        floatingActionButton: Row(children: [
          const Spacer(),
          Text(_stockRealization.length.toString()),
          Padding(
              padding: const EdgeInsets.all(5),
              child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.blue.shade600,
                  child: const Icon(Icons.save_as_rounded),
                  onPressed: () {
                    for (var element in _stockRealization) {
                      widget.customer.realization.target!.biyaya =
                          widget.customer.realization.target!.biyaya +
                              element.toalPrice;
                    }

                    Customer asu = widget.customer;
                    asu.realization.target = Realization(
                        selesai: widget.customer.realization.target!.selesai,
                        biyaya: widget.customer.realization.target!.biyaya,
                        dateOut: widget.customer.realization.target!.dateOut,
                        rlId: widget.customer.realization.target!.rlId);
                    for (var element in _stockRealization) {
                      asu.realization.target!.stockItems.add(StockRalization(
                          count: element.count,
                          desc: element.desc,
                          done: element.done,
                          name: element.name,
                          partname: element.partname,
                          price: element.price,
                          servicePrice: element.servicePrice,
                          toalPrice: element.toalPrice));
                    }
                    asu.mpi.target =
                        Mpi(mpiId: widget.customer.mpi.target!.mpiId);
                    for (var element in data) {
                      asu.mpi.target!.items.add(MpiItem(
                          category: element.category,
                          name: element.name,
                          done: element.done,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "REALISASI",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    color: Colors.black,
                  ),
                  widget.customer.mpi.target!.items
                          .every((element) => element.attention == 0)
                      ? SizedBox()
                      : top2,
                  const Divider(
                    height: 0,
                    color: Colors.black,
                  ),
                  ...widget.customer.mpi.target!.items
                      .mapIndexed((i, element) => element.attention == 0
                          ? const Center()
                          : Container(
                              width: constraints.maxHeight / 1.4,
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Transform.scale(
                                          alignment: Alignment.centerLeft,
                                          scale: 0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: buildAttention(
                                                      element.attention))
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        element.name,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                            formatCurrency
                                                .format(element.price),
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ))),
                                    Expanded(
                                      flex: 1,
                                      child: Transform.scale(
                                        scale: 0.6,
                                        child: ChoiceChip(
                                          shape: CircleBorder(),
                                          label: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          selectedColor: Colors.green,
                                          selected: element.done,
                                          onSelected: (v) {
                                            element.done = !element.done;

                                            widget.customer.mpi.target!.items[i]
                                                .done = element.done;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )))
                      .toList(),
                  const Divider(
                    height: 0,
                    color: Colors.black,
                  ),
                  top,
                  const Divider(
                    height: 0,
                    color: Colors.black,
                  ),
                  ...List.generate(
                      jumlahOpsi, (index) => _buildPartName(index, context)),
                  Row(
                    children: [
                      IconButton(
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              if (jumlahOpsi > 1 &&
                                  jumlahOpsi == _stockRealization.length) {
                                _stockRealization.removeAt(jumlahOpsi - 1);
                                jumlahOpsi = jumlahOpsi - 1;
                                _partValue.removeAt(jumlahOpsi - 1);
                                _nameValue.removeAt(jumlahOpsi - 1);
                              }
                            });
                          },
                          icon: const Icon(Icons.remove_circle)),
                      IconButton(
                          color: Colors.green,
                          onPressed: () {
                            if (jumlahOpsi == _stockRealization.length) {
                              print(jumlahOpsi == _stockRealization.length);

                              jumlahOpsi = jumlahOpsi + 1;
                              _stockRealization.add(StockRalization(
                                desc: '',
                                name: '',
                                partname: '',
                                servicePrice: 0.0,
                                toalPrice: 0.0,
                                done: false,
                                price: 0,
                                count: 1,
                              ));
                              _partValue.add(TextEditingController());
                              _nameValue.add(TextEditingController());
                              _priceValue.add(TextEditingController());

                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.add_circle)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 0,
                  ),
                  top3,
                  Divider(
                    color: Colors.black,
                    height: 0,
                  ),
                  bottom()
                ],
              ),
            ),
          )])));
        }));
  }

  Widget top = Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Partname",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Service",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Count",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Total",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Done",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
    ],
  );

  Widget top3 = Row(
    children: [
      Expanded(
        flex: 14,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: const Text(
            "Est Selesai",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 14,
        child: Container(
          child: const Text(
            "Est Biyaya",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 14,
        child: Container(
          child: const Text(
            "Rlt Selesai",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 14,
        child: Container(
          child: const Text(
            "Rlt Biyaya",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 17,
        child: Container(
          child: const Text(
            "Date In",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 17,
        child: Container(
          child: const Text(
            "Date Out",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
    ],
  );
  Widget bottom() => Row(
       mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 14,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                widget.customer.spk.target!.estimasiSelesai.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Container(
              child: Text(
                formatCurrendcy.format( widget.customer.spk.target!.estimasiBiyaya),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Container(margin: EdgeInsets.only(right: 30),
              child: TextFormField(decoration: InputDecoration(  isDense: true,isCollapsed: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (val) {
                  widget.customer.realization.target!.selesai = int.parse(val);
                },
                initialValue:
                    widget.customer.realization.target!.selesai.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Container(
              child: Text(
               formatCurrendcy.format( widget.customer.realization.target!.biyaya,),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 17,
            child: Container(
              child: Text(
                widget.customer.spk.target!.date.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 17,child: Container(margin: EdgeInsets.only(right: 30),child:
             TextFormField(decoration: InputDecoration(  isDense: true,),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      builder: (context, child) => Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromARGB(255, 79, 117,
                                    134), // header background color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Colors.green, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          ),
                      locale: Localizations.localeOf(context),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2022), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                      widget.customer.realization.target!.dateOut =
                          dateinput.text;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
                controller: dateinput,
                style: TextStyle(fontSize: 10),
              )),
            
          ),
        ],
      );
  Widget top2 = Row(
    children: [
      Expanded(
        flex: 6,
        child: Container(
          margin: EdgeInsets.only(left: 15),
          child: const Text(
            "Inspection",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: const Text(
          "Service",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      ),
      Expanded(
        flex: 1,
        child: const Text(
          "Done",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      )
    ],
  );
}
