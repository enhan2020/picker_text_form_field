import 'package:flutter/material.dart';

import 'picker_editing_controller.dart';

class PickerTextFieldForm<T> extends StatefulWidget {
  final T? initialValue;
  final PickerEditingController<T>? controller;
  final String Function(T? data)? stringFormatter;
  final Future<T?> Function(T? selected)? onTap;

  const PickerTextFieldForm({
    super.key,
    this.initialValue,
    this.controller,
    this.stringFormatter,
    this.onTap,
  });

  @override
  State<PickerTextFieldForm<T>> createState() => _PickerTextFieldFormState<T>();
}

class _PickerTextFieldFormState<T> extends State<PickerTextFieldForm<T>> {
  late PickerEditingController<T>? _controller;

  @override
  void initState() {
    super.initState();

    assert(widget.controller != null || widget.stringFormatter != null);
    _controller = widget.controller ??
        PickerEditingController<T>(
            stringFormatter: widget.stringFormatter!, data: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant PickerTextFieldForm<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    assert(widget.controller != null || widget.stringFormatter != null);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller != null && widget.controller == null) {
        _controller = PickerEditingController<T>(
            stringFormatter: widget.stringFormatter!, data: widget.initialValue);
      }

      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          _controller!.dispose();
        }
        _controller = widget.controller;
      }
    }

    if (oldWidget.controller == null && widget.controller == null) {
      if (oldWidget.initialValue != widget.initialValue) {
        _controller?.setData(widget.initialValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      onTap: () async {
        final result = await widget.onTap?.call(_controller?.data);
        if (result != null) {
          _controller?.setData(result);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
