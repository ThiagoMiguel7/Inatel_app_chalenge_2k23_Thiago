import 'dart:io';
import 'package:inatel_app_challenge/data.dart';
import 'package:inatel_app_challenge/socket/socketServiceAbstraction.dart';

class RealSocketService extends SocketService {
  @override
  Future<void> listenData(void Function(List<Data>) listener) async {
    try {
      int port = 50000;
      var socket = await Socket.connect('localhost', port);
      print('Connected to port 50000');
      await for (var data in socket) {
        var rawData = String.fromCharCodes(data);
        rawData = rawData.substring(rawData.indexOf("["), rawData.length);
        print(rawData);
        var dataList = convertStringToListData(rawData);
        listener(dataList);
        print('Received from port 50000: $rawData');
      }
    } catch (e) {
      print('Error in connection to port 50000: $e');
    }
  }
}
