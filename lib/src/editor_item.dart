import 'dart:math';

import 'package:flutter/material.dart';

class EditorItem extends StatefulWidget {
  final Widget widget;
  const EditorItem({super.key, required this.widget});

  @override
  _EditorItemState createState() => _EditorItemState();
}

class _EditorItemState extends State<EditorItem> {
  final _widgetKey = GlobalKey();

  double _width = 0;
  double _height = 0;
  double _top = 0;
  double _left = 0;

  OverlayEntry? _overlayEntry;

  final _drgPos = ValueNotifier((Offset.zero, Size.zero));
  final _widgetPos = ValueNotifier<(Offset, Size)?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updatedBounds();
      _drgPos.value = (Offset(_left, _top), Size(_width, _height));
      _widgetPos.value = _drgPos.value;
    });
  }

  @override
  void didUpdateWidget(EditorItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updatedBounds();
      _drgPos.value = (Offset(_left, _top), Size(_width, _height));
      _widgetPos.value = _drgPos.value;
    });
  }

  void _updatedBounds() {
    try {
      final renderBox =
          _widgetKey.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final offset = renderBox.localToGlobal(Offset.zero);
        _width = renderBox.size.width;
        _height = renderBox.size.height;
        _left = offset.dx;
        _top = offset.dy;
      }
    } catch (e, st) {
      debugPrint('There is a exception while calculate metrics: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => ValueListenableBuilder(
        valueListenable: _drgPos,
        builder: (context, pos, child) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top: pos.$1.dy,
                left: pos.$1.dx,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _drgPos.value = (
                      Offset(
                        pos.$1.dx + details.delta.dx,
                        pos.$1.dy + details.delta.dy,
                      ),
                      pos.$2,
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: pos.$2.width,
                    height: pos.$2.height,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy - 4,
                left: pos.$1.dx - 4,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldLeft = pos.$1.dx;
                    final oldTop = pos.$1.dy;

                    final right =
                        _widgetPos.value!.$1.dx + _widgetPos.value!.$2.width;
                    final newLeft = oldLeft + details.delta.dx >= right
                        ? right
                        : oldLeft + details.delta.dx;

                    final bottom =
                        _widgetPos.value!.$1.dy + _widgetPos.value!.$2.height;
                    final newTop = oldTop + details.delta.dy >= bottom
                        ? bottom
                        : oldTop + details.delta.dy;

                    final dLeft = newLeft - oldLeft;
                    final dTop = newTop - oldTop;
                    final oldWidth = pos.$2.width;
                    final oldHeight = pos.$2.height;
                    final newWidth = max(1.0, oldWidth - dLeft);
                    final newHeight = max(1.0, oldHeight - dTop);
                    _drgPos.value = (
                      Offset(newLeft, newTop),
                      Size(newWidth, newHeight),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy - 4,
                left: pos.$1.dx + (pos.$2.width / 2),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldTop = pos.$1.dy;

                    final bottom =
                        _widgetPos.value!.$1.dy + _widgetPos.value!.$2.height;
                    final newTop = oldTop + details.delta.dy >= bottom
                        ? bottom
                        : oldTop + details.delta.dy;

                    final dTop = newTop - oldTop;
                    final oldHeight = pos.$2.height;
                    final newHeight = max(1.0, oldHeight - dTop);
                    _drgPos.value = (
                      Offset(pos.$1.dx, newTop),
                      Size(pos.$2.width, newHeight),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy - 4,
                left: pos.$1.dx + pos.$2.width - 6,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldTop = pos.$1.dy;

                    final bottom =
                        _widgetPos.value!.$1.dy + _widgetPos.value!.$2.height;
                    final newTop = oldTop + details.delta.dy >= bottom
                        ? bottom
                        : oldTop + details.delta.dy;

                    final dTop = newTop - oldTop;
                    final oldWidth = pos.$2.width;
                    final oldHeight = pos.$2.height;
                    final newWidth = max(1.0, oldWidth + details.delta.dx);
                    final newHeight = max(1.0, oldHeight - dTop);
                    _drgPos.value = (
                      Offset(pos.$1.dx, newTop),
                      Size(newWidth, newHeight),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy + (pos.$2.height / 2),
                left: pos.$1.dx - 4,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldLeft = pos.$1.dx;

                    final right =
                        _widgetPos.value!.$1.dx + _widgetPos.value!.$2.width;
                    final newLeft = oldLeft + details.delta.dx >= right
                        ? right
                        : oldLeft + details.delta.dx;

                    final dLeft = newLeft - oldLeft;
                    final oldWidth = pos.$2.width;
                    final newWidth = max(1.0, oldWidth - dLeft);
                    _drgPos.value = (
                      Offset(newLeft, pos.$1.dy),
                      Size(newWidth, pos.$2.height),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy + (pos.$2.height / 2),
                left: pos.$1.dx + pos.$2.width - 6,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldWidth = pos.$2.width;
                    final newWidth = max(1.0, oldWidth + details.delta.dx);
                    _drgPos.value = (
                      Offset(pos.$1.dx, pos.$1.dy),
                      Size(newWidth, pos.$2.height),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy + pos.$2.height - 6,
                left: pos.$1.dx - 4,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldLeft = pos.$1.dx;

                    final right =
                        _widgetPos.value!.$1.dx + _widgetPos.value!.$2.width;
                    final newLeft = oldLeft + details.delta.dx >= right
                        ? right
                        : oldLeft + details.delta.dx;

                    final dLeft = newLeft - oldLeft;
                    final oldWidth = pos.$2.width;
                    final oldHeight = pos.$2.height;
                    final newWidth = max(1.0, oldWidth - dLeft);
                    final newHeight = max(1.0, oldHeight + details.delta.dy);
                    _drgPos.value = (
                      Offset(newLeft, pos.$1.dy),
                      Size(newWidth, newHeight),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy + pos.$2.height - 6,
                left: pos.$1.dx + (pos.$2.width / 2),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldHeight = pos.$2.height;
                    final newHeight = max(1.0, oldHeight + details.delta.dy);
                    _drgPos.value = (
                      Offset(pos.$1.dx, pos.$1.dy),
                      Size(pos.$2.width, newHeight),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: pos.$1.dy + pos.$2.height - 6,
                left: pos.$1.dx + pos.$2.width - 6,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final oldWidth = pos.$2.width;
                    final oldHeight = pos.$2.height;
                    final newWidth = max(1.0, oldWidth + details.delta.dx);
                    final newHeight = max(1.0, oldHeight + details.delta.dy);
                    _drgPos.value = (
                      Offset(pos.$1.dx, pos.$1.dy),
                      Size(newWidth, newHeight),
                    );
                  },
                  onPanEnd: (_) {
                    _widgetPos.value = pos;
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _widgetPos,
      builder: (context, pos, child) {
        return Stack(
          children: [
            pos == null
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: Container(key: _widgetKey, child: widget.widget),
                  )
                : Positioned(
                    top: pos.$1.dy,
                    left: pos.$1.dx,
                    width: pos.$2.width,
                    height: pos.$2.height,
                    child: GestureDetector(
                      onTap: () {
                        if (_overlayEntry != null) return;
                        _overlayEntry = _createOverlayEntry();
                        Overlay.of(context).insert(_overlayEntry!);
                      },
                      child: SizedBox(
                        width: pos.$2.width,
                        height: pos.$2.height,
                        key: _widgetKey,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: widget.widget,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
