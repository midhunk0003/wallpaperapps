import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/controller/provider.dart';
import 'package:wallpaperapp/view/category.dart';
import 'package:wallpaperapp/view/homescreen.dart';
import 'package:wallpaperapp/view/homescreensw.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WallpaperProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'wallpaper app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Homescreenw(),
        // home: CategoryScreen(),
      ),
    );
  }
}
