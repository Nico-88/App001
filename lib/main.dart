import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
  String gender = 'male';
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          isVisible = false;
                          gender = value.toString();
                        });
                      },
                    ),
                    Text('Mann'),
                    SizedBox(width: 50),
                    Radio(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          isVisible = true;
                          gender = value.toString();
                        });
                      },
                    ),
                    Text('Frau'),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Körpergröße in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nackenumfang in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                Visibility(
                  visible: isVisible ? true : false,
                  child:
                    Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hüftumfang in cm',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bauchumfang in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '0,0 %',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(gender == 'male') {
                          print('Männer berechnung');
                        } else {
                          print('Frauen berechnung');
                        }
                      },
                      child: Text('Berechnen')
                    ),
                  ],
                ),
              ],
            )
          )
        )
      ),
    );
  }
}
