import 'package:newJoyo/models/customer.dart';
import 'package:newJoyo/models/payment.dart';
import 'package:newJoyo/models/mpi/mpiItem.dart';
import 'package:newJoyo/models/realization.dart';
import 'package:newJoyo/models/spk.dart';
import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:flutter/material.dart';
import 'package:newJoyo/models/supplier.dart';

import '../../main.dart';
import '../../models/invoice.dart';
import '../../models/mpi.dart';

class EdithPenyuplai extends StatefulWidget {
  final Penyuplai penyuplai;
  EdithPenyuplai(this.penyuplai);

  @override
  State<EdithPenyuplai> createState() => _EdithPenyuplaiState();
}

class _EdithPenyuplaiState extends State<EdithPenyuplai> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String namaSupplier = '';
    String noHp = '';
    String alamat = '';

    return IconButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 79, 117, 134))),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                title: const Text("Edit Supplier"),
                content: IntrinsicHeight(
                  child: SizedBox(
                    width: 500,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            initialValue: widget.penyuplai.namaPenyuplai,
                            decoration: const InputDecoration(
                              hintText: 'Nama Supplier',
                            ),
                            onChanged: (val) {
                              
                              namaSupplier = val.toString();
                            setState(() {});
                            },
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                              initialValue: widget.penyuplai.nomorHp,
                              onChanged: (val) {
                                
                                noHp = val.toString();
                              setState(() {});
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Nomor Hp',
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
                              initialValue: widget.penyuplai.alamat,
                              onChanged: (val) {
                                
                                alamat = val.toString();
                              setState(() {});
                              },
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Alamat',
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
                      // if ((namaSupplier.isNotEmpty || noHp.isNotEmpty)) {
                      widget.penyuplai.namaPenyuplai = namaSupplier;
                      widget.penyuplai.date =
                          DateTime.now().microsecondsSinceEpoch;
                      widget.penyuplai.alamat = alamat;
                      widget.penyuplai.nomorHp=noHp;  
                      objectBox.insertPenyuplai(widget.penyuplai);
                      Navigator.of(context).pop();
                    },
                    // },
                    child: const Text("Edit Supplier"),
                  ),
                ],
              );
            });
      },
      icon: const Icon(
        Icons.edit,
        size: 16,
        color: Colors.green,
      ),
    );
  }
}
