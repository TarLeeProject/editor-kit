import 'package:editor_kit/src/edit_element.dart';
import 'package:editor_kit/src/editor_area.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final elements = [
    EditElement(
      data: Image.network(
        'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/396e9/MainBefore.jpg',
        width: 130,
        height: 66,
        fit: BoxFit.fill,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Column(
          children: [
            Expanded(child: EditorArea()),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: elements.length,
              itemBuilder: (context, index) {
                final element = elements[index];
                return element;
              },
            ),
          ],
        ),
      ), // The initial screen of the app
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}

void main() async {
  runApp(MyApp());
}

// Stack(
// children: [
// EditorItem(
// widget: Image.network(
// 'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/396e9/MainBefore.jpg',
// width: 130,
// height: 66,
// fit: BoxFit.fill,
// ),
// ),
// EditorItem(
// widget: Image.network(
// 'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
// width: 130,
// height: 66,
// fit: BoxFit.fill,
// ),
// ),
// EditorItem(
// widget: Container(color: Colors.yellow, width: 100, height: 50),
// ),
// ],
// ),
