import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/app_assets.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_card.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BrowseTab(),
  ));
}

class BrowseTab extends StatefulWidget {
  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<Movie> movies = [];
  final List<String> categories = [
    "Action",
    "Comedy",
    "Drama",
    "Horror",
    "Sci-Fi"
  ];
  String selectedCategory = "Action";

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://yts.mx/api/v2/list_movies.json?limit=10&genre=$selectedCategory'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final moviesList = data['data']['movies'] as List;
      setState(() {
        movies = moviesList.map((movie) => Movie.fromJson(movie)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppAssets.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: ChoiceChip(
                      label: Text(category,
                          style: TextStyle(color: AppAssets.black)),
                      selected: selectedCategory == category,
                      selectedColor: AppAssets.primary,
                      backgroundColor: Colors.grey[300],
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                          fetchMovies();
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) =>
                        MovieCard(movie: movies[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String movieTitle;

  VideoPlayerScreen(this.videoUrl, this.movieTitle);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isBuffering = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isBuffering = false;
            _controller.setLooping(true);
            _controller.play();
          });
        }
      }).catchError((error) {
        print("خطأ في تحميل الفيديو: $error");
      });

    _controller.addListener(() {
      if (!_controller.value.isBuffering && _isBuffering) {
        if (mounted) {
          setState(() {
            _isBuffering = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppAssets.black,
      appBar:
          AppBar(backgroundColor: AppAssets.black, title: Text("Now Playing")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : CircularProgressIndicator(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: () {
                _controller
                    .seekTo(_controller.value.position - Duration(seconds: 10));
              },
              child: Icon(Icons.replay_10),
            ),
          ),
          Positioned(
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: AppAssets.primary,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: () {
                _controller
                    .seekTo(_controller.value.position + Duration(seconds: 10));
              },
              child: Icon(Icons.forward_10),
            ),
          ),
        ],
      ),
    );
  }
}
