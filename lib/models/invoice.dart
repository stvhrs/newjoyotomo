import 'package:newJoyo/models/realization.dart';
import 'package:objectbox/objectbox.dart';

import 'invoice/payment.dart';

@Entity()
class Invoice {
  @Id(assignable: true)
  int id;
  String invId;
  double saldo;
  ToOne<Realization> realization = ToOne<Realization>();
    ToMany<Payment> payments = ToMany<Payment>();
//  Map<String,dynamic> rincianPembayaran;
  Invoice({
    this.id = 0,
    required this.invId,
    required this.saldo,
    // required this.rincianPembayaran,
  });
}
