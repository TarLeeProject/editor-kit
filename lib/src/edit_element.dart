import 'package:editor_kit/editor_kit.dart';
import 'package:flutter/material.dart';

class EditElement extends StatelessWidget {
  const EditElement({
    super.key,
    this.child,
    this.onDragging,
    required this.data,
  });

  final Widget? child;
  final Widget? onDragging;
  final Widget data;

  @override
  Widget build(BuildContext context) {
    return Draggable<EditorItem>(
      data: EditorItem(widget: data),
      feedback: onDragging ?? FittedBox(child: data),
      childWhenDragging: Opacity(opacity: 0.4, child: child),
      child: child ?? FittedBox(child: data),
    );
  }
}
