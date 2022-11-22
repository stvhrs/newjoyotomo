import 'package:newJoyo/models/customer.dart';
import 'package:newJoyo/models/payment.dart';
import 'package:newJoyo/models/mpi/mpiItem.dart';
import 'package:newJoyo/models/pelanggan.dart';
import 'package:newJoyo/models/realization.dart';
import 'package:newJoyo/models/rincian_pembayaran.dart';
import 'package:newJoyo/models/spk.dart';
import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:flutter/material.dart';
import 'package:newJoyo/provider/trigger.dart';
import 'package:provider/provider.dart';

import '../../helper/dropdown.dart';
import '../../main.dart';
import '../../models/invoice.dart';
import '../../models/mpi.dart';

class CustomerAdd extends StatefulWidget {
  final int csId;
  const CustomerAdd({Key? key, required this.csId}) : super(key: key);

  @override
  State<CustomerAdd> createState() => _CustomerAddState();
}

class _CustomerAddState extends State<CustomerAdd> {
  @override
  Widget build(BuildContext context) {
    String namaCustomer = '';

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
                  title: const Text("Tambah Customer"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: DropDownField(
                          required: true,
                          onValueChanged: (val) {
                            namaCustomer = val.toString();
                            setState(() {});
                          },
                          strict: true,
                          labelText: 'Customer',
                          items: Provider.of<Trigger>(context, listen: false)
                              .listSelectedPelanggan
                              .map((e) => e.namaPelanggan)
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if ((namaCustomer.isNotEmpty ||
                            Provider.of<Trigger>(context, listen: false)
                                .listSelectedPelanggan
                                .map((e) => e.namaPelanggan)
                                .contains(namaCustomer))) {
                          Pelanggan data =
                              Provider.of<Trigger>(context, listen: false)
                                  .listSelectedPelanggan
                                  .firstWhere((element) =>
                                      element.namaPelanggan == namaCustomer);
                          Customer customer = Customer(
                              dateTime: DateTime.now().toIso8601String(),
                              customerName: namaCustomer,
                              alamat: data.alamat,
                              csId: 'CST/JT/000000'.replaceRange(
                                  13 - widget.csId.toString().length,
                                  13,
                                  widget.csId.toString()));

                          customer.spk.target = Spk(
                            alamat: data.alamat,
                            customerName: data.namaPelanggan,
                            jtId: 'SPK/JT/000000'.replaceRange(
                                13 - widget.csId.toString().length,
                                13,
                                widget.csId.toString()),
                          );
                          customer.mpi.target = Mpi(
                            mpiId: 'MPI/JT/000000'.replaceRange(
                                13 - widget.csId.toString().length,
                                13,
                                widget.csId.toString()),
                          );
                          customer.mpi.target!.items.addAll([
                            MpiItem(
                                category: '1',
                                name: 'FRT Brakes',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: '1',
                                name: 'Rear Breaks',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: '1',
                                name: 'Front Tire Depth',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: '1',
                                name: 'Rear Tire Depth',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: '1',
                                name: 'Tire Pressure',
                                attention: 0,
                                price: 30000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Head Lights',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Front Wiper',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Rear Wiper',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Floor Mats',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Emergency Brake Adjustment',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Horn Operation',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Cabin Air Filter',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'INTERIOR / EXTERIOR',
                                name: 'Clutch Operation',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Suspension - Front',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Suspension - Rear',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Power Steering',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Mountings',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Engine Oil Leaks',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Drive Shaft (CV)',
                                attention: 0,
                                price: 100000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Transmission',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Fuel Lines and Fuel line Connectors',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER VEHICLE',
                                name: 'Inspect Nuts and bolts on Body Chassis',
                                attention: 0,
                                price: 100000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name:
                                    'Fluid Levels: Oil / Coolant / Battery / Brake Fluid',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Engine Air Filter',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Vechicale',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Drive Belts',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Engine Coolant',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Water Hoses',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Radiator Condition',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Battery Condition',
                                attention: 0,
                                price: 25000,
                                remark: ''),
                            MpiItem(
                                category: 'UNDER HOOD ',
                                name: 'Battery Service',
                                attention: 0,
                                price: 50000,
                                remark: ''),
                          ]);
                          customer.realization.target = Realization(
                              rlId: 'RLS/JT/000000'.replaceRange(
                                  13 - widget.csId.toString().length,
                                  13,
                                  widget.csId.toString()),
                              // selesai: DateTime.now().toIso8601String(),
                              // dateOut:  DateTime.now().toIso8601String(),
                              biyaya: 0,
                              done: false);
                          customer.realization.target!.mpiItems !=
                              [
                                MpiItem(
                                    category: 'UNDER VEHICLE',
                                    name: 'Vechicale2',
                                    attention: 1,
                                    price: 100,
                                    remark: '')
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
                            invoiceDate: DateTime.now().toIso8601String(),
                            soDate: DateTime.now().toIso8601String(),
                            invId: 'INV/JT/000000'.replaceRange(
                                13 - widget.csId.toString().length,
                                13,
                                widget.csId.toString()),
                          );
                          customer.rcp.target = RincianPembayarran(
                              rcpId: 'RCP/JT/000000'.replaceRange(
                                  13 - widget.csId.toString().length,
                                  13,
                                  widget.csId.toString()));
                          customer.rcp.target!.payments.add(Payment(
                              date: DateTime.now().toIso8601String(),
                              keterangan: 'Grand Total',
                              saldo: 1,
                              pay: 0));
                          objectBox.insertCustomer(customer);

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Tambah"),
                    ),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Pekerjaan'));
  }
}
