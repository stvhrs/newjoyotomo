import 'package:newJoyo/models/pelanggan.dart';
import 'package:newJoyo/models/stock.dart';
import 'package:newJoyo/models/pembelian.dart';
import 'package:flutter/cupertino.dart';
import 'package:newJoyo/models/supplier.dart';

import '../models/customer.dart';
import '../objectbox.g.dart';

class ObjectBox extends ChangeNotifier {
  late final Store _store;

  late final Box<Stock> _stockBox;
  late final Box<Supplier> _supplierBox;
  late final Box<Customer> _customerBox;
  late final Box<Pelanggan> _pelangganBox;
  late final Box<Penyuplai> _penyuplaiBox;

  ObjectBox._init(this._store) {
    _stockBox = Box<Stock>(_store);
    _supplierBox = Box<Supplier>(_store);
    _customerBox = Box<Customer>(_store);
    _pelangganBox = Box<Pelanggan>(_store);
    _penyuplaiBox = Box<Penyuplai>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(store);
  }

//Pelanggan
  Stream<List<Pelanggan>> getPelanggan() {
    return _pelangganBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  List<Pelanggan> fetchPelanggan() {
    return _pelangganBox.query().build().find();
  }
    List<Customer> fetchCustomer() {
    return _customerBox.query().build().find();
  }

  int insertPelanggan(Pelanggan pelanggan) => _pelangganBox.put(pelanggan);

  bool deletePelanggan(int id) => _pelangganBox.remove(id);

  //Penyuplai
  Stream<List<Penyuplai>> getPenyuplai() {
    return _penyuplaiBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }
  List<Penyuplai> fetchPenyuplai() {
    return _penyuplaiBox.query().build().find();
  }

  int insertPenyuplai(Penyuplai penyuplai) => _penyuplaiBox.put(penyuplai);

  bool deletePenyuplai(int id) => _penyuplaiBox.remove(id);

  ///Supplier
  Stream<List<Supplier>> getSuppliers() {
    return _supplierBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  int insertSupplier(Supplier stock) => _supplierBox.put(stock);

  bool deleteSupplier(int id) => _supplierBox.remove(id);

  deleteAllSupplier() => _supplierBox.removeAll();
  deleteAllStock() => _stockBox.removeAll();

  ///Stock
  Stream<List<Stock>> getStocks() {
    return _stockBox
        .query(Stock_.name.startsWith(''))
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  int insertStock(Stock stock) => _stockBox.put(stock);

  bool deleteStock(int id) => _stockBox.remove(id);

  ///Customer
  Stream<List<Customer>> getCustomers() {
    return _customerBox
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  int insertCustomer(Customer customer) => _customerBox.put(customer);

  bool deleteCustomer(int id) => _customerBox.remove(id);
}
