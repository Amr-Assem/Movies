import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/core/app_assets.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/actor_card.dart';
import 'package:movies_app/widgets/movie_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Movie? movieDetails;
  bool isLoading = true;
  List<Movie> similarMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yts.mx/api/v2/movie_details.json?movie_id=${widget.movie.id}&with_images=true&with_cast=true'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movieData = data['data']['movie'];
        setState(() {
          movieDetails = Movie.fromJson(movieData);
          isLoading = false;
        });

        await fetchSimilarMovies();
      }
    } catch (e) {
      print('Error fetching movie details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchSimilarMovies() async {
    try {
      // Using movie suggestions API instead of search
      final response = await http.get(
        Uri.parse(
            'https://yts.mx/api/v2/movie_suggestions.json?movie_id=${widget.movie.id}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = (data['data']['movies'] as List?)
            ?.map((movie) => Movie.fromJson(movie))
            .where((movie) => movie.id != widget.movie.id)
            .toList();

        if (mounted) {
          setState(() {
            similarMovies = movies ?? [];
          });
        }
      }
    } catch (e) {
      print('Error fetching similar movies: $e');
    }
  }

  Future<void> _launchTrailer() async {
    final movie = movieDetails ?? widget.movie;
    if (movie.ytTrailerCode.isNotEmpty) {
      final Uri url =
          Uri.parse('https://www.youtube.com/watch?v=${movie.ytTrailerCode}');
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      } catch (e) {
        print('Could not launch trailer: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: AppAssets.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final movie = movieDetails ?? widget.movie;

    return Scaffold(
      backgroundColor: AppAssets.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Container(
              height: 645,
              child: Stack(
                children: [
                  // Movie Poster
                  Image.network(
                    movie.largeCoverImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),

                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(18, 19, 18, 0.2),
                          Color.fromRGBO(18, 19, 18, 1),
                        ],
                        stops: [0, 1.0],
                      ),
                    ),
                  ),

                  // Play Button
                  Center(
                    child: GestureDetector(
                      onTap: _launchTrailer,
                      child: SvgPicture.asset(
                        AppAssets.playButton,
                        width: 92,
                        height: 92,
                      ),
                    ),
                  ),

                  // Movie Title
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 8,
                      children: [
                        Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppAssets.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${movie.year}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFADADAD),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Watch Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  _launchTrailer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppAssets.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(double.infinity, 58),
                ),
                child: Text(
                  'Watch',
                  style: TextStyle(
                    color: AppAssets.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Basic Info
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MovieInfo(icon: AppAssets.heart, text: "${movie.rating}"),
                  MovieInfo(icon: AppAssets.time, text: "${movie.runtime}"),
                  MovieInfo(icon: AppAssets.star, text: "${movie.rating}"),
                ],
              ),
            ),

            // Screenshots Section
            SectionHeading(title: 'Screenshots'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 14,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.largeScreenshot1 ?? '',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.largeScreenshot2 ?? '',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.largeScreenshot3 ?? '',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Similar Movies Section
            if (similarMovies.isNotEmpty) ...[
              SectionHeading(title: 'Similar Movies'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: similarMovies
                      .map((movie) => MovieCard(movie: movie))
                      .toList(),
                ),
              ),
            ],

            // Summary Section
            if (movie.summary.isNotEmpty) ...[
              SectionHeading(title: 'Summary'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  movie.descriptionFull,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ],

            // Cast Section
            if (movie.cast.isNotEmpty) ...[
              SectionHeading(title: 'Cast'),
              for (var actor in movie.cast) ...[ActorCard(actor: actor)],
            ],

            // Genres Section
            SectionHeading(title: 'Genres'),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: movie.genres
                    .map((genre) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppAssets.gray,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            genre,
                            style: TextStyle(
                              color: AppAssets.white,
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppAssets.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
          ),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: AppAssets.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: AppAssets.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
