import 'package:dio/dio.dart';
import 'package:yes_no_app_course/infrastructure/models/yes_no_model.dart';

import '../../domain/entities/message.dart';

class GetYesNoAnswr {
  final _dio = Dio();

  Future<Message> getAndAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final yesnoModel = YesNoModel.fromJson(response.data);

    return yesnoModel.toMessageEntity();
  }
}
