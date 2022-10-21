import 'package:objectbox/objectbox.dart';

@Entity()
class SupplierHistory {
  @Id(assignable: true)
  int id;
  String partName;
  String name;

  int count;
  double price;
  double totalPrice;

  SupplierHistory({
    this.id = 0,
    required this.name,
    required this.partName,
    required this.count,
    required this.price,
    required this.totalPrice,
  });
}
