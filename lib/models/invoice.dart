import 'package:newJoyo/models/realization.dart';
import 'package:objectbox/objectbox.dart';

import 'invoice/payment.dart';

@Entity()
class Invoice {
  @Id(assignable: true)
  int id;
  String invId;
  double saldo;
  double partTotal;
  double serviceTotal;
  double invoiceTotal;
  String invoiceDate;
  String soDate;
  
 
    ToMany<Payment> payments = ToMany<Payment>();

  Invoice({
    this.id = 0,
    required this.invId,
    required this.saldo,
    this.partTotal=0,
    this.invoiceDate='',
    this.serviceTotal=0,
    this.invoiceTotal=0,
    this.soDate=''
    // required this.rincianPembayaran,
  });
}
