import 'package:editor_kit/src/editor_item.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App', // Title for the app in recent apps list
      theme: ThemeData(
        primarySwatch: Colors.blue, // Defines the primary color palette
      ),
      home: Scaffold(
        body: Stack(
          children: [
            EditorItem(
              widget: Image.network(
                'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/396e9/MainBefore.jpg',
                width: 130,
                height: 66,
                fit: BoxFit.fill,
              ),
            ),
            EditorItem(
              widget: Image.network(
                'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
                width: 130,
                height: 66,
                fit: BoxFit.fill,
              ),
            ),
            EditorItem(
              widget: Container(color: Colors.yellow, width: 100, height: 50),
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
