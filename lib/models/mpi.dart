import 'package:objectbox/objectbox.dart';

import 'mpi/mpiItem.dart';

@Entity()
class Mpi {
  @Id(assignable: true)
  int id;
  String mpiId;
ToMany<MpiItem >items =ToMany<MpiItem>();

  Mpi({
    this.id = 0,
    required this.mpiId,
    // required this.ftrBrakes,
  });
  
}
