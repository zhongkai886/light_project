import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_project/snackBar/bloc/data_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<DataBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('snackBar')),
      body: BlocListener<DataBloc, DataState>(
        listener: (context, state) {
          if (state is Success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Success'),
              ),
            );
          }
        },
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if (state is Initial) {
              return const Center(child: Text('Press the Button'));
            }
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is Success) {
              return const Center(child: Text('Success'));
            }
            return const Center(child: Text('error'));
          },
        ),
      ),
      floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.play_arrow),
              onPressed: () => dataBloc.add(
                FetchData(),
              ),
            )
          ]),
    );
  }
}
