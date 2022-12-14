import 'package:newJoyo/models/mpi/mpiItem.dart';
import 'package:newJoyo/models/stockService/service_realization.dart';
import 'package:newJoyo/models/stockService/stock_realization.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Realization {
  @Id(assignable: true)
  int id;
  String rlId;
  String selesai;
  double biyaya;
  String dateOut;
  final mpiItems=ToMany<MpiItem>();
  final stockItems=ToMany<StockRalization>();
  final serviceItems=ToMany<ServiceRealization>();
  bool done;


  Realization({
    this.id = 0,
    required this.rlId,
    this.dateOut='DD/MM/YYYY',
     this.selesai='DD/MM/YYYY',
     this.biyaya=0,
    this.done=false,

  });
}
