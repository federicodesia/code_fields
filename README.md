# Code Fields 🔢

A package that allows you to create code fields with customization options for Flutter. It can be useful for OTP and other verification methods.

<br>

<img width="320px" alt="Example image" src="https://raw.githubusercontent.com/federicodesia/code_fields/master/example/images/simple_usage.gif"/>

<br>

## ⚡️ Features

- Automatically focuses the next field on typing.
- Automatically focuses the previous field on deletation.
- Controller to clear or set a code.
- Option to change the length.
- Option to change the height and width.
- Default cursor support.
- Default error message.
- Form validation.
- Autofocus option.
- Auto close keyboard on finish option.
- On change callback function.
- On completed callback function.
- And more!

<br>

## 📌 Simple Usage

```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("CodeFields example"),
        ),
        body: Center(
          child: CodeFields(
            length: codeLength,
          ),
        ),
      ),
    );
  }
```

<br>

## 📌 Custom Usage
Options that allow for more control:

|  Properties  | Type | Description |
|--------------|-----------|-------------|
| `length` | int | Code length. |
| `controller` | CodeFieldsController | Allows you to clear or set a code. |
| `fieldWidth`| double | Width of each TextFormField.<br>The default width is 60px.|
| `fieldHeight`| double | Height of each TextFormField.<br>The default width is 60px.|
| `keyboardType`| TextInputType | Type of keyboard that shows up.<br>The default keyboard type is `TextInputType.number`.|
| `inputDecoration`| InputDecoration | Allows you to customize the TextFormFields.|
| `textStyle`| TextStyle | The text style of the TextFormFields.|
| `margin`| EdgeInsets | The margin between each TextFormField.<br>The default margin is `EdgeInsets.symmetric(horizontal: 8.0)`.|
| `validator`| FormFieldValidator<​String> | An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.<br>The returned value is displayed in the center of all TextFormField.|
| `onChanged`| Function(String) | The callback function that is executed when the entered code changes. Returns a string with the current code.|
| `onCompleted`| Function(String) | The callback function that is executed when the length of the entered code is complete. Returns a string with the current code.|
| `closeOnFinish`| bool | Option that closes the keyboard when the code is finished entering. The default value is `true`.|
| `autofocus`| bool | Select the first TextFormField and display the keyboard when it is built. The default value is `false`.|

<br>

## 📌 Changing the Style

<br>

<img width="320px" alt="Example image" src="https://raw.githubusercontent.com/federicodesia/code_fields/master/example/images/input_decoration.gif"/>

<br>

You must change the inputDecoration property:

```dart
  CodeFields(
    length: 4,
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
  )
```

<br>

## 📌 Using the Validator

<br>

<img width="320px" alt="Example image" src="https://raw.githubusercontent.com/federicodesia/code_fields/master/example/images/validation.gif"/>

<br>

#### 1. Create a function with the validation rules. Returns a string with the error or null for the normal state.
```dart
  String validateCode(String code){
    if(code.length < 4) return "Please complete the code";
    else{
      bool isNumeric = int.tryParse(code) != null;
      if(!isNumeric) return "Please enter a valid code";
    }
    return null;
  }
```

#### 2. Wrap the CodeFields widget with a Form and define a key.
```dart
  final formKey = GlobalKey<FormState>();
```

```dart
  Form(
    key: formKey,
    child: CodeFields(
      length: 4,
    )
  )
```

#### 3. Calls the form validation when the button is pressed.
```dart
  FlatButton(
    child: Text("Validate code"),
    onPressed: () {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
      }
    },
  )
```

<br>

## 📌 Using the CodeFieldsController

```dart
  final CodeFieldsController _controller = new CodeFieldsController();
```

<br>

|  Functions  | Type | Description |
|--------------|-----------|-----------|
| `clearCode()` | void | Clear the code from all TextFields. |
| `setCode()` |  Function(int code) | Set a code in all TextFields. The length of the code must be equal to that defined in the widget's `length` property. |

<br>

<br>

## ⚙️ Installation

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  code_fields: ^0.0.3
```

Install it:
```yaml
$ flutter pub get
```

Import the package in your project:
```
import 'package:code_fields/code_fields.dart';
```
