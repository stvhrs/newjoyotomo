import 'package:objectbox/objectbox.dart';


@Entity()
class ManualService {
  @Id(assignable: true)
  int id;
  String invId;
  double partTotal;
  double serviceTotal;
  double ManualServiceTotal;
  String ManualServiceDate;
  String soDate;
  

  ManualService({
    this.id = 0,
    required this.invId,
    
    this.partTotal=0,
    this.ManualServiceDate='',
    this.serviceTotal=0,
    this.ManualServiceTotal=0,
    this.soDate=''
    // required this.rincianPembayaran,
  });
}
