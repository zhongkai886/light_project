import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
// import '../blocs/movies_bloc.dart';
import '../blocs/movies.bloc.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data?.results.length ?? 0,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: ((context) {
                  return Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                            fit: BoxFit.fitHeight,
                          ),
                          Container(
                            color: Colors.black,
                            child: Text(
                              snapshot.data!.results[index].title,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 110,
                        top: 225,
                        child: SizedBox(
                          child: Countup(
                            begin: 0,
                            end: (snapshot.data?.results[index].vote_count ?? 0)
                                .toDouble(),
                            style: TextStyle(fontSize: 28, color: Colors.white),
                            duration: Duration(milliseconds: 2500),
                            separator: ',',
                            curve:Curves.bounceOut
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
              fit: BoxFit.fitHeight,
            ),
          );
        });
  }
}
