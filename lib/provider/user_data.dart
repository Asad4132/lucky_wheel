import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserData with ChangeNotifier {
  String? id;
  double? userbalance;

  Future<void> sendAmount(String id, var amount) async {
    final uri = Uri.parse(
        'https://projectabc-eed99-default-rtdb.firebaseio.com/UserDetails/$id.json');

    final response = await http.put(
      uri,
      body: json.encode(
        {
          'amount': amount,
        },
      ),
    );
    userbalance = amount;
    print(response.body);
    notifyListeners();
  }

  Future<void> fetchAndSetAmount(String id) async {
    final uri = Uri.parse(
        'https://projectabc-eed99-default-rtdb.firebaseio.com/UserDetails/$id.json');

    try {
      final response = await http.get(uri);
      userbalance = json.decode(response.body)['amount'];

      print('your recover amount is $userbalance');
      notifyListeners();
    } catch (e) {
      print('An Error Occur');
      userbalance = 0;
    }
  }
}
