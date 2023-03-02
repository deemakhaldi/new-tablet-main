import 'package:get_it/get_it.dart';
import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/services/contacts_service.dart';
import 'package:new_tablet/services/database_service.dart';
import 'package:new_tablet/services/entity_service.dart';
import 'package:new_tablet/services/items_service.dart';
import 'package:new_tablet/services/login_service.dart';
import 'package:new_tablet/services/shared_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<ItemsService>(() => ItemsService());
  locator.registerLazySingleton<ContactsService>(() => ContactsService());
  locator.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelper());
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<EntityService>(() => EntityService());
  locator.registerLazySingleton<LoginService>(() => LoginService());
    locator.registerLazySingleton<SharedService>(() => SharedService());


}
