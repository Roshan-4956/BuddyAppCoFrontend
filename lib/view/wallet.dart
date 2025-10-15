import 'package:buddy_app/Widgets/appBar.dart';
import 'package:buddy_app/Widgets/navBar.dart';
import 'package:buddy_app/Widgets/transactionList.dart';
import 'package:buddy_app/constants/transaction_list_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class wallet extends ConsumerWidget {
  // final User user;

  const wallet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarr(Name: "Name", Location: "Location"),
      bottomNavigationBar: navBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              child: Center(
                child: Stack(
                  children: [
                    Image.asset("assets/wallet/walletGraphic.png", scale: 4),
                    Positioned(
                      top: 45,
                      left: 20,
                      child: Column(
                        children: [
                          Text(
                            "Total Points",
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Color(0xFFB9B9FF),
                              fontSize: 20,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  1000,
                                ), // Set weight to 1000 if supported
                              ],
                              height: 1.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 20,
                      child: Column(
                        children: [
                          Text(
                            "₹ 1,500",
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Color(0xFFFFFFFF),
                              fontSize: 36,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  1000,
                                ), // Set weight to 1000 if supported
                              ],
                              height: 1.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(28, 23, 0, 23),
            child: Text(
              "Past Transactions",
              style: TextStyle(
                fontFamily: "Rethink Sans",
                color: Color(0xFF000000),
                fontSize: 12,
                fontWeight: FontWeight.w900,
                height: 1.07,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TransactionList(
                items: [
                  TransactionItem(
                    iconAsset: "assets/wallet/pinkTransIcon.png",
                    name: "Pizza and chill event",
                    amount: 1000,
                    status: "credited",
                  ),
                  TransactionItem(
                    iconAsset: "assets/wallet/blueTransIcon.png",
                    name: "Pizza and chill event",
                    amount: 1000,
                    status: "credited",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
