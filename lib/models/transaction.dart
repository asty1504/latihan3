class TransactionModel {
  // Menggunakan tipe data yang lebih spesifik dan aman
  final String id; // ID unik untuk identifikasi
  final String title;
  final double amount; // Menggunakan double untuk jumlah uang
  final TransactionType type; // Enum untuk tipe transaksi (Income/Expense)
  final String category;
  final DateTime date; // Tanggal dan waktu transaksi

  // Constructor dengan 'named parameters' yang wajib ('required')
  // Ini membuat kode lebih mudah dibaca dan mencegah kesalahan urutan
  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  // Metode pembantu: Mengubah jumlah uang menjadi format yang rapi (misalnya: Rp150.000)
  // Ini adalah praktik bagus untuk logic di dalam model
  String get formattedAmount {
    final symbol = type == TransactionType.expense ? '-Rp' : '+Rp';
    // Anda bisa menggunakan package 'intl' untuk format yang lebih baik
    return '$symbol${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}

// Tambahkan Enum (tipe data khusus) untuk membuat tipe transaksi lebih jelas
enum TransactionType { income, expense }
