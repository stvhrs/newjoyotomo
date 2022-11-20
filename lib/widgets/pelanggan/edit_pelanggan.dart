import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/pelanggan.dart';

class EditPelanggan extends StatefulWidget {
  final Pelanggan pelanggan;
  EditPelanggan(this.pelanggan);

  @override
  State<EditPelanggan> createState() => _EditPelangganState();
}

String namaPelanggan = '';
String noHp = '';
String alamat = '';

class _EditPelangganState extends State<EditPelanggan> {
  @override
  void initState() {
    super.initState();
    namaPelanggan = widget.pelanggan.namaPelanggan;
    noHp = widget.pelanggan.nomorHp;
    alamat = widget.pelanggan.alamat;
  }

  @override
  Widget build(BuildContext context) {
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
                title: const Text("Edit Pelanggan"),
                content: IntrinsicHeight(
                  child: SizedBox(
                    width: 500,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            initialValue: widget.pelanggan.namaPelanggan,
                            decoration: const InputDecoration(
                              hintText: 'Nama Pelanggan',
                            ),
                            onChanged: (val) {
                              namaPelanggan = val.toString();
                            },
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                              initialValue: widget.pelanggan.nomorHp,
                              onChanged: (val) {
                                noHp = val.toString();
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
                              initialValue: widget.pelanggan.alamat,
                              onChanged: (val) {
                                alamat = val.toString();
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
                      widget.pelanggan.namaPelanggan = namaPelanggan;
                      widget.pelanggan.date =
                          DateTime.now().microsecondsSinceEpoch;
                      widget.pelanggan.alamat = alamat;
                      widget.pelanggan.nomorHp = noHp;
                      objectBox.insertPelanggan(widget.pelanggan);
                      Navigator.of(context).pop();
                    },
                    // },
                    child: const Text("Edit Pelanggan"),
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
