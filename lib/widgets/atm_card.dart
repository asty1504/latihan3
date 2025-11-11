import 'package:flutter/material.dart';

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;

  const AtmCard({
    super.key,
    required this.bankName,
    required this.cardNumber,
    required this.balance,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    // Menggunakan responsive width, 85% dari lebar layar
    final double cardWidth = MediaQuery.of(context).size.width * 0.85;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(24), // Padding lebih besar
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), // Sudut lebih melengkung
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.9], // Gradien lebih kontras
        ),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.6), // Shadow lebih menonjol
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Bank Name dan Chip Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bankName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              // Ikon Chip ATM
              const Icon(
                Icons.memory_rounded, // Ikon yang lebih mirip chip
                color: Colors.white70,
                size: 32,
              ),
            ],
          ),

          const Spacer(flex: 2), // Memberi ruang lebih di atas saldo
          // Total Balance Label
          const Text(
            'Total Balance',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),

          // Balance Utama (Font Terbesar)
          Text(
            balance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34, // Ukuran font JAUH lebih besar
              fontWeight: FontWeight.w900,
            ),
          ),

          const Spacer(flex: 1),

          // Row 3: Card Number dan Network Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 2, // Jarak antar huruf untuk kesan kartu
                  shadows: [Shadow(color: Colors.black12, blurRadius: 2)],
                ),
              ),
              // Placeholder Logo (misalnya VISA)
              const Text(
                'VISA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
