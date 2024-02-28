import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  Future<String> updatePaymentStatus(String email, String paymentStatus) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.183.53:3006/api/member/update'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'emailid': email,
          'paymentStatus': paymentStatus,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'];
      } else {
        throw Exception('Failed to update payment status');
      }
    } catch (error) {
      print('Error: $error');
      throw error.toString();
    }
  }
}
