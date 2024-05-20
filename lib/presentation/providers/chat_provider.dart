import 'package:flutter/material.dart';
import 'package:yes_no_app_course/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app_course/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswr();

  List<Message> messageList = [
    Message(text: 'Hola amor', fromWho: FromWho.mine),
    Message(text: 'Ya regresaste del trabajo', fromWho: FromWho.mine)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.mine);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners();
    moveScrollToButtom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAndAnswer();
    messageList.add(herMessage);
    notifyListeners();

    moveScrollToButtom();
  }

  void moveScrollToButtom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
