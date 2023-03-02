import 'package:new_tablet/models/login_model.dart';
import 'package:new_tablet/models/user_configs_model.dart';
import 'package:new_tablet/services/api_service.dart';
import 'package:new_tablet/services/database_service.dart';
import 'package:new_tablet/utils/utils.dart';

class LoginService {
  DatabaseHelper dbHelper = new DatabaseHelper();
  String tableName = 'USER';
  Map<String, dynamic> columns = {};
  List<dynamic> filters = [];

  login(account, username, password) async {
    APIService apiService = new APIService();

    LoginResponseModel response = await apiService.login(LoginRequestModel(
        account: account, username: username, password: password));

    print(response.token);

    // dbHelper.tableName = 'USER';
    // dbHelper.columns = {
    //   "account": account,
    //   "username": username,
    //   "password": password,
    //   "token": response.token,
    // };
    // await dbHelper.saveTableData(
    //     [UserConfigsModel(account, username, password, response.token!)]);

    return response;
  }

  getUserData() async {
    dbHelper.tableName = 'USER';
    return dbHelper.getTableData();
  }
}
