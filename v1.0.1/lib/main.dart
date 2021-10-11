import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/nav/bottom_nav_screen.dart';
import 'screens/random_recipe/bloc/random_recipe_bloc.dart';
import 'screens/random_recipe/random_recipe_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('Favorite');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Satoshi',
        primarySwatch: Colors.blue,
        primaryColor: Colors.redAccent,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'Telma',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
      ),
      home: BottomNavView(),
      // home: BlocProvider(
      //   create: (context) => RandomRecipeBloc(),
      //   child: const RandomRecipe(),
      // ),
    );
  }
}
