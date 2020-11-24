import 'package:flutter/material.dart';

class CodeFields extends StatefulWidget {
  const CodeFields(
      {Key key,
      @required this.length,
      this.fieldWidth = 60,
      this.fieldHeight = 60,
      this.keyboardType = TextInputType.number,
      this.inputDecoration = const InputDecoration(),
      this.textStyle,
      this.margin = const EdgeInsets.symmetric(horizontal: 8.0),
      this.validator,
      this.onChanged,
      this.onCompleted,
      this.closeOnFinish = true,
      this.autofocus = false})
      : assert(length >= 2, "The length of the code must be greater than two."),
        super(key: key);

  /// Code length.
  ///
  /// It is required and must be greater than two.
  final int length;

  /// Width of each TextFormField.
  ///
  /// The default width is 60px.
  final double fieldWidth;

  /// Height of each TextFormField.
  ///
  /// The default width is 60px.
  final double fieldHeight;

  /// Type of keyboard that shows up.
  ///
  /// The default keyboard type is `TextInputType.number`.
  final TextInputType keyboardType;

  /// Allows you to customize the TextFormField.
  final InputDecoration inputDecoration;

  /// The text style of the TextFormFields.
  final TextStyle textStyle;

  /// The margin between each TextFormField.
  ///
  /// The default margin is `EdgeInsets.symmetric(horizontal: 8.0)`.
  final EdgeInsets margin;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  ///
  /// The returned value is displayed in the center of all TextFormField.
  ///
  /// Alternating between error and normal status can cause the height of the TextFormField to change.
  ///
  /// To create a field whose height is fixed regardless of whether an error is not displayed set the [helperText] parameter to a space.
  final FormFieldValidator<String> validator;

  /// The callback function that is executed when the entered code changes.
  ///
  /// Returns a String with the current code.
  final Function(String) onChanged;

  /// The callback function that is executed when the length of the entered code is complete.
  ///
  /// Returns a String with the current code.
  final Function(String) onCompleted;

  /// Option that closes the keyboard when the code is finished entering.
  ///
  /// The default value is `true`.
  final bool closeOnFinish;

  /// Select the first TextFormField and display the keyboard when it is built.
  ///
  /// The default value is `false`.
  final bool autofocus;

  @override
  _CodeFieldsState createState() => _CodeFieldsState();
}

class _CodeFieldsState extends State<CodeFields> {
  List<TextEditingController> controllers;
  String whitespaceCharacter = "\uFEFF";

  String errorText = "";
  void setErrorText(String error) {
    setState(() => errorText = error);
  }

  @override
  void initState() {
    controllers = new List<TextEditingController>(widget.length);

    controllers[0] = new TextEditingController();
    for (int i = 1; i < widget.length; i++) {
      controllers[i] = new TextEditingController(text: whitespaceCharacter);
    }
    super.initState();
  }

  @override
  void dispose() {
    controllers
        .forEach((TextEditingController controller) => controller.dispose());

    super.dispose();
  }

  String getCode() {
    String code = "";
    controllers.forEach((TextEditingController controller) {
      code += controller.text.replaceAll(whitespaceCharacter, "");
    });
    return code;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: widget.fieldHeight + 8.0,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: controllers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext buildContext, int index) {
                return buildField(index);
              }),
        ),
        Visibility(
          visible: errorText != "",
          child: Text(
            errorText,
            textAlign: TextAlign.center,
            style: themeData.textTheme.caption
                .copyWith(color: themeData.errorColor)
                .merge(themeData.inputDecorationTheme.errorStyle),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget buildField(int index) {
    return Container(
      height: widget.fieldHeight,
      width: widget.fieldWidth,
      margin: widget.margin,
      child: Center(
        child: TextFormField(
          controller: controllers[index],
          maxLength: index == 0 ? 1 : 2,
          textAlign: TextAlign.center,
          keyboardType: widget.keyboardType,
          style: widget.textStyle,
          enableInteractiveSelection: false,
          minLines: null,
          maxLines: null,
          expands: true,
          autofocus: widget.autofocus,
          textInputAction: index == controllers.length - 1
              ? TextInputAction.done
              : TextInputAction.next,
          onChanged: (String text) {
            if (text.isEmpty) {
              if (index > 0) {
                Future.delayed(Duration(microseconds: 1), () {
                  controllers[index].text = whitespaceCharacter;
                });

                if (index == 1)
                  controllers[index - 1].text = "";
                else
                  controllers[index - 1].text = whitespaceCharacter;
                FocusScope.of(context).previousFocus();
              }
            } else {
              if (index == controllers.length - 1 && text.length == 2) {
                if (widget.closeOnFinish) FocusScope.of(context).unfocus();
              } else if (index == 0 || text.length == 2)
                FocusScope.of(context).nextFocus();
            }

            String code = getCode();
            widget.onChanged(code);
            if (code.length == widget.length) widget.onCompleted(code);
          },
          validator: (String code) {
            String error = widget.validator.call(getCode());
            error != null ? setErrorText(error) : setErrorText("");
            return error;
          },
          decoration: widget.inputDecoration.copyWith(
            errorStyle: TextStyle(fontSize: double.minPositive),
            counter: Offstage(),
          ),
        ),
      ),
    );
  }
}
