import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:provider/provider.dart';
import '../../../helper/currency.dart';
import '../../../helper/dropdown.dart';
import '../../../models/customer.dart';
import '../../../models/stock.dart';
import '../../../provider/trigger.dart';
import 'dart:math' as mh;

class RealizationDoc extends StatefulWidget {
  final Customer customer;
  const RealizationDoc({super.key, required this.customer});

  @override
  State<RealizationDoc> createState() => _RealizationDocState();
}

class _RealizationDocState extends State<RealizationDoc> {
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  int jumlahOpsi = 1;
  List<Stock> _updatedStock = [];
  final List<TextEditingController> _partValue = [TextEditingController()];
  final List<TextEditingController> _nameValue = [TextEditingController()];
  final List<TextEditingController> _priceValue = [TextEditingController()];
  List<StockRalization> _stockRealization = [StockRalization()];
  Widget _buildPartName(int i, BuildContext context) {
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
       stocks.removeWhere((element) => element.count==0);
          
        
    log('message');
    totaling() {
      _stockRealization[i].toalPrice =
          (_stockRealization[i].price * _stockRealization[i].count) +
              _stockRealization[i].servicePrice;
    }

    changePrice(Stock element) {
      _priceValue[i].text = formatCurrency
          .format(element.totalPrice / element.count * 1.3  +1000-
              (element.totalPrice / element.count * 1.3 % 1000))
          .toString();
      _stockRealization[i].price = element.totalPrice / element.count * 1.3 +1000-
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

    return Transform.scale(
      scale: 0.7,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: DropDownField(
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
                          if(found.count<1){
                            return ;
                          }
                          changeName(
                            val,
                          );
                          changePrice(found);
                          totaling();
                          if (_stockRealization.length < i + 1) {
                            _updatedStock.insert(i, found);
                          }

                          setState(() {});
                        }
                      },
                      labelText: 'PartName',
                      items: stocks.map((e) => e.partname).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: DropDownField(inputFormatters: [],
                      controller: _nameValue[i],
                    
                      value: _stockRealization[i].name,
                      
                      onValueChanged: (val) {
                        if (stocks.map((e) => e.name).toList().contains(val)) { 
                           Stock found = stocks.firstWhere((element) {
                            return element.name == val;
                          });
                          if(found.count<1){
                            return ;
                          }
                         changePart(
                            val,
                          );
                          changePrice(found);
                          totaling();
                          if (_stockRealization.length < i + 1) {
                            _updatedStock.insert(
                                i,
                                found);
                          }

                          setState(() {});
                        }
                      },
                      strict: true,
                      labelText: 'Name',
                      items: stocks.map((e) => e.name).toList(),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: InputDecoration(label: Text('Service')),
                      onChanged: (value) {
                        if (_stockRealization.isNotEmpty) {
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
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: _priceValue[i],
                      decoration: InputDecoration(label: Text('Price')),
                      onChanged: (value) {
                        if (_stockRealization.isNotEmpty) {
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
                  SizedBox(
                      width: 100,
                      child: TextFormField(
                        onChanged: (value) {
                          _stockRealization[i].count = int.parse(value);

                          totaling();
                          setState(() {});
                        },
                        initialValue: '1',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      )),
                  Text((_stockRealization[i].toalPrice =
                          (_stockRealization[i].price *
                                  _stockRealization[i].count) +
                              _stockRealization[i].servicePrice).toInt()
                      .toString()),
                ],
              )),
    );
  }

  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: constraints.maxHeight / 1.4,
          height: constraints.maxHeight,
          child: Column(
            children: [
              const Divider(
                height: 0,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "REALISASI",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 0,
                color: Colors.black,
              ),
              ...widget.customer.mpi.target!.items
                  .map((element) => element.attention == 0
                      ? const SizedBox()
                      : Container(
                          width: constraints.maxHeight / 1.4,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  width: constraints.maxHeight / 1.4 / 2.8,
                                  child: Stack(
                                    clipBehavior: Clip.none,
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
                                                        element.attention == 1,
                                                    onChanged: (sd) {}),
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
                                                        element.attention == 2,
                                                    onChanged: (sd) {}),
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
                                                        element.attention == 3,
                                                    onChanged: (sd) {}),
                                              )
                                            ],
                                          )),
                                      Positioned(
                                        left: 55,
                                        top: 1,
                                        child: Text(
                                          element.name,
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        formatCurrency.format(element.price),
                                        style: const TextStyle(
                                          fontSize: 11,
                                        ))),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 150,
                                  // margin: EdgeInsets.only(left: 10),
                                  child: Text(element.remark,
                                      style: const TextStyle(
                                        fontSize: 11,
                                      )),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Transform.scale(
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
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            ),
                          )))
                  .toList(),
              ...List.generate(
                  jumlahOpsi, (index) => _buildPartName(index, context)),
              Row(
                children: [
                  IconButton(
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
            ],
          ),
        ),
      );
    }));
  }
}
