import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newJoyo/models/pelanggan.dart';
import 'package:newJoyo/models/supplier.dart';
import 'package:newJoyo/widgets/Pelanggan/tambah_Pelanggan.dart';
import 'package:newJoyo/widgets/pelanggan/edit_pelanggan.dart';

import '../main.dart';

class DaftarPelanggan extends StatefulWidget {
  const DaftarPelanggan({super.key});

  @override
  State<DaftarPelanggan> createState() => _DaftarPelangganState();
}

class _DaftarPelangganState extends State<DaftarPelanggan> {
  late Stream<List<Pelanggan>> _streamPelanggan;
  final int _currentIndex = 0;

  String _search = '';

  @override
  void initState() {
    _streamPelanggan = objectBox.getPelanggan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          padding: EdgeInsets.only(left: 25, right: 25, top: 15),
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              spreadRadius: 3,
              offset: Offset(2, 2),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              Text(
                'Daftar Pelanggan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 6,
                      padding:
                          const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                      height: 50,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 0),
                              child: TextFormField(
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        // _streamdaftar =
                                        //     objectBox.getdaftar(
                                        //         val.toString());
                                        _search = val.toString();
                                        // }
                                      },
                                    );
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Cari Nama',
                                  ))))),
                  TambahPelanggan()
                ],
              ),
              Container(
                color: Colors.grey.shade300,
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 11, child: Text('Nama')),
                    Expanded(flex: 11, child: Text('Alamat')),
                    Expanded(flex: 11, child: Text('Nomor Hp')),
                    Expanded(flex: 3, child: Text('       Aksi'))
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder(
                  stream: _streamPelanggan,
                  builder: (context, AsyncSnapshot<List<Pelanggan>> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    List<Pelanggan> daftar = [];

                    if (_search != '') {
                      for (Pelanggan element in snapshot.data!) {
                        if (element.namaPelanggan
                            .toLowerCase()
                            .startsWith(_search.toLowerCase())) {
                          daftar.add(element);
                        }
                      }
                    } else {
                      daftar = snapshot.data!.reversed.toList();
                      // daftar.sort((a, b) => b.date.compareTo(a.date));
                    }
                    return ListView.builder(
                      itemCount: daftar.length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          color: index.isEven
                              ? const Color.fromARGB(255, 193, 216, 226)
                              : Colors.transparent,
                          padding: EdgeInsets.only(left: 15, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(daftar[index].namaPelanggan)),
                              Expanded(
                                  flex: 3, child: Text(daftar[index].alamat)),
                              Expanded(
                                  flex: 3, child: Text(daftar[index].nomorHp)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EditPelanggan(daftar[index]),
                                    IconButton(
                                        onPressed: () {
                                          objectBox.deletePelanggan(
                                              daftar[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 16,
                                          color: Colors.red.shade700,
                                        )),
                                    Spacer(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ))
    ]);
  }
}
