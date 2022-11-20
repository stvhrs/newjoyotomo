import 'package:flutter/material.dart';
import 'package:newJoyo/models/supplier.dart';
import 'package:newJoyo/widgets/penyuplai/edit_penyuplai.dart';
import 'package:newJoyo/widgets/penyuplai/tambah_penyuplai.dart';

import '../main.dart';

class DaftarSupplier extends StatefulWidget {
  const DaftarSupplier({super.key});

  @override
  State<DaftarSupplier> createState() => _DaftarSupplierState();
}

class _DaftarSupplierState extends State<DaftarSupplier> {
  late Stream<List<Penyuplai>> _streamPenyuplai;
  final int _currentIndex = 0;

  String _search = '';

  @override
  void initState() {
    _streamPenyuplai = objectBox.getPenyuplai();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(decoration:  BoxDecoration(boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              spreadRadius: 3,
              offset: Offset(2, 2),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
        
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              const Text(
                'Daftar Supplier',
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
                  TambahPenyuplai()
                ],
              ),
              Container(
                color: Colors.grey.shade300,
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
                  stream: _streamPenyuplai,
                  builder: (context, AsyncSnapshot<List<Penyuplai>> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    List<Penyuplai> daftar = [];

                    if (_search != '') {
                      for (Penyuplai element in snapshot.data!) {
                        if (element.namaPenyuplai
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
                          padding: const EdgeInsets.only(left: 15, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(daftar[index].namaPenyuplai)),
                              Expanded(
                                  flex: 3, child: Text(daftar[index].alamat)),
                              Expanded(
                                  flex: 3, child: Text(daftar[index].nomorHp)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EdithPenyuplai(daftar[index]),
                                    IconButton(
                                        onPressed: () {
                                          objectBox.deletePenyuplai(
                                              daftar[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 16,
                                          color: Colors.red.shade700,
                                        )),
                                    const Spacer(),
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
