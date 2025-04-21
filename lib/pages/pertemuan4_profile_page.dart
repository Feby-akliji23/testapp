import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/db_helper.dart';

class Pertemuan4ProfilePage extends StatefulWidget {
  const Pertemuan4ProfilePage({super.key});

  @override
  State<Pertemuan4ProfilePage> createState() => _Pertemuan4ProfilePageState();
}

class _Pertemuan4ProfilePageState extends State<Pertemuan4ProfilePage> {
  // Data profil
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

  // Ambil data dari SharedPreferences dan DB
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('profileId');

    if (id != null) {
      final profile = await DBHelper.getProfileById(id);
      if (profile != null) {
        setState(() {
          _nama = profile.nama;
          _nim = profile.nim;
          _fakultas = profile.fakultas;
          _prodi = profile.prodi;
          _alamat = profile.alamat;
          _hp = profile.hp;
          if (profile.fotoPath != null) {
            _image = File(profile.fotoPath!);
          }
        });
      }
    }
  }

  // Widget untuk menampilkan satu field profil
  Widget _buildSingleField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF3E322D),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : '-',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Card berisi data profil
  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSingleField('Nama', _nama),
            _buildSingleField('NIM', _nim),
            _buildSingleField('Fakultas', _fakultas),
            _buildSingleField('Prodi', _prodi),
            _buildSingleField('Alamat', _alamat),
            _buildSingleField('Nomor HP', _hp),
          ],
        ),
      ),
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

            // Foto profil
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
            _buildProfileCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
