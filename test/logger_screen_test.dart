import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:logger_screen/logger_screen.dart';

void main() {
  group('LoggerScreenPrinter', () {
    test('Adding logs and retrieving logsStream', () async {
      final printer = LoggerScreenPrinter();
      final logger = Logger(printer: printer);

      final logEvent = LogEvent(
        Level.trace,
        'Test log message',
      );

      final logsStream = printer.logsStream;

      Future.delayed(const Duration(milliseconds: 200), () {
        logger.log(logEvent.level, logEvent.message);
      });

      await expectLater(logsStream, emits(predicate<Log>((value) {
        expect(value.message, logEvent.message);
        return true;
      })));
    });
  });

  group('LoggerScreen', () {
    testWidgets('Displaying logs on the UI', (WidgetTester tester) async {
      final printer = LoggerScreenPrinter();
      final logger = Logger(printer: printer);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(child: LoggerScreen(printer: printer)),
        ),
      );

      logger.log(Level.trace, 'Test log message');
      await tester.pump();

      expect(find.text('Test log message'), findsOneWidget);
    });
  });
}
