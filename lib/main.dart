import 'package:flutter/material.dart';
import 'package:testapp/pages/Pertemuan2.dart';
import 'package:testapp/pages/Pertemuan4FormPage.dart';
import 'package:testapp/pages/Pertemuan4ProfilePage.dart';

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
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => const HomePage(),
        '/pertemuan2': (context) => const Pertemuan2(),
        '/pertemuan4_form_page': (context) => const Pertemuan4FormPage(),
        '/pertemuan4_profile_page': (context) => const Pertemuan4ProfilePage(),
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
          ListTile(
            title: const Text('Pertemuan 4 Form Page'),
            onTap: () => Navigator.pushNamed(context, '/pertemuan4_form_page'),
          ),
          ListTile(
            title: const Text('Pertemuan 4 Profile Page'),
            onTap: () => Navigator.pushNamed(context, '/pertemuan4_profile_page'),
          ),
        ],
      ),
    );
  }
}