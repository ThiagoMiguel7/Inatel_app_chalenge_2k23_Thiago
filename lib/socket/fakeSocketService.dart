import 'package:inatel_app_challenge/data.dart';
import 'package:inatel_app_challenge/socket/socketServiceAbstraction.dart';
import 'dart:math';
import 'dart:convert';

class FakeSocketService extends SocketService {
  List<RawData> rawData = [
    RawData("0001", 'Teams.exe', '192.168.234.12'),
    RawData("0002", 'Spotify.exe', '226.111.234.14'),
    RawData("0003", 'Github.exe', '111.222.333.94')
  ];

  @override
  Future<void> listenData(void Function(List<Data>) listener) async {
    try {
      var socket = _connectFakeSocket();
      await for (String data in socket) {
        var dataList = convertStringToListData(data);
        listener(dataList);
      }
    } catch (e) {
      print("Error on connecting: $e");
    }
  }

  Stream<String> _connectFakeSocket() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      List<Map<String, dynamic>> rawList = [];
      for (RawData data in rawData) {
        rawList.add(data.getRawData());
      }
      String jsonString = jsonEncode(rawList);
      yield jsonString;
    }
  }
}

class RandomService {
  final Random _rnd = Random();
  String getRandomDouble(
      {double start = 1, double end = 10, int decimalPlaces = 2}) {
    double randomValue = start + _rnd.nextDouble() * (end - start);
    return randomValue.toStringAsFixed(decimalPlaces);
  }
}

class RawData {
  String pid;
  String name;
  String host;
  final RandomService random = RandomService();

  RawData(this.pid, this.name, this.host);

  Map<String, dynamic> getRawData() {
    return {
      'pid': pid,
      'name': name,
      'upload': '${random.getRandomDouble(start: 0, end: 10)}KB',
      'download': '${random.getRandomDouble(start: 0, end: 10)}KB',
      'upload_speed': '${random.getRandomDouble(start: 0, end: 100)}B/s',
      'download_speed': '${random.getRandomDouble(start: 0, end: 100)}B/s',
      'host_traffic': {'host': host}
    };
  }
}
