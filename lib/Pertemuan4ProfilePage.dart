import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Pertemuan4ProfilePage extends StatefulWidget {
  const Pertemuan4ProfilePage({super.key});

  @override
  State<Pertemuan4ProfilePage> createState() => _Pertemuan4ProfilePageState();
}

class _Pertemuan4ProfilePageState extends State<Pertemuan4ProfilePage> {
  String _nama = '';
  String _nim = '';
  String _fakultas = '';
  String _prodi = '';
  String _alamat = '';
  String _hp = '';
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? '';
      _nim = prefs.getString('nim') ?? '';
      _fakultas = prefs.getString('fakultas') ?? '';
      _prodi = prefs.getString('prodi') ?? '';
      _alamat = prefs.getString('alamat') ?? '';
      _hp = prefs.getString('hp') ?? '';
      final fotoPath = prefs.getString('foto');
      if (fotoPath != null && fotoPath.isNotEmpty) {
        _image = File(fotoPath);
      }
    });
  }

  Widget _buildInfoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value.isNotEmpty ? value : '-',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3E322D)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Your Profile',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "This is your saved profile data.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(Icons.person, size: 60, color: Colors.grey[500])
                    : null,
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoTile('Nama', _nama),
            _buildInfoTile('NIM', _nim),
            _buildInfoTile('Fakultas', _fakultas),
            _buildInfoTile('Prodi', _prodi),
            _buildInfoTile('Alamat', _alamat),
            _buildInfoTile('Nomor HP', _hp),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
