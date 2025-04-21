class Profile {
  final int? id;
  final String nama;
  final String nim;
  final String fakultas;
  final String prodi;
  final String alamat;
  final String hp;
  final String? fotoPath;

  Profile({
    this.id,
    required this.nama,
    required this.nim,
    required this.fakultas,
    required this.prodi,
    required this.alamat,
    required this.hp,
    this.fotoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'fakultas': fakultas,
      'prodi': prodi,
      'alamat': alamat,
      'hp': hp,
      'fotoPath': fotoPath,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      nama: map['nama'],
      nim: map['nim'],
      fakultas: map['fakultas'],
      prodi: map['prodi'],
      alamat: map['alamat'],
      hp: map['hp'],
      fotoPath: map['fotoPath'],
    );
  }
}
