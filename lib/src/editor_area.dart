import 'package:editor_kit/editor_kit.dart';
import 'package:flutter/material.dart';

class EditorArea extends StatefulWidget {
  const EditorArea({super.key, this.items = const []});

  final List<EditorItem> items;

  @override
  State<EditorArea> createState() => _EditorAreaState();
}

class _EditorAreaState extends State<EditorArea> {
  final _items = ValueNotifier<List<EditorItem>>([]);

  @override
  void initState() {
    super.initState();
    _items.value = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<EditorItem>(
      onAcceptWithDetails: (details) {
        _items.value.add(details.data);
      },
      builder: (context, candidates, rejects) {
        return ValueListenableBuilder(
          valueListenable: _items,
          builder: (context, items, _) {
            return Stack(children: items);
          },
        );
      },
    );
  }
}
