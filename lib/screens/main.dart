import 'package:flutter/material.dart';
import 'package:inatel_app_challenge/bloc/dataBloc.dart';
import 'package:inatel_app_challenge/data.dart';
import 'package:inatel_app_challenge/screens/charts.dart';
//import 'package:inatel_app_challenge/socket/fakeSocketService.dart';
import 'package:inatel_app_challenge/socket/realSocketService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  DataBloc get _bloc => DataBlocImpl(
      RealSocketService()); 

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(_bloc, title: 'Monitoramento de tráfego de rede'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final DataBloc bloc;

  const MyHomePage(this.bloc, {super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(bloc);
}

class _MyHomePageState extends State<MyHomePage> {
  final DataBloc bloc;

  _MyHomePageState(this.bloc);

  @override
  void initState() {
    super.initState();
    bloc.startConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.title),
        ),
        body: StreamBuilder<List<Data>>(
            stream: bloc.listDataSubject.stream,
            builder: ((context, snapshot) {
              List<Data> list = snapshot.data ?? [];
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    final item = list[index];
                    if (index == list.length - 1) {
                      return Column(
                        children: [
                          Card(
                              child: ListTile(
                            title: Text('${item.pid} - ${item.name}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            subtitle: Text(item.getInfo()),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChartsPage(list)));
                                },
                                child: const Text("Ver graficos")),
                          )
                        ],
                      );
                    }
                    return Card(
                        child: ListTile(
                      title: Text('${item.pid} - ${item.name}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      subtitle: Text(item.getInfo()),
                    ));
                  }));
            })));
  }
}
