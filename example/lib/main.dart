import 'package:editor_kit/src/edit_element.dart';
import 'package:editor_kit/src/editor_area.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final elements = [
    EditElement(
      data: Image.network(
        'https://static.vecteezy.com/vite/assets/photo-masthead-375-BoK_p8LG.webp',
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
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: elements.length,
                itemBuilder: (context, index) {
                  final element = elements[index];
                  return element;
                },
              ),
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
