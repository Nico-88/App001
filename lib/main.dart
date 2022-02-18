import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

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
      home: const MyHomePage(title: 'AlphaFitness KFA Rechner'),
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
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();

  String gender = 'male';
  dynamic bodySize = 0;
  dynamic neckCircumference = 0;
  dynamic hipCircumference = 0;
  dynamic waistCircumference = 0;
  dynamic kfa = 0.00;

  @override
  void initState() {
    super.initState();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      if(gender == 'male') {
        setState(() {
          kfa = (86.010 * (log(waistCircumference - neckCircumference)/ln10) - 70.041 * (log(bodySize)/ln10) + 30.30).toDouble();
        });
      } else {
        setState(() {
          kfa = (163.205 * (log(waistCircumference + hipCircumference - neckCircumference)/ln10) - 97.684 * (log(bodySize)/ln10) - 104.912).toDouble();
        });
      }
      if(kfa.isNaN || kfa.isInfinite || kfa < 0) {
        kfa = 0.00;
      }
    }
  }

  String? numValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gebe eine Zahl ein.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    const Text('Mann'),
                    const SizedBox(width: 50),
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
                    const Text('Frau'),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: numValidator,
                  onSaved: (value) {
                    setState(() {
                      bodySize = double.parse(value!);
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Körpergröße in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: numValidator,
                  onSaved: (value) {
                    setState(() {
                      neckCircumference = double.parse(value!);
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Nackenumfang in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                Visibility(
                  visible: isVisible ? true : false,
                  child:
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: numValidator,
                          onSaved: (value) {
                            setState(() {
                              hipCircumference = double.parse(value!);
                            });
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Hüftumfang in cm',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: numValidator,
                  onSaved: (value) {
                    setState(() {
                      waistCircumference = double.parse(value!);
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Bauchumfang in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      kfa.toStringAsFixed(2) + ' %',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _submit(),
                      child: const Text('Berechnen'),
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
