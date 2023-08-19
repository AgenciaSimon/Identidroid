import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDENTIDROID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? deviceID;

  static Future<String?> mac() async {
    try {
      String? mac = await PlatformDeviceId.getDeviceId;
      print(mac);
      return mac;
    } on PlatformException {
      return 'Failed to get Device MAC Address.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 10),
                  child: Text('IDENTIFICADOR DEL DISPOSITIVO',
                      style: TextStyle(
                          fontSize: 60, color: const Color(0xff649AF7))),
                ),
                Text(
                  'Tener discreción con el manejo de este código',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: FutureBuilder<String?>(
                    future: mac(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = <Widget>[
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('ID: ${snapshot.data}',
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.black)),
                          )
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Error, Vuelva a intentarlo',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                          )
                        ];
                      } else {
                        children = <Widget>[
                          const SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Obteniendo ID...',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black)),
                          )
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: children,
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child:
                      const Text('Actualizar', style: TextStyle(fontSize: 50)),
                )
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
