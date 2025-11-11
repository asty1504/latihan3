import 'package:flutter/material.dart';

// =========================================================
// 💎 THEME: Dreamy Gloss Blue Edition
// =========================================================
const Color backgroundBlue = Color(0xFFE8F1FC);
const Color lightSkyBlue = Color(0xFFB3E5FC);
const Color oceanBlue = Color(0xFF2196F3);
const Color navyBlue = Color(0xFF0D47A1);
const Color softWhite = Colors.white;
const Color accentBlue = Color(0xFF82B1FF);
const Color greyText = Color(0xFF607D8B);

// =========================================================
// 🧾 MODEL: TransactionModel
// =========================================================
enum TransactionType { income, expense }

class TransactionModel {
  final String title;
  final double amount;
  final String category;
  final TransactionType type;
  final String date;

  TransactionModel(this.title, String amountStr, this.category, this.date)
    : amount = double.parse(amountStr.replaceAll(RegExp(r'[Rp\.\+\-]'), '')),
      type = amountStr.contains('+')
          ? TransactionType.income
          : TransactionType.expense;

  String get formattedAmount {
    final sign = type == TransactionType.expense ? '-Rp' : '+Rp';
    String formatted = amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '$sign$formatted';
  }
}

// =========================================================
// 💳 ATM CARD – Glossy Blue Gradient
// =========================================================
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
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      width: cardWidth,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color2.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wallet_rounded, color: Colors.white, size: 26),
              const SizedBox(width: 8),
              Text(
                bankName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'Available Balance',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            balance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardNumber,
                style: const TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.credit_card, color: Colors.white70),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================
// 📈 OVERVIEW CARD – Modern Shadow Card
// =========================================================
class OverviewCard extends StatelessWidget {
  final double income;
  final double expense;

  const OverviewCard({super.key, required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    final double remaining = income - expense;
    final double expensePercent = income == 0
        ? 0
        : (expense / income).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: softWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: oceanBlue.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: expensePercent,
                  strokeWidth: 9,
                  backgroundColor: accentBlue.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation(oceanBlue),
                ),
                Text(
                  '${(expensePercent * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: navyBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(
                  Icons.arrow_upward_rounded,
                  "Income",
                  "+Rp${income.toStringAsFixed(0)}",
                  Colors.green,
                ),
                const SizedBox(height: 8),
                _buildRow(
                  Icons.arrow_downward_rounded,
                  "Expense",
                  "-Rp${expense.toStringAsFixed(0)}",
                  Colors.red,
                ),
                const Divider(),
                _buildRow(
                  Icons.savings_rounded,
                  "Remaining",
                  "Rp${remaining.toStringAsFixed(0)}",
                  oceanBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String title, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(title, style: const TextStyle(color: greyText)),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// =========================================================
// ⚡ QUICK ACTION BUTTON
// =========================================================
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: navyBlue, fontSize: 12)),
      ],
    );
  }
}

// =========================================================
// 💰 TRANSACTION ITEM
// =========================================================
class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionItem({super.key, required this.transaction});

  IconData getIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.fastfood_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'travel':
        return Icons.flight_takeoff_rounded;
      case 'income':
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.monetization_on_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = transaction.type == TransactionType.expense
        ? Colors.redAccent
        : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: softWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: oceanBlue.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(transaction.category), color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: navyBlue,
                  ),
                ),
                Text(
                  "${transaction.category} | ${transaction.date}",
                  style: const TextStyle(color: greyText, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            transaction.formattedAmount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// 🏠 HOME SCREEN
// =========================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel('Coffee', '-Rp25.000', 'Food', '06 Nov'),
      TransactionModel('Salary', '+Rp10.000.000', 'Income', '01 Nov'),
      TransactionModel('Shopee', '-Rp120.000', 'Shopping', '04 Nov'),
      TransactionModel('Taxi', '-Rp45.000', 'Travel', '05 Nov'),
    ];

    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: oceanBlue,
        title: const Text(
          'Asty Finance 💎',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                AtmCard(
                  bankName: "BRI",
                  cardNumber: "**** 3456",
                  balance: "Rp10.000.000",
                  color1: oceanBlue,
                  color2: accentBlue,
                ),
                AtmCard(
                  bankName: "BNI",
                  cardNumber: "**** 7890",
                  balance: "Rp4.500.000",
                  color1: navyBlue,
                  color2: oceanBlue,
                ),
                AtmCard(
                  bankName: "BSI",
                  cardNumber: "**** 7890",
                  balance: "Rp7.000.000",
                  color1: navyBlue,
                  color2: oceanBlue,
                ),
                AtmCard(
                  bankName: "BJB",
                  cardNumber: "**** 7890",
                  balance: "Rp9.500.000",
                  color1: navyBlue,
                  color2: oceanBlue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const OverviewCard(income: 10000000, expense: 2545000),
          const SizedBox(height: 16),
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navyBlue,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              QuickActionButton(
                icon: Icons.send_rounded,
                label: "Transfer",
                color: oceanBlue,
              ),
              QuickActionButton(
                icon: Icons.qr_code_2_rounded,
                label: "QR Pay",
                color: accentBlue,
              ),
              QuickActionButton(
                icon: Icons.wallet_rounded,
                label: "Top Up",
                color: navyBlue,
              ),
              QuickActionButton(
                icon: Icons.pie_chart_rounded,
                label: "Report",
                color: oceanBlue,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navyBlue,
            ),
          ),
          const SizedBox(height: 10),
          for (var t in transactions) TransactionItem(transaction: t),
        ],
      ),
    );
  }
}

// =========================================================
// 🌈 MAIN APP
// =========================================================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Asty Finance 💎",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: oceanBlue),
        useMaterial3: true,
        fontFamily: "Poppins",
      ),
      home: const HomeScreen(),
    );
  }
}
