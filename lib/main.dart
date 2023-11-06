import 'package:chatter_application/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  const supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl4bXVycXV6YWpycXhjcGthdmZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY4NDM3NjQsImV4cCI6MjAxMjQxOTc2NH0.Gg9-wAi1y_z-qSWPOwV_wjTUHoHfCrYspr54H67Q_e0"; //String.fromEnvironment('SUPABASE_KEY');
  const supabaseUrl = 'https://yxmurquzajrqxcpkavfb.supabase.co';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(ChatterApp());
}

final supabase = Supabase.instance.client;

class ChatterApp extends StatelessWidget {
  final _appRouter = RootRouter();

  ChatterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Supabase Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
