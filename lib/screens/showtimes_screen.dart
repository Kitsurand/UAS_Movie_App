import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/movie.dart';
import '../models/showtime.dart';
import 'seat_selection_screen.dart';

class ShowtimesScreen extends StatelessWidget {
  final Movie movie;

  const ShowtimesScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final showtimes = showtimesForMovie(movie.id);
    final byCinema = <String, List<Showtime>>{};
    for (final s in showtimes) {
      byCinema.putIfAbsent(s.cinemaId, () => []).add(s);
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFFE23744),
              ),
              const SizedBox(width: 8),
              Text(
                showtimes.first.date,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final cinemaId in byCinema.keys)
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cinemaById(cinemaId).name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cinemaById(cinemaId).location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: byCinema[cinemaId]!
                          .map(
                            (s) => OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SeatSelectionScreen(
                                      movie: movie,
                                      showtime: s,
                                    ),
                                  ),
                                );
                              },
                              child: Text(s.time),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
