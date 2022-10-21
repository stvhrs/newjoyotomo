import 'package:newJoyo/models/supplier_history.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Supplier {
  @Id(assignable: true)
  int id;
  String supplier;
  final items = ToMany<SupplierHistory>();
  String desc;
  int count;
  String date;
  double totalPrice;

  Supplier({
    this.id = 0,
    required this.date,
    required this.supplier,
    required this.desc,
    required this.count,
    required this.totalPrice,
  });
}
