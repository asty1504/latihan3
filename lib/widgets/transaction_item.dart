import 'package:flutter/material.dart';
import '../models/transaction.dart'; // Memastikan import model Anda

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  // Fungsi pembantu untuk memetakan kategori ke ikon yang relevan
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.local_cafe_rounded; // Kopi/Makanan
      case 'travel':
        return Icons.directions_car_filled_rounded; // Mobil/Perjalanan
      case 'health':
        return Icons.local_hospital_rounded; // Kesehatan/Rumah Sakit
      case 'event':
        return Icons.movie_filter_rounded; // Film/Event
      case 'income':
        return Icons.payments_rounded; // Pemasukan
      default:
        return Icons.category_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tipe transaksi sudah diproses di TransactionModel.
    final isExpense = transaction.type == TransactionType.expense;

    // Warna untuk amount dan ikon (Merah untuk Expense, Hijau untuk Income)
    final amountColor = isExpense
        ? Colors.redAccent.shade700
        : Colors.green.shade600;

    // Warna latar belakang ikon (menggunakan warna aksen aplikasi ungu)
    const Color primaryColor = Color(0xFF4A00E0);
    final iconBgColor = primaryColor.withOpacity(0.1);
    final iconFgColor = primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ikon Kategori Dinamis
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getCategoryIcon(transaction.category),
                color: iconFgColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Judul & Kategori
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.category,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              // Menggunakan getter dari model untuk pemformatan yang benar
              transaction.formattedAmount,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
