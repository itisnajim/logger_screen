# Logger Screen

![Pub Version](https://img.shields.io/pub/v/logger_screen)
![License](https://img.shields.io/github/license/itisnajim/logger_screen)

**Logger Screen** is a Flutter package that provides a user-friendly UI for displaying logs with filtering and searching capabilities. It's designed to work seamlessly with the popular **[Logger](https://pub.dev/packages/logger)** package.

![preview](https://raw.githubusercontent.com/itisnajim/logger_screen/main/example/logger_screen.jpg)

## Installation

Run the following command in your flutter project:

```bash
flutter pub add logger_screen
```

## Usage

1. Import the package:
```dart
import 'package:logger_screen/logger_screen.dart';
```

2. Create an instance of `LoggerScreenPrinter`:
```dart
LoggerScreenPrinter myLoggerPrinter = LoggerScreenPrinter(
  fileName: "logs",
  encryptionKey: "my_secret_key",
  printEmojis: true,
);
```

3. Create a `LoggerScreen` widget using the created printer:
```dart
LoggerScreen(
  printer: myLoggerPrinter,
  itemBuilder: (context, log, index) {
    // Customize the appearance of individual log items here
    return MyCustomLogItem(log: log);
  },
  numberOfColumns: 2, // Specify the number of columns in grid layout
  style: Style.platform, // Choose between Style.material, Style.cupertino, or Style.platform
  title: "My Logs", // Set the title of the screen
  trailingActions: [
    IconButton(
      icon: Icon(Icons.clear_all),
      onPressed: () {
        // Clear logs action
        myLoggerPrinter.clear();
      },
    ),
  ],
)
```

4. Start write the logs:
```dart
  final logger = Logger(printer: myLoggerPrinter);
  logger.t("Trace log message");
  logger.d("Debug log message");
  logger.i("Info log message");
  logger.w("Warning log message");
  logger.e("Error log message");
```

## Features
* Display logs with customizable appearance.
* Filter and search logs based on levels and content.
* Clear logs action.
* Customizable log item appearance.
* Support for both single-column and grid layouts.
* Available in Material Design, Cupertino, and platform-specific styles.

## Contribution

Contributions to this package are welcome! If you find any issues or have suggestions, feel free to open an issue or submit a pull request on [GitHub](https://github.com/itisnajim/logger_screen).

## License

logger_screen is available under the MIT license. See the LICENSE file for more info.