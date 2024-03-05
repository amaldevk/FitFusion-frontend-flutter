//
//
// static Future<List<NotificationModel>> getNotifications(int batchId) async {
// try {
// await initSharedPref();
//
// var token = prefs?.getString('token') ?? '';
//
//
// if (token.isEmpty || batchId == 0) {
// throw Exception("Token or batchId not available.");
// } else {
// var reqbody = {"batchId": batchId.toString()};
//
// var response = await http.post(
// Uri.parse(FacultyNotificationUrl),
// headers: {"Content-Type": "application/json", "token": token},
// body: jsonEncode(reqbody),
// );
//
// if (response.statusCode == 200) {
// var jsonResponse = jsonDecode(response.body);
// print(response.body);
// // Check the structure of the API response
// if (jsonResponse is Map<String, dynamic>) {
// if (jsonResponse.containsKey('status') &&
// jsonResponse['status'] == 'No notifications found!') {
// // Handle case when no notifications are found
// return [];
// } else if (jsonResponse.containsKey('data')) {
// // Process the notifications as usual
// var notificationList = List<NotificationModel>.from(jsonResponse['data']
//     .map((notificationData) => NotificationModel.fromJson(notificationData)));
// return notificationList;
// } else {
// throw Exception("Invalid API response structure.");
// }
// } else {
// throw Exception("Invalid API response type.");
// }
// } else {
// // Handle error response
// throw Exception(
// "Failed to get notifications. Status Code: ${response.statusCode}");
// }
// }
// } catch (e) {
// throw Exception(e.toString());
// }
// }