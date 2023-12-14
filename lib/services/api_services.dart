import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatscape/constants/api_consts.dart';
import 'package:chatscape/models/models_model.dart';
import 'package:http/http.dart' as http;

import '../models/chat_model.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"), headers: {
        "Authorization": "Bearer $API_KEY",
      });

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        //print("jsonResponse['error']${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse["error"]["message"]);
      }
      //print(jsonResponse);
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        log("temp $value");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Send Message fct
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
            "temperature": 0
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        //print("jsonResponse['error']${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        //log("jsonResponse['choices']text ${jsonResponse['choices'][0]['text']}");
        chatList = List.generate(
            jsonResponse['choices'].length,
            (index) => ChatModel(
                chatIndex: 1, msg: jsonResponse['choices'][index]['text']));
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
