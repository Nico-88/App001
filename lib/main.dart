import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();

  String gender = 'male';
  var bodySize = 0;
  var neckCircumference = 0;
  var hipCircumference = 0;
  var waistCircumference = 0;
  var kfa = 0;

  @override
  void initState() {
    super.initState();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      print('bodySize: '+bodySize.toString());
      print('neckCircumference: '+neckCircumference.toString());
      print('hipCircumference: '+hipCircumference.toString());
      print('waistCircumference: '+waistCircumference.toString());
    }
  }

  String? integerValidator(value) {
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
                  validator: integerValidator,
                  onSaved: (value) {
                    setState(() {
                      bodySize = int.parse(value!);
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Körpergröße in cm',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: integerValidator,
                  onSaved: (value) {
                    setState(() {
                      neckCircumference = int.parse(value!);
                    });
                  },
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
                          validator: integerValidator,
                          onSaved: (value) {
                            setState(() {
                              hipCircumference = int.parse(value!);
                            });
                          },
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
                  validator: integerValidator,
                  onSaved: (value) {
                    setState(() {
                      waistCircumference = int.parse(value!);
                    });
                  },
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
                      kfa.toString(),
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
