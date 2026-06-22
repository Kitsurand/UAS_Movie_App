class Booking {
  final String id;
  final String showtimeId;
  final List<String> seatLabels;
  final double totalPrice;
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.showtimeId,
    required this.seatLabels,
    required this.totalPrice,
    required this.createdAt,
  });
}
