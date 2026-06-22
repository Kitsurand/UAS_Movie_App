import 'package:flutter/material.dart';
import '../models/seat.dart';

const _districtRed = Color(0xFFE23744);

class SeatTile extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatTile({super.key, required this.seat, required this.onTap});

  Color _colorFor(SeatStatus status) {
    switch (status) {
      case SeatStatus.available:
        return Colors.white;
      case SeatStatus.selected:
        return _districtRed;
      case SeatStatus.booked:
        return const Color(0xFFE8E8E8);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBooked = seat.status == SeatStatus.booked;
    return GestureDetector(
      onTap: isBooked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: _colorFor(seat.status),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: seat.status == SeatStatus.selected
                ? _districtRed
                : Colors.black26,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          seat.label,
          style: TextStyle(
            fontSize: 10,
            color: isBooked
                ? Colors.black26
                : seat.status == SeatStatus.selected
                ? Colors.white
                : Colors.black54,
          ),
        ),
      ),
    );
  }
}
