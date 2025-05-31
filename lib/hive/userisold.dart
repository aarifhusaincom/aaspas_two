import 'package:hive/hive.dart';

part 'userisold.g.dart';

@HiveType(typeId: 1)
class userisold {
  @HiveField(0)
  bool isold;
  userisold({this.isold = false});
}
