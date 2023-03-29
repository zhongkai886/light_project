import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_project/navigation/bloc/navigation_bloc.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => PageA(),
        '/pageB': (context) => PageB(),
      },
      initialRoute: '/',

      // body:
      // BlocBuilder<NavigationBloc, NavigationState>(
      //   builder: (context, state) => state is StateA ? PageA() : PageB(),
      // ),
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is StateB) {
          Navigator.of(context).pushNamed('/pageB');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Page A')),
        body: Center(
          child: ElevatedButton(
              onPressed: () => context.read<NavigationBloc>().add(EventB()),
              child: Text('Go to PageB')),
        ),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is StateA) {
          Navigator.of(context).pushNamed('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Page B')),
        body: Center(
          child: ElevatedButton(
              onPressed: () => context.read<NavigationBloc>().add(EventA()),
              child: Text('Go to PageA')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
