import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/movie.dart';
import '../models/showtime.dart';
import 'home_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final Movie movie;
  final Showtime showtime;
  final List<String> selectedSeats;
  final double total;

  const ConfirmationScreen({
    super.key,
    required this.movie,
    required this.showtime,
    required this.selectedSeats,
    required this.total,
  });

  String get _bookingId {
    final seed = '${movie.id}${showtime.id}${selectedSeats.join()}'.hashCode;
    return 'BK-${seed.abs().toString().substring(0, 8)}';
  }

  @override
  Widget build(BuildContext context) {
    final cinema = cinemaById(showtime.cinemaId);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 72),
              const SizedBox(height: 16),
              Text(
                'Booking Confirmed!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Icon(
                  Icons.qr_code_2,
                  size: 140,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(_bookingId, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${cinema.name} · ${showtime.date} · ${showtime.time}',
                      ),
                      Text('Seats: ${selectedSeats.join(', ')}'),
                      const SizedBox(height: 8),
                      Text(
                        'Total paid: ₹${total.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Back to Home'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
