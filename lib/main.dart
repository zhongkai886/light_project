import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_project/navigation/bloc/navigation_bloc.dart';
import 'package:light_project/navigation/navigation_view.dart';
import 'package:light_project/snackBar/bloc/data_bloc.dart';
import 'package:light_project/snackBar/snack_bar.dart';
import 'package:light_project/src/routerPage.dart';
import 'package:light_project/src/timerBloc/timerPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loginResponse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RouterPage(),
        '/reCut': (context) => const MyHomePage(
              title: 'The縮',
            ),
        '/timer': (context) => const TimerPage(),
        '/snackBar': (context) => BlocProvider(
              create: (context) => DataBloc(),
              child: const Home(),
            ),
        '/navigation': (context) => BlocProvider(
              create: (context) => NavigationBloc(),
              child: const NavigationView(),
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final textEditingController = TextEditingController();
  String shortText = '';
  final dio = Dio();

  @override
  void initState() {
    dio.options.baseUrl = 'https://api.recut.fun/api';
    super.initState();
  }

  void login() async {
    try {
      final res = await dio.post(
        '/user/login',
        data: {
          'userId': 'string',
          'userPassword': 'string',
        },
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
        ),
      );
      LoginResponse a = LoginResponse.fromJson(res.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void shortUrl() async {
    try {
      final res = await dio.post(
        '/short',
        data: {
          "leadUrl": textEditingController.text,
        },
        options: Options(
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
        ),
      );
      setState(() {
        shortText = '${res.data['shortUrl']}';
      });

      print(res.data['shortUrl']);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: textEditingController..text = '',
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_balance),
                  hintText: 'https://1234.com',
                  labelText: '原始網址 *',
                ),
                onSaved: (String? value) {
                  print(value);
                },
                validator: (String? value) {
                  return null;
                },
              ),
              TextFormField(
                // controller: textEditingController..text = '',
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_balance),
                  hintText: '3 days',
                  labelText: '有效時間 *',
                ),
                onSaved: (String? value) {
                  print(value);
                },
                validator: (String? value) {
                  return null;
                },
              ),
              TextFormField(
                // controller: textEditingController..text = '',
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_balance),
                  hintText: '0000',
                  labelText: '設定密碼 ',
                ),
                onSaved: (String? value) {
                  print(value);
                },
                validator: (String? value) {
                  return null;
                },
              ),
              const SizedBox(height: 10),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'https://recut.fun/$shortText',
                      style: TextStyle(fontSize: 25),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() async {
                          _launchInBrowser(
                            Uri(
                                scheme: 'https',
                                host: 'recut.fun',
                                path: shortText),
                          );
                        })
                        ..onSecondaryTap = (() async {
                          print('secondartTap');
                          await Clipboard.setData(ClipboardData(
                              text: "https://recut.fun/$shortText"));
                        }),
                    ),
                    // WidgetSpan(
                    //   child: Container(
                    //     width: 20,
                    //     height: 30,
                    //     color: Colors.red,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // SelectableText(
              //   shortText,
              //   style: const TextStyle(fontSize: 26),
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: shortUrl,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
