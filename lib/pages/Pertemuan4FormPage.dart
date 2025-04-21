import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/profile_model.dart';
import '../helpers/db_helper.dart';

class Pertemuan4FormPage extends StatefulWidget {
  const Pertemuan4FormPage({super.key});

  @override
  State<Pertemuan4FormPage> createState() => _Pertemuan4FormPageState();
}

class _Pertemuan4FormPageState extends State<Pertemuan4FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _fakultasController = TextEditingController();
  final _prodiController = TextEditingController();
  final _alamatController = TextEditingController();
  final _hpController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveData() async {
    final profile = Profile(
      nama: _namaController.text,
      nim: _nimController.text,
      fakultas: _fakultasController.text,
      prodi: _prodiController.text,
      alamat: _alamatController.text,
      hp: _hpController.text,
      fotoPath: _image?.path,
    );

    int id = await DBHelper.insertProfile(profile);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('profileId', id);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sukses'),
        content: const Text('Data berhasil disimpan ke database!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/view');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, TextInputType type) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? '$label tidak boleh kosong' : null,
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 8),
              const Text(
                'Complete Your Profile',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Don't worry, only you can see your personal data. No one else will be able to see it.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(Icons.person, size: 60, color: Colors.grey[500])
                          : null,
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFF5D504A),
                          child: const Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildInput(_namaController, 'Nama', TextInputType.name),
              const SizedBox(height: 16),
              _buildInput(_nimController, 'NIM', TextInputType.number),
              const SizedBox(height: 16),
              _buildInput(_fakultasController, 'Fakultas', TextInputType.text),
              const SizedBox(height: 16),
              _buildInput(_prodiController, 'Prodi', TextInputType.text),
              const SizedBox(height: 16),
              _buildInput(_alamatController, 'Alamat', TextInputType.streetAddress),
              const SizedBox(height: 16),
              _buildInput(_hpController, 'Nomor HP', TextInputType.phone),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveData();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D504A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Complete Profile', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
