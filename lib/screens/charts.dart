import 'package:flutter/material.dart';
import 'package:inatel_app_challenge/data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsPage extends StatefulWidget {
  List<Data> list;

  ChartsPage(this.list, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ChartsPage> createState() => _ChartsPageState(list);
}

class _ChartsPageState extends State<ChartsPage> {
  List<Data> list;

  late var series = [
    [
      charts.Series(
          id: 'Upload(KB)/Software',
          data: list,
          domainFn: (Data item, _) => item.name,
          measureFn: (Data item, _) => item.uploadNum,
          colorFn: (Data item, _) =>
              charts.ColorUtil.fromDartColor(Colors.blue))
    ],
    [
      charts.Series(
          id: 'Download(KB)/Software',
          data: list,
          domainFn: (Data item, _) => item.name,
          measureFn: (Data item, _) => item.downloadNum,
          colorFn: (Data item, _) =>
              charts.ColorUtil.fromDartColor(Colors.blue))
    ],
    [
      charts.Series(
          id: 'Velocidade Upload(KB)/Software',
          data: list,
          domainFn: (Data item, _) => item.name,
          measureFn: (Data item, _) => item.uploadSpeedNum,
          colorFn: (Data item, _) =>
              charts.ColorUtil.fromDartColor(Colors.blue))
    ],
    [
      charts.Series(
          id: 'Velocidade Download(KB)/Software',
          data: list,
          domainFn: (Data item, _) => item.name,
          measureFn: (Data item, _) => item.downloadSpeedNum,
          colorFn: (Data item, _) =>
              charts.ColorUtil.fromDartColor(Colors.blue))
    ],
  ];

  _ChartsPageState(this.list);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Gráficos"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: series.length,
                itemBuilder: ((context, index) {
                  var serie = series[index];
                  return Column(
                    children: [
                      Text(serie.first.id),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width * 1/3,
                            width: MediaQuery.of(context).size.width,
                            child: charts.BarChart(serie, animate: true)),
                      )
                    ],
                  );
                }))));
  }
}
