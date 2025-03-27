import 'package:flutter/material.dart';
import 'package:testapp/Pertemuan2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modular Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/pertemuan2': (context) => const Pertemuan2(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Pertemuan')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Pertemuan 2'),
            onTap: () => Navigator.pushNamed(context, '/pertemuan2'),
          ),
        ],
      ),
    );
  }
}
