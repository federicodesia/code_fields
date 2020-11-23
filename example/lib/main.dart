import 'package:flutter/material.dart';
import 'package:code_fields/code_fields.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final formKey = GlobalKey<FormState>();
  final int codeLength = 4;

  String validateCode(String code){

    if(code.length < codeLength) return "Please complete the code";
    else{
      bool isNumeric = int.tryParse(code) != null;
      if(!isNumeric) return "Please enter a valid code";
    }
    return null;
  }

  Future<void> onButtonPressed() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("CodeFields example"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CodeFields(
                  length: codeLength,
                  validator: validateCode,
                  inputDecoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide(color: Colors.transparent)
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
                SizedBox(height: 32.0,),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Validate code",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    height: 56.0,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    onPressed: onButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}