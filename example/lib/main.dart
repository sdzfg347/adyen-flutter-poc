// ignore_for_file: unused_local_variable

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout_example/network/service.dart';
import 'package:adyen_checkout_example/repositories/adyen_card_component_repository.dart';
import 'package:adyen_checkout_example/screens/component/card/card_component_scrollable_screen.dart';
import 'package:adyen_checkout_example/screens/cse/cse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  final service = Service();
  final adyenCardComponentRepository = AdyenCardComponentRepository(service: service);

  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en')],
    theme: ThemeData(
        useMaterial3: true,
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        )),
    routes: {
      '/': (context) => const MyApp(),
      '/cardAdvancedComponentScreen': (context) => CardComponentScrollableScreen(
            repository: AdyenCardComponentRepository(service: service),
          ),
      '/clientSideEncryption': (context) => CseScreen(),
    },
    initialRoute: "/",
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AdyenCheckout.instance.enableConsoleLogging(enabled: false);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('POC Adyen Checkout Plugin')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () => Navigator.pushNamed(context, "/cardAdvancedComponentScreen"), child: const Text("Custom Card UI")),
            TextButton(onPressed: () => Navigator.pushNamed(context, "/clientSideEncryption"), child: const Text("Card encryption"))
          ],
        ),
      ),
    );
  }
}
