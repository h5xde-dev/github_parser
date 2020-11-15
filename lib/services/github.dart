import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Github {
  static final reposPerPage = 30;

  static Future<List> getRepos({int page = 1}) async {
    List repos = [];

    final String fromId = (page == 1) ? '0' : (page * reposPerPage).toString();

    final String apiUrl =
        "https://api.github.com/repositories" + '?since=' + fromId;

    /* String username = 'test';
    String password = '123£';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password')); */

    var response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      if (data.length != 0) {
        int numberInList = 1;

        for (Map item in data) {
          if (numberInList <= reposPerPage) {
            repos.add(item);
          }

          numberInList++;
        }
      }
    }

    return repos;
  }

  static Future<Map> getInfo(String fullName) async {
    Map repo = {};

    final String apiUrl = 'https://api.github.com/repos/' + fullName;

    var response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      if (data.length != 0) {
        repo = data;
      }
    }

    return repo;
  }
}
