import 'package:flutter/cupertino.dart';

class PickerEditingController<T> extends TextEditingController {
  T? _data;
  final String Function(T? data) stringFormatter;

  PickerEditingController({
    T? data,
    required this.stringFormatter,
  }) {
    setData(data);
  }

  T? get data => _data;

  void setData(T? data) {
    _data = data;
    text = stringFormatter(data);
  }
}
