import 'package:newJoyo/models/customer.dart';
import 'package:newJoyo/models/invoice/payment.dart';
import 'package:newJoyo/models/mpi/mpiItem.dart';
import 'package:newJoyo/models/realization.dart';
import 'package:newJoyo/models/spk.dart';
import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/invoice.dart';
import '../../models/mpi.dart';

class CustomerAdd extends StatelessWidget {
  final int csId;
  const CustomerAdd({Key? key, required this.csId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String namaCustomer = '';
    String nomorPolisi = '';
    String alamat = '';
    String namaKendaraan = '';

    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 79, 117, 134))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: const Text("Insert Customer"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Nama Customer',
                              ),
                              onChanged: (val) {
                                namaCustomer = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                                onChanged: (val) {
                                  nomorPolisi = val.toString();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Nomor Polisi',
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
                                  namaKendaraan = val.toString();
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Nama Kendaraan',
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
                        if ((namaCustomer.isNotEmpty ||
                            nomorPolisi.isNotEmpty ||
                            namaKendaraan.isNotEmpty)) {
                          Customer customer = Customer(
                              alamat: alamat,
                              customerName: namaCustomer,
                              policeNumber: nomorPolisi,
                              namaKendaraan: namaKendaraan,
                              csId: 'CST/JT/000000'.replaceRange(
                                  13 - csId.toString().length,
                                  13,
                                  csId.toString()));

                          customer.spk.target = Spk(policeNumber: nomorPolisi,
                            jtId: 'SPK/JT/000000'.replaceRange(
                                13 - csId.toString().length,
                                13,
                                csId.toString()),
                          );
                          customer.mpi.target = Mpi(
                            mpiId: 'MPI/JT/000000'.replaceRange(
                                13 - csId.toString().length,
                                13,
                                csId.toString()),
                          );
                          customer.mpi.target!.items.addAll([
                            MpiItem(
                                category: '1',
                                name: 'FRT Brakes',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: '1',
                                name: 'Rear Breaks',
                                attention: 0,
                                price: 0,
                                remark: 'Alignment'),
                            MpiItem(
                                category: '1',
                                name: 'Front Tire Depth',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: '1',
                                name: 'Rear Tire Depth',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: '1',
                                name: 'Tire Pressure',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Head Lights',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Front Wiper',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Rear Wiper',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Floor Mats',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Emergency Brake Adjustment',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Horn Operation',
                                attention: 0,
                                price: 0,
                                remark: 'INTERIOR / EXTERIOR'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Cabin Air Filter',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Clutch Operation',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Suspension - Front',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Suspension - Rear',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Power Steering',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Mountings',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Engine Oil Leaks',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Drive Shaft (CV)',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Transmission',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Fuel Lines and Fuel line Connectors',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Inspect Nuts and bolts on Body Chassis',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name:
                                    'Fluid Levels: Oil / Coolant / Battery / Brake Fluid',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Engine Air Filter',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Vechicale',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Drive Belts',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Engine Coolant',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Water Hoses',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Radiator Condition',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Battery Condition',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Battery Service',
                                attention: 0,
                                price: 0,
                                remark: 'remark'),
                          ]);
                          customer.realization.target = Realization(
                              rlId: 'RLS/JT/000000'.replaceRange(
                                  13 - csId.toString().length,
                                  13,
                                  csId.toString()),
                              selesai: 0,
                              biyaya: 0,
                              done: false);
                          customer.realization.target!.mpiItems !=
                              [
                                MpiItem(
                                    category: 'UNDER VEHICLE',
                                    name: 'Vechicale2',
                                    attention: 1,
                                    price: 100,
                                    remark: 'remark')
                              ];
                          customer.realization.target!.stockItems !=
                              [
                                StockRalization(
                                    partname: 'etst',
                                    name: 'name',
                                    desc: ' desc',
                                    price: 1000,
                                    count: 3,
                                    servicePrice: 100,
                                    toalPrice: 1100)
                              ];
                          customer.inv.target = Invoice(
                              invId: 'INV/JT/000000'.replaceRange(
                                  13 - csId.toString().length,
                                  13,
                                  csId.toString()),
                              saldo: 0);
                          customer.inv.target!.realization =
                              customer.realization;
                          customer.inv.target!.payments.add(Payment(
                              pay: 133,
                              name: 'name',
                              date: ' date',
                              keterangan: 'keterangan'));
                          objectBox.insertCustomer(customer);

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Insert"),
                    ),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'));
  }
}
