import 'package:newJoyo/models/payment.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class RincianPembayarran {
  @Id(assignable: true)
  int id;
  String rcpId;
  double saldo;

  ToMany<Payment> payments = ToMany<Payment>();

  RincianPembayarran({
    this.id = 0,
   this.rcpId='',
    this.saldo = 1,
  });
}
