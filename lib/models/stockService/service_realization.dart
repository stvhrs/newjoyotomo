import 'package:newJoyo/models/stock.dart';

import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceRealization {
  @Id(assignable: true)
  int id;
  String remark;

  String partName;

  double servicePrice;
  double repairPrice;
  bool done;
  ServiceRealization(
      {this.id = 0,
      this.remark = 'Remark',
      this.partName = 'Part Name',
      this.repairPrice = 0.0,
      this.servicePrice = 0,
      this.done = false

      // required this.ServiceHistory,
      });
  // factory Service.fromMap(Map<String, dynamic> map) {
  //   return Service(
  //     name: map['name'],
  //     desc: map['desc'],
  //     Service: map['Service'],
  //     price: map['price'],
  //     servicePrice: map['servicePrice'],
  //     ServiceHistory: map['ServiceHistory'],
  //   );
  // }
  // static Map<String, dynamic> toMap(Service Service) {
  //   return {
  //     'name': Service.name,
  //     'desc': Service.desc,
  //     'Service': Service.Service,
  //     'price': Service.price,
  //     'servicePrice': Service.servicePrice,
  //     'ServiceHistory': Service.ServiceHistory,
  //   };
  // }
}
