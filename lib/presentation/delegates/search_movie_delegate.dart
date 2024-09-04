import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies});

  void clearStreams() {
    // Tenemos que limpiar lo que vamos haciendo en nuestro stream, porque se quda basura, entonces lo podemos hacer con el `debouncedMovies.close()`
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Como las acciones que tenemos en el header , refiriendonos a los search
    return [
      // Palabra reservda el query, la caja de texto, con esto vaciamos la caja de texto al momento de darle tap a la X

      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Construir un icono al inicio
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Los resultados que aparecen al dar enter
    return const Text('Build-Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Cuando esta escribiendo el usuario

    _onQueryChanged(query);

    return StreamBuilder(
        // future: searchMovies(query),
        stream: debouncedMovies.stream,
        initialData: const [],
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _MovieItem(
                  movie: movies[index],
                  // close es la referencia global, por eso podemos mandarla a llamar
                  onMovieSelected: (context, movie) {
                    clearStreams();
                    close(context, movie);
                  },
                );
              });
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem(
      {super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //Image
            SizedBox(
              width: size.width * .2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  movie.overview.length > 100
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.humanReadbleNumber(movie.voteAverage, 1),
                        style: textStyles.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
