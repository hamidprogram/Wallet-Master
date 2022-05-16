import 'package:hive/hive.dart';

part 'Cards.g.dart';

@HiveType(typeId: 2)
class Cardd{

  @HiveField(0)
  String numbercard;

  @HiveField(1)
  String cvvcard;

  @HiveField(2)
  String datecard;

  @HiveField(3)
  String namecard;

  Cardd(this.numbercard,this.cvvcard,this.datecard,this.namecard);
}