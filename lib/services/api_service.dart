import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'dart:convert';

import 'package:new_tablet/models/login_model.dart';
import 'package:new_tablet/utils/constants.dart';
import 'package:new_tablet/utils/utils.dart';

class APIService {
  Future<LoginResponseModel> login(requestModel) async {
    var url = '${serverUrl}/${requestModel.account}/login';
    final response = await http.post(Uri.parse(url),
        headers: loginHeaders,
        body: json.encode({
          'password': requestModel.password,
          'stationId': "695141687132171",
          'user': requestModel.username,
        }));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        utils.account = requestModel.account;
        utils.username = requestModel.username;
        utils.token = json.decode(response.body)['token'];
        return LoginResponseModel.fromJson(
          json.decode(response.body),
        );
      }
    } else {
      return Future.error(json.decode(response.body).isNotEmpty()
          ? json.decode(response.body)['message']
          : 'Error while logging in');
    }

    return LoginResponseModel();
  }

  Future<bool> getIsAlive() async {
    var url = '${serverUrl}/isAlive';
    final response = await http.post(
      Uri.parse(url),
      headers: loginHeaders,
    );

    if (response.statusCode != 200) {
      return false;
    }

    return true;
  }

//   static Future<dynamic> logout() async {
//     var url = '${serverUrl}/${utils.account}/logout';
//     final response = await http
//         .post(Uri.parse(url), headers: {...headers, 'bsn-token': utils.token});
//     if (response.statusCode != 200) {
//       return Future.error(json.decode(response.body).isNotEmpty()
//           ? json.decode(response.body)['message']
//           : 'Error while logging in');
//     }
//   }

//   static Future<List<ReportModel>> getDynamicReport(
//       reportName, searchStr) async {
//     List<ReportModel> items = [];
//     final response = await http.get(
//       Uri.parse(
//           '${serverUrl}/${utils.account}/REPORT/${reportName}?search=${searchStr}'),
//       headers: {...headers, 'bsn-token': utils.token},
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> parsedJson =
//           jsonDecode(utf8.decode(response.bodyBytes))['rows'];

//       for (var item in parsedJson) {
//         Map<String, dynamic> map = item;
//         items.add(ReportModel.fromJson(map));
//       }

//       return items;
//     } else {
//       return Future.error(json.decode(response.body).isNotEmpty()
//           ? json.decode(response.body)['message']
//           : 'Error while fetching');
//     }
//   }

//   static Future<List<Document>> getDocuments(types, fields) async {
//     List<Document> items = [];
//     try {
//       for (var type in types) {
//         final response = await http.get(
//           Uri.parse(
//               '${serverUrl}/${utils.account}/${type}?fields=${fields.join(',')}'),
//           headers: {...headers, 'bsn-token': utils.token},
//         );
//         if (response.statusCode == 200) {
//           List<dynamic> parsedJson =
//               jsonDecode(utf8.decode(response.bodyBytes))['rows'];

//           for (var item in parsedJson) {
//             Map<String, dynamic> map = item;
//             var obj = Document.fromJson(map);
//             obj.type = type;
//             items.add(obj);
//           }
//         } else {
//           return Future.error(json.decode(response.body).isNotEmpty()
//               ? json.decode(response.body)['message']
//               : 'Error while fetching');
//         }
//       }

//       items.sort((a, b) => (Jiffy(a.docDate, 'dd/MM/yyyy').dateTime)
//           .compareTo(Jiffy(b.docDate, 'dd/MM/yyyy').dateTime));
//       return items;
//     } catch (e) {
//       print(e);
//     }
//   }

//   static getDocument(String type, String code, List<String> fields) async {
//     SalesOrderDocument document = new SalesOrderDocument();
//     final response = await http.get(
//       Uri.parse(
//           '${serverUrl}/${utils.account}/${type}?fields=${fields.join(',')}&search=code:${code}'),
//       headers: {...headers, 'bsn-token': utils.token},
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> parsedJson =
//           jsonDecode(utf8.decode(response.bodyBytes))['rows'];

//       for (var item in parsedJson) {
//         Map<String, dynamic> map = item;
//         document = SalesOrderDocument.fromJson(map);
//       }

//       return document;
//     } else {
//       return Future.error(json.decode(response.body).isNotEmpty()
//           ? json.decode(response.body)['message']
//           : 'Error while fetching');
//     }
//   }

  static Future<dynamic> getLocalizationStrings(fields) async {
    List<dynamic> items = [];

    final response = await http.get(
      Uri.parse(
          '${serverUrl}/${utils.account}/localizeStrings?keys=${fields.join(',')}'),
      headers: {...headers, 'bsn-token': utils.token},
    );

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(
          jsonDecode(utf8.decode(response.bodyBytes))['values']);
    } else {
      return Future.error(json.decode(response.body).isNotEmpty
          ? json.decode(response.body)['message']
          : 'Error while fetching');
    }
  }

  // get(String s) {}

  Future get<T>(apiTable) async {
    try {
      final response = await http.get(
        Uri.parse('${serverUrl}/${utils.account}/${apiTable}'),
        headers: {...headers, 'bsn-token': utils.token},
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return parsed;
      } else {
        throw <T>{};
      }
    } catch (e) {
      return e;
    }
  }
}

class ApiBaseHelper {
  Future<T> get<T>(apiTable, fields) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${serverUrl}/${utils.account}/${apiTable}?fields=${fields.join(',')}'),
        headers: {...headers, 'bsn-token': utils.token},
      );
      return _returnResponse(response);
    } on SocketException catch (exception) {
      throw FetchDataException('No Internet connection' + exception.message);
    }
  }

  Future<T> post<T>(apiTable, body) async {
    try {
      final response = await http.post(
        Uri.parse('${serverUrl}/${utils.account}/${apiTable}'),
        headers: {...headers, 'bsn-token': utils.token},
        body: jsonEncode(body),
      );
      return _returnResponse(response);
    } on SocketException catch (exception) {
      throw FetchDataException('No Internet connection' + exception.message);
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
      case 401:
      case 403:
        return json.decode(response.body.toString());
      case 404:
        return json.decode(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}
