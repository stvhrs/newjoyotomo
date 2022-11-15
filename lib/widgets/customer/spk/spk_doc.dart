import 'dart:io';

import 'package:newJoyo/helper/currency.dart';
import 'package:newJoyo/main.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:newJoyo/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../helper/border.dart';
import '../../../models/customer.dart';
import '../../../models/examples.dart';
import '../../../models/spk.dart';

class SpkDoc extends StatefulWidget {
  final Customer customer;
   SpkDoc({super.key, required this.customer});

  @override
  State<SpkDoc> createState() => _SpkDocState();
}

class _SpkDocState extends State<SpkDoc> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController estimasiSelesaiInput = TextEditingController();
  WidgetsToImageController controller = WidgetsToImageController();
  late Spk spk;
  @override
  void initState() {
    super.initState();
    spk = widget.customer.spk.target!;
    dateinput.text = spk.date;
    estimasiSelesaiInput.text = spk.estimasiSelesai;
  }

  final formatCurrendcy =
      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: 'Rp ');
  TextStyle small =  TextStyle(fontSize: 10);
  TextStyle med =  TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  TextStyle big =  TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    double width1 = MediaQuery.of(context).size.height / 4.8;
    double width2 = MediaQuery.of(context).size.height / 7.08;
    double width3 = MediaQuery.of(context).size.height / 2.36;
    double width4 = MediaQuery.of(context).size.height / 3.165;
    double width5 = MediaQuery.of(context).size.height / 4.1;
    double width6 = MediaQuery.of(context).size.height / 7.73;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
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
                  Container(
                    padding:  EdgeInsets.all(25),
                    margin:  EdgeInsets.only(top: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color:  Color.fromARGB(255, 78, 77, 77)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                               Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height / 1.4142,
                    child: WidgetsToImage(
                        controller: controller,
                        child: Theme(
                          data: ThemeData(
                            inputDecorationTheme: InputDecorationTheme(
                              contentPadding:  EdgeInsets.only(
                                  left:5, bottom: 22,top: 5),
                              hintStyle:  TextStyle(
                                  color: Color.fromARGB(255, 251, 251, 251),
                                  fontSize: 15,
                                  height: 2),
                               border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.height /
                                        1.6,
                                    child: Kop()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Perintah Bengkel: ${spk.jtId}',
                                      style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            margin:
                                                 EdgeInsets.only(top: 5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                            ),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Kotak(
                                                          width: width1,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              25,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'No. Polisi :',
                                                                style: med,
                                                              ),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.policeNumber =
                                                                            v;
                                                                      },
                                                                      initialValue: spk.policeNumber)),
                                                            ],
                                                          )),
                                                      Kotak(
                                                        width: width2,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            25,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Pemilik :',
                                                              style: med,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  TextFormField(
                                                                      style:
                                                                          small,
                                                                      onChanged:
                                                                          (v) {
                                                                        setState(
                                                                            () {});
                                                                        widget
                                                                            .customer
                                                                            .customerName = v;
                                                                      },
                                                                      initialValue: widget
                                                                          .customer
                                                                          .customerName),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Kotak(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            8,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            25,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Km :',
                                                              style: med,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  TextFormField(
                                                                      inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly,
                                                                  ],
                                                                      style:
                                                                          small,
                                                                      onChanged:
                                                                          (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.km =v;
                                                                           
                                                                      },
                                                                      initialValue: spk
                                                                          .km
                                                                          .toString()),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Kotak(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              6.4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              25,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Tanggal  :',
                                                                style: med,
                                                              ),
                                                              Flexible(
                                                                  child:
                                                                      TextFormField(
                                                                controller:
                                                                    dateinput,
                                                                //editing controller of this TextField

                                                                onTap:
                                                                    () async {
                                                                  DateTime?
                                                                      pickedDate =
                                                                      await showDatePicker(
                                                                          builder: (context, child) =>
                                                                              Theme(
                                                                                data: Theme.of(context).copyWith(
                                                                                  colorScheme:  ColorScheme.light(
                                                                                    primary: Color.fromARGB(255, 79, 117, 134), // header background color
                                                                                  ),
                                                                                  textButtonTheme: TextButtonThemeData(
                                                                                    style: TextButton.styleFrom(
                                                                                      foregroundColor: Colors.green, // button text color
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: child!,
                                                                              ),
                                                                          locale: Localizations.localeOf(
                                                                              context),
                                                                          context:
                                                                              context,
                                                                          initialDate: DateTime
                                                                              .now(),
                                                                          firstDate: DateTime(
                                                                              2022), //DateTime.now() - not to allow to choose before today.
                                                                          lastDate:
                                                                              DateTime(2101));

                                                                  if (pickedDate !=
                                                                      null) {
                                                                    print(
                                                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                    String
                                                                        formattedDate =
                                                                        DateFormat('dd/MM/yyyy')
                                                                            .format(pickedDate);
                                                                    print(
                                                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                    //you can implement different kind of Date Format here according to your requirement

                                                                    setState(
                                                                        () {
                                                                      dateinput
                                                                              .text =
                                                                          formattedDate; //set output date to TextField value.
                                                                      spk.date =
                                                                          dateinput
                                                                              .text;
                                                                    });
                                                                  } else {
                                                                    print(
                                                                        "Date is not selected");
                                                                  }
                                                                },
                                                                style: small,
                                                              )),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Kotak(
                                                        width: width1,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            12.5,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Alamat :',
                                                              style: med,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  TextFormField(
                                                                      maxLines:
                                                                          5,
                                                                      style:
                                                                          small,
                                                                      onChanged:
                                                                          (v) {
                                                                        setState(
                                                                            () {});
                                                                        widget
                                                                            .customer
                                                                            .alamat = v;
                                                                      },
                                                                      initialValue: widget
                                                                          .customer
                                                                          .alamat),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Kotak(
                                                            width: width3,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                25,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Kendaraan   :',
                                                                  style: med,
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      TextFormField(
                                                                          style:
                                                                              small,
                                                                          onChanged:
                                                                              (v) {
                                                                            setState(() {});
                                                                            widget.customer.spk.target!.namaKendaraan =
                                                                                v;
                                                                          },
                                                                          initialValue: widget
                                                                              .customer
                                                                              .spk
                                                                              .target!
                                                                              .namaKendaraan),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Kotak(
                                                              width: width3,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  25,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Tipe/Warna :',
                                                                    style: med,
                                                                  ),
                                                                  Flexible(
                                                                      child: TextFormField(
                                                                          style: small,
                                                                          onChanged: (v) {
                                                                            setState(() {});
                                                                            spk.tipeKendaraan =
                                                                                v;
                                                                          },
                                                                          initialValue: spk.tipeKendaraan)),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Kotak(
                                                        width: width1,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            12.5,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Catatan :',
                                                              style: med,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  TextFormField(
                                                                      maxLines:
                                                                          5,
                                                                      style:
                                                                          small,
                                                                      onChanged:
                                                                          (v) {
                                                                        setState(
                                                                            () {});

                                                                        spk.catatan =
                                                                            v;
                                                                      },
                                                                      initialValue:
                                                                          spk.catatan),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Kotak(
                                                              width: width3,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  25,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'No. PKB       :',
                                                                    style: med,
                                                                  ),
                                                                  Flexible(
                                                                      child: TextFormField(
                                                                          style: small,
                                                                          onChanged: (v) {
                                                                            setState(() {});
                                                                            spk.noPkb =
                                                                                v;
                                                                          },
                                                                          initialValue: spk.noPkb)),
                                                                ],
                                                              )),
                                                          Kotak(
                                                              width: width3,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  25,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'No. Rangka :',
                                                                    style: med,
                                                                  ),
                                                                  Flexible(
                                                                      child: TextFormField(
                                                                          style: small,
                                                                          onChanged: (v) {
                                                                            setState(() {});
                                                                            spk.noRangka =
                                                                                v;
                                                                          },
                                                                          initialValue: spk.noRangka)),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Kotak(
                                                          width: width4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                          child: Column(
                                                            children: [
                                                              Text('KELUHAN',
                                                                  style: big),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      maxLines: 5,
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.keluhanKonsumen =
                                                                            v;
                                                                      },
                                                                      initialValue: spk.keluhanKonsumen)),
                                                            ],
                                                          )),
                                                      Kotak(
                                                          width: width4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'ANALISA',
                                                                style: big,
                                                              ),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      maxLines: 5,
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.analisa =
                                                                            v;
                                                                      },
                                                                      initialValue: spk.analisa)),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Kotak(
                                                          width: width4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  'JENIS PEKERJAAN',
                                                                  style: big),
                                                              Flexible(
                                                                child:
                                                                    TextFormField(
                                                                        maxLines:
                                                                            3,
                                                                        style:
                                                                            small,
                                                                        onChanged:
                                                                            (v) {
                                                                          setState(
                                                                              () {});
                                                                          spk.jenisPekrjaan =
                                                                              v;
                                                                        },
                                                                        initialValue:
                                                                            spk.jenisPekrjaan),
                                                              ),
                                                              IntrinsicHeight(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      clipBehavior:
                                                                          Clip.none,
                                                                      children: [
                                                                        Transform
                                                                            .scale(
                                                                          scale:
                                                                              0.7,
                                                                          child: Radio(
                                                                              activeColor: Colors.green,
                                                                              value: 1,
                                                                              groupValue: spk.levelPekerjaan,
                                                                              onChanged: (sd) {
                                                                                setState(() {});
                                                                                spk.levelPekerjaan = 1;
                                                                              }),
                                                                        ),
                                                                        Positioned(
                                                                          bottom:
                                                                              -4,
                                                                          child:
                                                                              Text(
                                                                            'E',
                                                                            style:
                                                                                small,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      clipBehavior:
                                                                          Clip.none,
                                                                      children: [
                                                                        Transform
                                                                            .scale(
                                                                          scale:
                                                                              0.7,
                                                                          child: Radio(
                                                                              activeColor: Colors.yellow,
                                                                              value: 2,
                                                                              groupValue: spk.levelPekerjaan,
                                                                              onChanged: (sd) {
                                                                                setState(() {});
                                                                                spk.levelPekerjaan = 2;
                                                                              }),
                                                                        ),
                                                                        Positioned(
                                                                          bottom:
                                                                              -4,
                                                                          child:
                                                                              Text(
                                                                            'M',
                                                                            style:
                                                                                small,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      clipBehavior:
                                                                          Clip.none,
                                                                      children: [
                                                                        Transform
                                                                            .scale(
                                                                          scale:
                                                                              0.7,
                                                                          child: Radio(
                                                                              activeColor: Colors.red,
                                                                              value: 3,
                                                                              groupValue: spk.levelPekerjaan,
                                                                              onChanged: (sd) {
                                                                                setState(() {});
                                                                                spk.levelPekerjaan = 3;
                                                                              }),
                                                                        ),
                                                                        Positioned(
                                                                          bottom:
                                                                              -4,
                                                                          child:
                                                                              Text(
                                                                            'H',
                                                                            style:
                                                                                small,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      Kotak(
                                                          width: width4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'SUKU CADANG',
                                                                style: big,
                                                              ),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      maxLines: 5,
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.sukuCadang =
                                                                            v;
                                                                      },
                                                                      initialValue: spk.sukuCadang)),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Kotak(
                                                              width: width5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  23,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Nama Mekanik :',
                                                                    style: med,
                                                                  ),
                                                                  Flexible(
                                                                      child: TextFormField(
                                                                          style: small,
                                                                          onChanged: (v) {
                                                                            setState(() {});
                                                                            spk.namaMekanik =
                                                                                v;
                                                                          },
                                                                          initialValue: spk.namaMekanik)),
                                                                ],
                                                              )),
                                                          Kotak(
                                                              width: width5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  23,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Estimasi Biyaya :',
                                                                    style: med,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          TextFormField(
                                                                    style:
                                                                        small,
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly,
                                                                      CurrencyInputFormatter()
                                                                    ],
                                                                    onChanged:
                                                                        (v) {
                                                                      setState(
                                                                          () {});
                                                                      spk.estimasiBiyaya = NumberFormat.currency(
                                                                              locale: 'id_ID',
                                                                              symbol: 'Rp ')
                                                                          .parse(v)
                                                                          .toDouble();
                                                                    },
                                                                    initialValue: formatCurrendcy
                                                                        .format(
                                                                            spk.estimasiBiyaya)
                                                                        .toString(),
                                                                  )),
                                                                ],
                                                              )),
                                                          Kotak(
                                                              width: width5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  23,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Estimasi Selesai :',
                                                                    style: med,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          TextFormField(
                                                                    onTap:
                                                                        (() async {
                                                                      DateTime? pickedDate = await showDatePicker(
                                                                          builder: (context, child) => Theme(
                                                                                data: Theme.of(context).copyWith(
                                                                                  colorScheme:  ColorScheme.light(
                                                                                    primary: Color.fromARGB(255, 79, 117, 134), // header background color
                                                                                  ),
                                                                                  textButtonTheme: TextButtonThemeData(
                                                                                    style: TextButton.styleFrom(
                                                                                      foregroundColor: Colors.green, // button text color
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: child!,
                                                                              ),
                                                                          locale: Localizations.localeOf(context),
                                                                          context: context,
                                                                          initialDate: DateTime.now(),
                                                                          firstDate: DateTime(2022), //DateTime.now() - not to allow to choose before today.
                                                                          lastDate: DateTime(2101));

                                                                      if (pickedDate !=
                                                                          null) {
                                                                        print(
                                                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                        String
                                                                            formattedDate =
                                                                            DateFormat('dd/MM/yyyy').format(pickedDate);
                                                                        print(
                                                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                        //you can implement different kind of Date Format here according to your requirement

                                                                        setState(
                                                                            () {
                                                                          estimasiSelesaiInput.text =
                                                                              formattedDate; //set output date to TextField value.
                                                                          spk.estimasiSelesai =
                                                                              estimasiSelesaiInput.text;
                                                                        });
                                                                      } else {
                                                                        print(
                                                                            "Date is not selected");
                                                                      }
                                                                    }),
                                                                    style:
                                                                        small,
                                                                    controller:
                                                                        estimasiSelesaiInput,
                                                                  )),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                      Kotak(
                                                          width: width6,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              7.65,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Pemilik Kendaraan',
                                                                style: med,
                                                              ),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.customerName =
                                                                            v;
                                                                      },
                                                                      initialValue:widget.customer.customerName)),
                                                            ],
                                                          )),
                                                      Kotak(
                                                          width: width6,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              7.65,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Service Advisor',
                                                                style: med,
                                                              ),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.namaAdvisor =
                                                                            v;
                                                                      },
                                                                      initialValue: spk.namaAdvisor)),
                                                            ],
                                                          )),
                                                      Kotak(
                                                          width: width6,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              7.65,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Final Inspector',
                                                                style: med,
                                                              ),
                                                              Flexible(
                                                                  child: TextFormField(
                                                                      style: small,
                                                                      onChanged: (v) {
                                                                        setState(
                                                                            () {});
                                                                        spk.namaInspeektor =
                                                                            v;
                                                                      },
                                                                      initialValue: spk.namaInspeektor)),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ])),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                        )),
                  )
                ],
              ))),
      floatingActionButton: Row(children: [ Padding(
            padding: const EdgeInsets.only(left: 100,),
            child: FloatingActionButton( child: const Icon(Icons.arrow_back),onPressed: (){
              Navigator.of(context).pop();
            }),
          ),
         Spacer(),
        Padding(
            padding:  EdgeInsets.all(5),
            child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.blue.shade600,
                child:  Icon(Icons.save_as_rounded),
                onPressed: () {
                  widget.customer.spk.target = Spk(
                    jtId: spk.jtId,
                    customerName: spk.customerName,
                    policeNumber: spk.policeNumber,
                    namaKendaraan: spk.namaKendaraan,
                    date: spk.date,
                    alamat: spk.alamat,
                    analisa: spk.analisa,
                    keluhanKonsumen: spk.keluhanKonsumen,
                    catatan: spk.catatan,
                    namaMekanik: spk.namaMekanik,
                    estimasiBiyaya: spk.estimasiBiyaya,
                    estimasiSelesai: spk.estimasiSelesai,
                    namaAdvisor: spk.namaAdvisor,
                    namaInspeektor: spk.namaInspeektor,
                    jenisPekrjaan: spk.jenisPekrjaan,
                    km: spk.km,
                    levelPekerjaan: spk.levelPekerjaan,
                    noPkb: spk.noPkb,
                    noRangka: spk.noRangka,
                    sukuCadang: spk.sukuCadang,
                    tipeKendaraan: spk.tipeKendaraan,
                  );
                  widget.customer.proses = 'SPK';
                  Provider.of<Trigger>(context, listen: false)
                      .selectCustomer(widget.customer, true);

                  objectBox.insertCustomer(widget.customer);
                })),
        Padding(
            padding:  EdgeInsets.all(5),
            child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.red.shade400,
                child:  Icon(Icons.picture_as_pdf),
                onPressed: () async {
                   ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Loading.....')));

                   widget.customer.spk.target = Spk(
                    jtId: spk.jtId,
                    customerName: spk.customerName,
                    policeNumber: spk.policeNumber,
                    namaKendaraan: spk.namaKendaraan,
                    date: spk.date,
                    alamat: spk.alamat,
                    analisa: spk.analisa,
                    keluhanKonsumen: spk.keluhanKonsumen,
                    catatan: spk.catatan,
                    namaMekanik: spk.namaMekanik,
                    estimasiBiyaya: spk.estimasiBiyaya,
                    estimasiSelesai: spk.estimasiSelesai,
                    namaAdvisor: spk.namaAdvisor,
                    namaInspeektor: spk.namaInspeektor,
                    jenisPekrjaan: spk.jenisPekrjaan,
                    km: spk.km,
                    levelPekerjaan: spk.levelPekerjaan,
                    noPkb: spk.noPkb,
                    noRangka: spk.noRangka,
                    sukuCadang: spk.sukuCadang,
                    tipeKendaraan: spk.tipeKendaraan,
                  );
                  widget.customer.proses = 'SPK';
                  Provider.of<Trigger>(context, listen: false)
                      .selectCustomer(widget.customer, true);

                 
                  final bytes = await controller.capture();
                  await createSpk(bytes!, spk.jtId, context,'SPK');
                   Provider.of<Trigger>(context, listen: false)
                      .selectCustomer(widget.customer, true);

                  objectBox.insertCustomer(widget.customer);
                })),
        Container(
          padding:  EdgeInsets.all(10.0),
          child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.green,
              child:  Icon(Icons.print),
              onPressed: () async{
                final bytes = await controller.capture();
                printPdf(bytes!);
              }),
        )
      ]),
    );
  }
}
