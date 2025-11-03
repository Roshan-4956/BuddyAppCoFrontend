class TransactionItem {
  final String iconAsset; // image path for Image.asset
  final String name; // e.g. "Pizza and chill event"
  final int amount; // e.g. 1000
  final String status; // "credited" or "redeemed"

  TransactionItem({
    required this.iconAsset,
    required this.name,
    required this.amount,
    required this.status,
  });
}
