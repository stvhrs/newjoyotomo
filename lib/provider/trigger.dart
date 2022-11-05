import 'package:newJoyo/models/pelanggan.dart';
import 'package:newJoyo/models/pembelian.dart';
import 'package:flutter/cupertino.dart';
import 'package:newJoyo/models/supplier.dart';

import '../models/customer.dart';
import '../models/stock.dart';

class Trigger extends ChangeNotifier {
  List<Stock> listSelectedStock = [];
  List<Supplier> listSelectedSupplier = [];
  List<Customer> listSelectedCustomer = [];
    List<Pelanggan> listSelectedPelanggan = [];
  List<Penyuplai> listSelectedPenyuplai = [];

  
  late Stock selectedStock;
  late Supplier selectedSupplier;
  late Customer selectedCustomer;
  
  selectCustomer(Customer customer, bool listen) {
    selectedCustomer = customer;
    if (listen) notifyListeners();
  }

  selectListCustomer(List<Customer> customers, bool listen) {
    listSelectedCustomer = customers;
    if (listen) notifyListeners();
  }

  selectSupplier(Supplier supplier, bool listen) {
    selectedSupplier = supplier;

    if (listen) notifyListeners();
  }

  selectListSupplier(List<Supplier> suppliers, bool listen) {
    listSelectedSupplier = suppliers;
    if (listen) notifyListeners();
  }

  selectStock(Stock stock, bool listen) {
    selectedStock = stock;
    if (listen) notifyListeners();
  }

  selectListStock(List<Stock> stocks, bool listen) {
    listSelectedStock = stocks;
    if (listen) notifyListeners();
  }
  selectListPenyuplai(List<Penyuplai> penyuplais, bool listen) {
    
    listSelectedPenyuplai = penyuplais;
    if (listen) notifyListeners();
  }
   selectListPelanggan(List<Pelanggan> pelanggans, bool listen) {
    listSelectedPelanggan = pelanggans;
    if (listen) notifyListeners();
  }
}
