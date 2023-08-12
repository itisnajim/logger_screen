import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:logger_screen/logger_screen.dart';

import 'logger_screen_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: MaterialBasedCupertinoThemeData(materialTheme: themeData),
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final printer = LoggerScreenPrinter(
    fileName: 'logs',
    encryptionKey: 'ThisIsAnExampleEncryptionKey123',
  );
  late Logger logger;
  bool _initialized = false;

  Future<void> _printRandomLogs(Logger logger) async {
    for (var count = 0; count < 10; count++) {
      final randomLevel =
          Log.usedLevelValues[Random().nextInt(Log.usedLevelValues.length)];
      final randomMessage = 'Random log #$count ${randomLevel.name}';
      logger.log(randomLevel, randomMessage);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void initState() {
    super.initState();
    logger = Logger(printer: printer);
    if (!_initialized) {
      _printRandomLogs(logger);
    }
    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    void openWithStyle(ScreenStyle screenStyle) {
      final page = LoggerScreenWrapper(
        screenStyle: screenStyle,
        printer: printer,
      );
      Navigator.push(
        context,
        screenStyle.isCupertino
            ? CupertinoPageRoute(builder: (context) => page)
            : MaterialPageRoute(builder: (context) => page),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Open LoggerScreen with style: '),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () => openWithStyle(ScreenStyle.material),
              child: const Text('Material'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => openWithStyle(ScreenStyle.cupertino),
              child: const Text('Cupertino'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => openWithStyle(ScreenStyle.platform),
              child: const Text('Platform'),
            )
          ],
        ),
      ),
    );
  }
}
