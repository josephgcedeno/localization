// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            forcedLocale: const Locale('en'),
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      builder: FlutterI18n.rootAppBuilder(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHomePage> {
  int clicked = 0;

  incrementCounter() {
    setState(() {
      clicked++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlutterI18n.translate(context, "title ni"))),
      body: Column(
        children: <Widget>[
          Text(FlutterI18n.translate(context, "new word separated")),
          Text(FlutterI18n.translate(context, "The title")),
          Text(FlutterI18n.translate(context, "JUSTICE LEAGUE")),
          Text(FlutterI18n.translate(
              context, "What are 10 examples sentences?")),
          Builder(
            builder: (BuildContext context) => StreamBuilder<bool>(
              initialData: true,
              stream: FlutterI18n.retrieveLoadedStream(context),
              builder: (BuildContext context, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    I18nText(
                      "message",
                    ),
                    TextButton(
                      key: const Key('changeLanguage'),
                      onPressed: () async {
                        final Locale? currentLang =
                            FlutterI18n.currentLocale(context);
                        await FlutterI18n.refresh(
                            context,
                            currentLang!.languageCode == 'en'
                                ? const Locale('fr')
                                : const Locale('en'));

                        setState(() {});
                      },
                      child: const Text("Toggle language change"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
