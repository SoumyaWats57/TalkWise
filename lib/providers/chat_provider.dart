//import 'dart:js_util';

import 'package:chatscape/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(
      ChatModel(chatIndex: 0, msg: msg),
    );
    notifyListeners();
  }

  Future<void> sendMessageAnswers(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(await ApiServices.sendMessage(
      message: msg,
      modelId: chosenModelId,
    ));
    notifyListeners();
  }
}
