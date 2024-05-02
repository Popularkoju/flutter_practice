import 'package:flutter/material.dart';
import 'package:flutter_practice/clipper/custom_clipper_container.dart';
import 'package:flutter_practice/components/cube_transition.dart';
import 'package:flutter_practice/screens/scroll_progress.dart';
import 'package:flutter_practice/video_trimmer/raw_video_file.dart';
import 'package:flutter_practice/video_trimmer/video_downloader.dart';
import 'package:flutter_practice/video_trimmer/video_screen.dart';
import 'package:flutter_practice/video_trimmer/video_trimmer.dart';
import 'package:provider/provider.dart';

import 'components/bottom_sheet.dart';
import 'components/new_bt_sheet.dart';
import 'components/page_view_transition.dart';
import 'gemini/gemini.dart';
// import 'package:permission_handler/permission_handler.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> BottomSheetManagement()),
      ]
      ,child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CubeTrasitionDemo()


      // RhombusContainer( width: 200, height: 200, color: Colors.brown,),





      // home:  MyHomePage(title: "popular"),
    );

  }
}
