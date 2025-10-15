import 'package:flutter/material.dart';

import '../constants/transaction_list_class.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionItem> items;

  const TransactionList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 9),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              // Icon
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade100,
                backgroundImage: AssetImage(item.iconAsset),
              ),
              const SizedBox(width: 15),

              // Name + Amount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600, fontFamily: "Rethink Sans", height: 1.07),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "₹${item.amount}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900, height: 1.07,
                            fontFamily: "Rethink Sans"
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset("assets/wallet/coin.png", scale: 4,)
                      ],
                    ),
                  ],
                ),
              ),

              // Status
              Text(
                item.status,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Rethink Sans",
                  color: item.status == "credited"
                      ? Color(0xFF6FD81E)
                      : Color(0xFF8D8DFF),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
