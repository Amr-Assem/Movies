import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/browse_cubit.dart';
import 'package:movies_app/core/app_assets.dart';
import 'package:movies_app/cubit/movie_cubit.dart';
import 'package:movies_app/widgets/movie_card.dart';
import 'package:movies_app/cubit/states.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseCubit()..fetchMovies('Action'),
      child: BrowseView(),
    );
  }
}

class BrowseView extends StatelessWidget {
  final List<String> categories = const [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Thriller',
    'Adventure',
    'Animation',
    'Biography',
    'Crime',
    'Documentary',
    'Family',
    'Fantasy',
    'History',
    'Mystery',
    'Sci-Fi',
    'Sport',
    'War',
    'Western',
  ];

  const BrowseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppAssets.black,
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 50,
            child: BlocBuilder<BrowseCubit, BrowseState>(
              builder: (context, state) {
                final currentCategory =
                    state is BrowseLoaded ? state.currentCategory : 'All';

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == currentCategory;

                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(category),
                        onSelected: (_) {
                          context.read<BrowseCubit>().changeCategory(category);
                        },
                        backgroundColor: AppAssets.gray,
                        selectedColor: AppAssets.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Movies Grid
          Expanded(
            child: BlocBuilder<BrowseCubit, BrowseState>(
              builder: (context, state) {
                if (state is BrowseLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is BrowseError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (state is BrowseLoaded) {
                  return GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: state.movies[index]);
                    },
                  );
                }

                return Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
