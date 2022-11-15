import 'package:newJoyo/models/realization.dart';
import 'package:objectbox/objectbox.dart';

import 'payment.dart';

@Entity()
class Invoice {
  @Id(assignable: true)
  int id;
  String invId;

  double partTotal;
  double serviceTotal;
  double invoiceTotal;
  String invoiceDate;
  String soDate;
  

  Invoice({
    this.id = 0,
    required this.invId,
    
    this.partTotal=0,
    this.invoiceDate='',
    this.serviceTotal=0,
    this.invoiceTotal=0,
    this.soDate=''
    // required this.rincianPembayaran,
  });
}
