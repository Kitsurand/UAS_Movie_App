import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/seat.dart';
import '../models/showtime.dart';
import '../widgets/seat_tile.dart';
import 'checkout_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Movie movie;
  final Showtime showtime;

  const SeatSelectionScreen({
    super.key,
    required this.movie,
    required this.showtime,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  static const _rows = ['A', 'B', 'C', 'D', 'E', 'F'];
  static const _seatsPerRow = 8;
  static const _bookedLabels = {'A3', 'A4', 'C5', 'D1', 'D2', 'F8'};

  late final List<Seat> _seats = [
    for (final row in _rows)
      for (var n = 1; n <= _seatsPerRow; n++)
        Seat(
          row: row,
          number: n,
          status: _bookedLabels.contains('$row$n')
              ? SeatStatus.booked
              : SeatStatus.available,
        ),
  ];

  List<Seat> get _selectedSeats =>
      _seats.where((s) => s.status == SeatStatus.selected).toList();

  double get _total => _selectedSeats.length * widget.showtime.pricePerSeat;

  void _toggleSeat(Seat seat) {
    setState(() {
      seat.status = seat.status == SeatStatus.selected
          ? SeatStatus.available
          : SeatStatus.selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movie.title} · ${widget.showtime.time}'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 240,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              gradient: const LinearGradient(
                colors: [Color(0xFFF7A8AE), Color(0xFFE23744)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE23744).withValues(alpha: 0.3),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'SCREEN',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 2,
              color: Colors.black45,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _seatsPerRow,
                  childAspectRatio: 1,
                ),
                itemCount: _seats.length,
                itemBuilder: (context, index) {
                  final seat = _seats[index];
                  return SeatTile(seat: seat, onTap: () => _toggleSeat(seat));
                },
              ),
            ),
          ),
          _Legend(),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _selectedSeats.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                movie: widget.movie,
                                showtime: widget.showtime,
                                selectedSeats: _selectedSeats
                                    .map((s) => s.label)
                                    .toList(),
                                total: _total,
                              ),
                            ),
                          );
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      _selectedSeats.isEmpty
                          ? 'Select seats to continue'
                          : '${_selectedSeats.length} seat(s) · ₹${_total.toStringAsFixed(0)}',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget item(Color color, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          item(Colors.white, 'Available'),
          const SizedBox(width: 16),
          item(const Color(0xFFE23744), 'Selected'),
          const SizedBox(width: 16),
          item(const Color(0xFFE8E8E8), 'Booked'),
        ],
      ),
    );
  }
}
