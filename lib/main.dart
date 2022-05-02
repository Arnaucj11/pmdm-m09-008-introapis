import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = false;

  Future<void> _makeRequest() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse(
        'https://api-example-91ed4-default-rtdb.europe-west1.firebasedatabase.app/people.json');

    try {
      final response = await http.post(url,
          body: json.encode({'name': 'Daniel Garrido', 'age': 10}));
      // aqui iria codigo del then
      setState(() {
        _isLoading = false;
      });
      print(json.decode(response.body));
    } catch (error) {
      // catchError
      showDialog(
        builder: (ctx) => AlertDialog(
          actions: [
            RaisedButton(
              child: Text("Cerrar"),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
          content: Text("Algo sucedió durante la conexión a la API"),
          title: Text("Ocurrió un error inesperado"),
        ),
        context: context,
      );
    }

    /*.then((response) {
          
        }).catchError((error) {
          
        });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Petición OK',
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _makeRequest,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
