import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/biometric_view.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black.withOpacity(0.2),
      statusBarIconBrightness: Brightness.light
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(
      home: BiometricScreen(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      supportedLocales: [
        const Locale('en','US'),
        const Locale('es','ES'),
      ],
    ));
  });
}

