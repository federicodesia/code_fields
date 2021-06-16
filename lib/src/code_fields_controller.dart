import 'package:flutter/material.dart';

typedef CodeFieldsCode = void Function(int code);

/// Controller for CustomTimer.
class CodeFieldsController {
  /// The callback function that executes when the `start` method is called.
  VoidCallback? _onClearCode;

  CodeFieldsCode? _onSetCode;

  /// Constructor.
  CodeFieldsController();

  /// Start the timer.
  clearCode() {
    if (this._onClearCode != null) this._onClearCode!();
  }

  onClearCode(VoidCallback onClearCode) => this._onClearCode = onClearCode;

  /// Set timer in pause.
  setCode(int code) {
    if (this._onSetCode != null) this._onSetCode!(code);
  }

  onSetCode(CodeFieldsCode onSetCode) => this._onSetCode = onSetCode;
}