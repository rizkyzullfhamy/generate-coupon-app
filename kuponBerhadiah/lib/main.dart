import 'package:flutter/material.dart';
import 'package:kuponberhadiah/view/screen/spalsh_screen.dart';
import 'package:kuponberhadiah/view_model/home_state.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeState()),
    ],
      child: MaterialApp(
      title: 'Kupon_Berhadiah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    ),
    );
  }
}


