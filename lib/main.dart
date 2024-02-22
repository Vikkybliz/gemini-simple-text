import 'package:ai_test/api.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GenerativeModel model;
  TextEditingController _controller = TextEditingController();
  String generated = '';

  @override
  void initState() {
    model = GenerativeModel(model: 'gemini-pro', apiKey: APIKEY);
    super.initState();
  }

  generate() async {
    final prompt = [Content.text(_controller.text)];
    final response = await model.generateContent(prompt);
    setState(() {
      generated = response.text!;
    });
    print(response.text!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: TextField(
              controller: _controller,
            )),
            const SizedBox(
              height: 14,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    generate();
                  },
                  child: const Text('Press me')),
            ),
            Text(generated)
          ],
        ),
      ),
    );
  }
}
