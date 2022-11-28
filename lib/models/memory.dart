class Memory {
  static const operations = ['%', "/", "x", "-", "+", "="];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? operation;
  String _value = '0';
  bool _wipeValue = false;
  String? _lastCommand;

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      operation = command;
      return;
    }
    if (command == "AC") {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) 
     && operations.contains(command)
     && _lastCommand != "="
     && command!= "=";
  }

  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  _addDigit(String digito) {
    final isDot = (digito == ".");
    if (_value == '0' && !isDot) {
      _wipeValue = true;
    }

    if (isDot && _value.contains(".") && !_wipeValue) {
      return;
    }

    final valorAntigo = _wipeValue ? (isDot ? '0' : '') : _value;

    _value = valorAntigo + digito;
    _wipeValue = false;
    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _setOperation(String op) {
    if (_bufferIndex == 0) {
      operation = op;
      _bufferIndex = 1;
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith(".0") ? _value.split('.')[0] : _value;

      bool isEqualSign = op == "=";
      operation = isEqualSign ? null : op;
      _bufferIndex = isEqualSign ? 0 : 1;
    }

    _wipeValue = true;
  }

  _calculate() {
    switch (operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }
}
