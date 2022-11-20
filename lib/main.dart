// Don't forget to make the changes mentioned in
// https://github.com/bitsdojo/bitsdojo_window#getting-started

import 'package:newJoyo/provider/trigger.dart';
import 'package:newJoyo/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'provider/object.dart';

late ObjectBox objectBox;
void main() async {
  objectBox = await ObjectBox.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Trigger()),
      ],
      child: const MyApp(),
    ),
  );
  initializeDateFormatting();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1366, 768);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "JoyoTomo";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 79, 117, 134))),
            ),
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 79, 117, 134)),
            buttonTheme: const ButtonThemeData(
                buttonColor: Color.fromARGB(255, 79, 117, 134)),
            inputDecorationTheme: InputDecorationTheme(
        //        border: InputBorder.none,
        // focusedBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        // errorBorder: InputBorder.none, 
        // disabledBorder: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              fillColor: Colors.white,
              hintStyle: TextStyle(
                  color: Colors.grey.shade600, fontSize: 15, height: 2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color:  Color.fromARGB(255, 79, 117, 134)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color:  Color.fromARGB(255, 79, 117, 134)),
              ),
            ),
            primaryColor: Colors.green,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: const Color.fromARGB(255, 79, 117, 134))),
        debugShowCheckedModeBanner: false,
        home: const Side());
  }
}
