import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/movie.dart';
import '../models/showtime.dart';
import 'confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final Movie movie;
  final Showtime showtime;
  final List<String> selectedSeats;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.movie,
    required this.showtime,
    required this.selectedSeats,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final cinema = cinemaById(showtime.cinemaId);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Color(0xFFE23744),
                ),
                const SizedBox(width: 6),
                Expanded(child: Text('${cinema.name} · ${cinema.location}')),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: Color(0xFFE23744),
                ),
                const SizedBox(width: 6),
                Text(
                  '${showtime.date} · ${showtime.time} · ${showtime.screenName}',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Seats'),
                        Text(selectedSeats.join(', ')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price per seat'),
                        Text('₹${showtime.pricePerSeat.toStringAsFixed(0)}'),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '₹${total.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE23744),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => ConfirmationScreen(
                        movie: movie,
                        showtime: showtime,
                        selectedSeats: selectedSeats,
                        total: total,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Confirm Booking'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
