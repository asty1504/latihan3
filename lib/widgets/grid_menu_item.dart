import 'package:flutter/material.dart';

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const GridMenuItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    // Warna Primer (Ungu Gelap) yang konsisten dengan tema aplikasi
    const Color primaryColor = Color(0xFF4A00E0);

    return Card(
      // Menggunakan Card untuk efek elevasi (kedalaman) yang alami
      elevation: 8, // Bayangan yang lebih menonjol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Sudut lebih melengkung
      ),
      margin: EdgeInsets.zero, // Hilangkan margin Card default
      child: InkWell(
        // InkWell memberikan efek sentuhan (ripple effect) yang interaktif
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // Tambahkan logika navigasi/aksi di sini
          print('Item $label di-tap!');
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // Menggunakan warna latar belakang yang netral, menonjolkan ikon
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon: Lebih besar dan menggunakan warna primer
              Icon(icon, size: 48, color: primaryColor),
              const SizedBox(height: 12),
              // Label: Teks lebih tebal
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
