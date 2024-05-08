import 'package:chatgpt_clone/providers/auth_provider.dart';
import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:chatgpt_clone/providers/settings_provider.dart';
import 'package:chatgpt_clone/services/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(),
        darkTheme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            titleSmall: TextStyle(color: Colors.white),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
        ),
        home: const AuthGate(),
      ),
    );
  }
}
