enum SeatStatus { available, selected, booked }

class Seat {
  final String row;
  final int number;
  SeatStatus status;

  Seat({
    required this.row,
    required this.number,
    this.status = SeatStatus.available,
  });

  String get label => '$row$number';
}
