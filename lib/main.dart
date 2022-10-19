import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Commons/colors.dart';
import 'package:sure_move/Routes/router.dart';
import 'package:sure_move/themes/light_themes.dart';

void main() {
  runApp( MyApp(router: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router}) : super(key: key);
  final AppRouter router;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /* Sets the statusBar colour of the app */
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kOrangeColor,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(360, 740),
      builder: (BuildContext context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Studies Form Builder UD',
        theme: CustomTheme.lightTheme(),

        onGenerateRoute: router.generateRoute,

      ),
    );


  }

}




