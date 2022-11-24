import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:newJoyo/helper/dialog.dart';
import 'package:newJoyo/helper/styling.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/models/detail_stock.dart';
import 'package:newJoyo/models/invoice.dart';
import 'package:newJoyo/models/mpi.dart';
import 'package:newJoyo/models/realization.dart';


import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../helper/currency.dart';
import '../../../helper/dropdown.dart';
import '../../../models/customer.dart';
import '../../../models/examples.dart';
import '../../../models/mpi/mpiItem.dart';
import '../../../models/stock.dart';
import '../../../models/stockService/service_realization.dart';
import '../../../provider/trigger.dart';
import 'package:newJoyo/library/date_picker/web_date_picker.dart';
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
      return const Icon(
        Icons.check,
        color: Colors.green,
      );
    } else if (i == 2) {
      return const Icon(
        Icons.warning,
        color: Colors.yellow,
      );
    } else {
      return const Icon(
        Icons.dangerous_rounded,
        color: Colors.red,
      );
    }
  }

  TextStyle small = const TextStyle(fontSize: 12);

  TextStyle small2 = const TextStyle(fontSize: 10);
  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  int jumlahOpsiPart = 1;
  int jumlahOpsiService = 1;
  final List<TextEditingController> _partValue = [TextEditingController()];
  final List<TextEditingController> _nameValue = [TextEditingController()];
  final List<TextEditingController> _countValue = [TextEditingController()];
  final List<TextEditingController> _priceValue = [TextEditingController()];
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();
  List<StockRalization> _stockRealization = [StockRalization()];
  List<ServiceRealization> _serviceRealization = [ServiceRealization()];

  _buildService(int i, BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Container(
            margin: const EdgeInsets.only( top: 1),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    style: small2,
                    onChanged: (v){
                      _serviceRealization[i].partName=v;
                    },
                    initialValue: _serviceRealization[i].partName,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: TextFormField(
                      style: small2,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],  onChanged: (value) {
                        _serviceRealization[i].repairPrice =
                            NumberFormat.currency(
                                    locale: 'id_ID', symbol: 'Rp ')
                                .parse(value)
                                .toDouble();
                      },
                      initialValue: formatCurrency
                          .format(_serviceRealization[i].repairPrice),
                    )),
                Expanded(
                    flex: 4,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      style: small2,
                      onChanged: (value) {
                        _serviceRealization[i].servicePrice =
                            NumberFormat.currency(
                                    locale: 'id_ID', symbol: 'Rp ')
                                .parse(value)
                                .toDouble();
                      },
                      initialValue: formatCurrency
                          .format(_serviceRealization[i].servicePrice),
                    )),
                Expanded(
                    flex: 4,
                    child: TextFormField( onChanged: (v){
                      _serviceRealization[i].remark=v;
                    },
                      textAlign: TextAlign.left,
                      style: small2,
                      initialValue: _serviceRealization[i].remark,
                    ))
              ],
            )));
  }

  Widget _buildPartName(int i, BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List<Stock> stocks =
        Provider.of<Trigger>(context, listen: false).listSelectedStock;
    stocks.removeWhere((element) => element.count <= 0);

    log('message');
    totaling() {
      Stock tstock = stocks
          .firstWhere((element) => element.name == _stockRealization[i].name);
      if (_formKey.currentState!.validate()) {
        _stockRealization[i].toalPrice =
            (_stockRealization[i].sellPrice * _stockRealization[i].count);
      }
      if (!_formKey.currentState!.validate()) {
        _countValue[i].text = tstock.count.toString();
        _stockRealization[i].count = int.parse(_countValue[i].text);
      }
    }

    changePrice(Stock element) {
      List<DetailStock> cariHarga = [];
      cariHarga.addAll(element.items);
      for (var i = 0; i < cariHarga.length; i++) {
        if (!cariHarga[i].pihakId.contains('SUP')) {
          cariHarga.remove(cariHarga[i]);
        }
      }
      cariHarga.sort((a, b) => a.buyPrice.compareTo(b.buyPrice));
      _priceValue[i].text =
          formatCurrency.format(cariHarga.last.sellPrice).toString();
      _stockRealization[i].sellPrice = cariHarga.last.sellPrice;
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
          margin: const EdgeInsets.only(left: 10),
          child: Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 12,
                    child: Transform.scale(
                      scale: 0.8,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: DropDownField(
                          enabled: _stockRealization[i].done ? false : true,
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
                    flex: 12,
                    child: Transform.scale(
                      scale: 0.8,
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 100,
                        child: DropDownField(
                          enabled: _stockRealization[i].done ? false : true,
                          textStyle: small,
                          labelStyle: small,
                          inputFormatters: const [],
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
                          readOnly: _stockRealization[i].done,
                          style: small,
                          controller: _priceValue[i],
                          onChanged: (value) {
                            if (_stockRealization.isNotEmpty &&
                                value.isNotEmpty) {
                              _stockRealization[i].sellPrice =
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
                    flex: 5,
                    child: Transform.scale(
                      scale: 0.8,
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: TextFormField(
                        readOnly: _stockRealization[i].done,
                        style: small,
                        validator: (value) {
                          Stock tstock = stocks.firstWhere((element) =>
                              element.name == _stockRealization[i].name);
                          if (_stockRealization[i].count > tstock.count) {
                            return tstock.count.toString();
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _stockRealization[i].count = int.parse(value);

                            totaling();
                            setState(() {});
                          }
                        },
                        initialValue: _countValue[i].text,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      )),
                    )),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Transform.scale(
                      scale: 0.8,
                      alignment: Alignment.center,
                      child: Text(
                        formatCurrency.format(_stockRealization[i].toalPrice =
                            (_stockRealization[i].sellPrice *
                                _stockRealization[i].count)),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Transform.scale(
                        scale: 0.6,
                        child: ChoiceChip(
                          shape: const CircleBorder(),
                          label: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(0),
                          selectedColor: Colors.green,
                          selected: _stockRealization[i].done,
                          onSelected: _stockRealization[i].done
                              ? (v) {}
                              : (v) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return dialog(
                                          onClickAction: () {
                                            Stock stock = stocks.firstWhere(
                                                (element) =>
                                                    element.name ==
                                                    _stockRealization[i].name);
                                            stock.count = stock.count -
                                                _stockRealization[i].count;

                                            List<DetailStock> element = [];
                                            element.addAll(stock.items);
                                            for (var i = 0;
                                                i < element.length;
                                                i++) {
                                              if (!element[i]
                                                  .pihakId
                                                  .contains('SUP')) {
                                                element.remove(element[i]);
                                              }
                                            }
                                            element.sort((a, b) => b.buyPrice
                                                .compareTo(a.buyPrice));

                                            stock.totalPrice =
                                                stock.totalPrice -
                                                    _stockRealization[i].count *
                                                        element[0].buyPrice;
                                            if (stock.totalPrice.isNegative) {
                                              stock.totalPrice = 0;
                                            }
                                            stock.items.add(DetailStock(
                                                buyPrice: element[0].buyPrice,
                                                supplier: widget
                                                    .customer.customerName,
                                                date: DateTime.now()
                                                    .toIso8601String(),
                                                sellPrice: _stockRealization[i]
                                                    .sellPrice,
                                                count:
                                                    _stockRealization[i].count,
                                                totalPrice:
                                                    _stockRealization[i].count *
                                                        _stockRealization[i]
                                                            .sellPrice));
                                            _stockRealization[i].done = true;
                                            objectBox.insertStock(stock);
                                          },
                                          string:
                                              '${_stockRealization[i].partname} akan dikurangi',
                                          context: context);
                                    },
                                  ).then((value) {
                                    if (value == true) {
                                      _stockRealization[i].done = true;
                                      setState(() {});
                                    }
                                  });
                                },
                        ),
                      )),
                )
              ],
            ),
          )),
    );
  }

  late List<MpiItem> data;
  final formatCurrency =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  @override
  void initState() {
    data = widget.customer.mpi.target!.items;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customer.realization.target!.stockItems.isNotEmpty) {
      _stockRealization = widget.customer.realization.target!.stockItems;
       _serviceRealization = widget.customer.realization.target!.serviceItems;
      jumlahOpsiPart = widget.customer.realization.target!.stockItems.length;
       jumlahOpsiService = widget.customer.realization.target!.serviceItems.length;
      for (var i = 0; i < _stockRealization.length; i++) {
        _partValue.add(TextEditingController());
        _nameValue.add(TextEditingController());
        _priceValue.add(TextEditingController());
        _countValue.add(TextEditingController());
        _countValue[i].text = _stockRealization[i].count.toString();
        _partValue[i].text = _stockRealization[i].partname;
        _nameValue[i].text = _stockRealization[i].name;

        _priceValue[i].text =
            formatCurrency.format(_stockRealization[i].sellPrice);
      }
    } else {}

    log('fuck');
    return Theme(
        data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.only(left: 10, bottom: 2),
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 251, 251, 251),
                fontSize: 15,
                height: 2),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
        child: Scaffold(
            floatingActionButton: Row(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 100,
                ),
                child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 79, 117, 134),
                    child: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              const Spacer(),
              Text(_stockRealization.length.toString()),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.blue.shade600,
                      child: const Icon(Icons.save_as_rounded),
                      onPressed: () {
                        double totalpartPrice = 0;

                        double servicePrice = 0;


                        var listPartPrice = _stockRealization
                            .map((element) => element.toalPrice)
                            .toList();

                        for (var element in listPartPrice) {
                          totalpartPrice = totalpartPrice + element;
                        }

                        List<MpiItem> listMpi = [];
                        listMpi.addAll(widget.customer.mpi.target!.items);
                        for (var i = 0; i < listMpi.length; i++) {
                          listMpi
                              .removeWhere((element) => element.attention == 0);
                        }
                        var listservicePrice =
                            listMpi.map((element) => element.price).toList();

                        for (var element in listservicePrice) {
                          servicePrice = servicePrice + element;
                        }
                        for (var element in _serviceRealization) {
                          servicePrice=servicePrice+element.repairPrice+element.servicePrice;
                          
                        }
                        Customer asu = widget.customer;
                        asu.realization.target = Realization(
                            selesai:
                                widget.customer.realization.target!.selesai,
                            biyaya: totalpartPrice + servicePrice,
                            dateOut:
                                widget.customer.realization.target!.dateOut,
                            rlId: widget.customer.realization.target!.rlId);
                        for (var element in _stockRealization) {
                          asu.realization.target!.stockItems.add(
                              StockRalization(
                                  count: element.count,
                                  desc: element.desc,
                                  done: element.done,
                                  name: element.name,
                                  partname: element.partname,
                                  sellPrice: element.sellPrice,
                                  price: element.sellPrice,
                                  toalPrice: element.toalPrice));
                        }
                         for (var element in _serviceRealization) {
                           asu.realization.target!.serviceItems.add(
                              ServiceRealization(
                                 remark: element.remark,
                                   done: element.done,
                                  partName: element.partName,
                                   repairPrice: element.repairPrice,
                                   servicePrice: element.servicePrice,
                              ));
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

                        asu.proses = 'Realisasi';

                        asu.inv.target = Invoice(
                          invId: asu.inv.target!.invId,
                          invoiceDate: asu.inv.target!.invoiceDate,
                          invoiceTotal: totalpartPrice + servicePrice,
                          partTotal: totalpartPrice,
                          serviceTotal: servicePrice,
                          soDate: asu.inv.target!.soDate,
                        );

                        Provider.of<Trigger>(context, listen: false)
                            .selectCustomer(asu, true);
                        objectBox.insertCustomer(asu);
                      })),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.red.shade400,
                      child: const Icon(Icons.picture_as_pdf),
                      onPressed: () async {
                        final bytes = await widgetsToImageController.capture();
                        await createSpk(
                            bytes!,
                            widget.customer.realization.target!.rlId,
                            context,
                            'Realisasi');
                      })),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.print),
                    onPressed: () async {
                      final bytes = await widgetsToImageController.capture();
                      printPdf(bytes!);
                    }),
              )
            ]),
            body: InteractiveViewer(
              child:
                  LayoutBuilder(builder: (context, BoxConstraints constraints) {
                return Center(
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
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
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width:
                                    MediaQuery.of(context).size.height / 1.4202,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 78, 77, 77)
                                              .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3),  
                                    ),
                                  ],
                                ),
                                child: WidgetsToImage(
                                  controller: widgetsToImageController,
                                  child: SizedBox(
                                    width: constraints.maxHeight / 1.4,
                                    height: constraints.maxHeight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, bottom: 5),
                                          child: Text(
                                            widget.customer.realization.target!
                                                .rlId,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const Divider(
                                              height: 0,
                                              color: Colors.black,
                                            ),
                                            widget.customer.mpi.target!.items
                                                    .every((element) =>
                                                        element.attention == 0)
                                                ? const SizedBox()
                                                : top4,
                                            const Divider(
                                              height: 0,
                                              color: Colors.black,
                                            ),
                                            ...widget.customer.mpi.target!.items
                                                .mapIndexed((i, element) =>
                                                    element.attention == 0
                                                        ? const Center()
                                                        : SizedBox(
                                                            width: constraints
                                                                    .maxHeight /
                                                                1.4,
                                                            child:
                                                                IntrinsicHeight(
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
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
                                                                                margin: const EdgeInsets.only(left: 15),
                                                                                child: buildAttention(element.attention))
                                                                          ],
                                                                        )),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 4,
                                                                    child: Text(
                                                                      element
                                                                          .name,
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              11),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 4,
                                                                      child: Text(
                                                                          formatCurrency.format(element
                                                                              .price),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                          ))),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Transform
                                                                        .scale(
                                                                      scale:
                                                                          0.6,
                                                                      child:
                                                                          ChoiceChip(
                                                                        shape:
                                                                            const CircleBorder(),
                                                                        label:
                                                                            const Icon(
                                                                          Icons
                                                                              .done,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(0),
                                                                        selectedColor:
                                                                            Colors.green,
                                                                        selected:
                                                                            element.done,
                                                                        onSelected:
                                                                            (v) {
                                                                          element.done =
                                                                              !element.done;

                                                                          widget
                                                                              .customer
                                                                              .mpi
                                                                              .target!
                                                                              .items[i]
                                                                              .done = element.done;
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )))
                                                .toList(),
                                          ],
                                        ),
                                        Column(
                                          children: [
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
                                                jumlahOpsiPart,
                                                (index) => _buildPartName(
                                                    index, context)),
                                            Transform.scale(
                                                scale: 0.7,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_stockRealization[
                                                                    jumlahOpsiPart -
                                                                        1]
                                                                .done) {
                                                              return;
                                                            }
                                                            if (jumlahOpsiPart >
                                                                    1 &&
                                                                jumlahOpsiPart ==
                                                                    _stockRealization
                                                                        .length) {
                                                              _stockRealization
                                                                  .removeAt(
                                                                      jumlahOpsiPart -
                                                                          1);
                                                              jumlahOpsiPart =
                                                                  jumlahOpsiPart -
                                                                      1;
                                                              _countValue.removeAt(
                                                                  jumlahOpsiPart -
                                                                      1);
                                                              _partValue.removeAt(
                                                                  jumlahOpsiPart -
                                                                      1);
                                                              _nameValue.removeAt(
                                                                  jumlahOpsiPart -
                                                                      1);
                                                            }
                                                          });
                                                        },
                                                        icon: const Icon(Icons
                                                            .remove_circle)),
                                                    IconButton(
                                                        color: Colors.green,
                                                        onPressed: () {
                                                          if (jumlahOpsiPart ==
                                                              _stockRealization
                                                                  .length) {
                                                            jumlahOpsiPart =
                                                                jumlahOpsiPart +
                                                                    1;
                                                            _stockRealization.add(
                                                                StockRalization(
                                                              desc: '',
                                                              name: '',
                                                              partname: '',
                                                              toalPrice: 0.0,
                                                              done: false,
                                                              price: 0,
                                                              count: 1,
                                                            ));
                                                            _countValue.add(
                                                                TextEditingController());
                                                            _partValue.add(
                                                                TextEditingController());
                                                            _nameValue.add(
                                                                TextEditingController());
                                                            _priceValue.add(
                                                                TextEditingController());

                                                            setState(() {});
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons.add_circle)),
                                                  ],
                                                )),
                                            const Divider(
                                              height: 0,
                                              color: Colors.black,
                                            ),
                                            top2,
                                            const Divider(
                                              height: 0,
                                              color: Colors.black,
                                            ),
                                            ...List.generate(
                                                jumlahOpsiService,
                                                (index) => _buildService(
                                                    index, context)),
                                            Transform.scale(
                                              scale: 0.7,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        setState(() {
                                                          if (jumlahOpsiService >
                                                                  1 &&
                                                              jumlahOpsiService ==
                                                                  _serviceRealization
                                                                      .length) {
                                                            _serviceRealization
                                                                .removeAt(
                                                                    jumlahOpsiService -
                                                                        1);
                                                            jumlahOpsiService =
                                                                jumlahOpsiService -
                                                                    1;
                                                          }
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.remove_circle)),
                                                  IconButton(
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        if (jumlahOpsiService ==
                                                            _serviceRealization
                                                                .length) {
                                                          jumlahOpsiService =
                                                              jumlahOpsiService +
                                                                  1;
                                                          _serviceRealization.add(
                                                              ServiceRealization());

                                                          setState(() {});
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.add_circle)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              const Divider(
                                                color: Colors.black,
                                                height: 0,
                                              ),
                                              top3,
                                              const Divider(
                                                color: Colors.black,
                                                height: 0,
                                              ),
                                              bottom()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ])));
              }),
            )));
  }

  Widget top = Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        flex: 12,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Partname",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 12,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Harga",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Jumlah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Total",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Done",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
    ],
  );
  Widget top2 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Repair Partname",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
         margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Harga Repair",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
      margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Harga Service",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container( margin: const EdgeInsets.only(left: 10),
          child: const Text(
          
            "Remark",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
    ],
  );

  Widget top3 = Row(
    children: [
      Expanded(
        flex: 20,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Est Selesai",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 20,
        child: Container(
          child: const Text(
            "Est Biaya",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 20,
        child: Container(
          child: const Text(
            "Rls Selesai",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      Expanded(
        flex: 20,
        child: Container(
          child: const Text(
            "Rls Biaya",
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
            textAlign: TextAlign.right,
            "Date Out",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
    ],
  );
  Widget bottom() => Container(margin: EdgeInsets.only(top: 10),
    child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 20,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.customer.spk.target!.estimasiSelesai == 'DD/MM/YYYY'
                      ? 'DD/MM/YYYY'
                      : DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(
                              widget.customer.spk.target!.estimasiSelesai),
                        ),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                child: Text(
                  formatCurrendcy
                      .format(widget.customer.spk.target!.estimasiBiyaya),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: WebDatePicker(
                  small: true,
                  initialDate:
                      widget.customer.realization.target!.selesai == 'DD/MM/YYYY'
                          ? null
                          : DateTime.parse(
                              widget.customer.realization.target!.selesai),
                   style: const TextStyle(fontSize: 5),
                  onChange: (v) {
                    if (v == null) {
                      return;
                    }
                    widget.customer.realization.target!.selesai =
                        v.toIso8601String();
                  },
                  inputDecoration: inputNone('Tanggal'),
                  dateformat: 'dd/MM/yyy',
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                child: Text(
                  formatCurrendcy.format(
                    widget.customer.realization.target!.biyaya,
                  ),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            Expanded(
              flex: 17,
              child: Container(
                child: Text(
                  widget.customer.spk.target!.date == 'DD/MM/YYYY'
                      ? 'DD/MM/YYYY'
                      : DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(widget.customer.spk.target!.date)),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            Expanded(
              flex: 17,
              child: WebDatePicker(
                small: true,
                initialDate: widget.customer.realization.target!.dateOut ==
                        'DD/MM/YYYY'
                    ? null
                    : DateTime.parse(widget.customer.realization.target!.dateOut),
                 style: const TextStyle(fontSize: 5),
                onChange: (v) {
                  if (v == null) {
                    return;
                  }
                  widget.customer.realization.target!.dateOut =
                      v.toIso8601String();
                },
                inputDecoration: inputNone('Tanggal'),
                dateformat: 'dd/MM/yyy',
              ),
            )
          ],
        ),
  );
  Widget top4 = Row(
    children: [
      Expanded(
        flex: 6,
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          child: const Text(
            "Inspection",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ),
      const Expanded(
        flex: 5,
        child: Text(
          "Service",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Text(
          "Done",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      )
    ],
  );
}
