import 'package:hive/hive.dart';
part 'splash_token_hive.g.dart';

@HiveType(typeId: 0)
class SplashTokenHiveDb {
  SplashTokenHiveDb({
    required this.token,
    required this.name,
  });

  @HiveField(0)
  String? token;

  @HiveField(1)
  String? name;
}
