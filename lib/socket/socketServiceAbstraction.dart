import 'package:inatel_app_challenge/data.dart';
import 'dart:convert';

abstract class SocketService {
  Future<void> listenData(void Function(List<Data>) listener);

  List<Data> convertStringToListData(String rawData) {
    List<dynamic> rawList = jsonDecode(rawData);
    return rawList.map((rawItem) => Data.fromJson(rawItem)).toList();
  }
}
