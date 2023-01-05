import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Routes/router.dart';
import 'package:sure_move/Presentation/themes/light_themes.dart';

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
    return BlocProvider(
      create: (context) {
        return AuthBloc()..add(AuthInit());
      },
      child: ScreenUtilInit(
        designSize: const Size(360, 740),
        builder: (BuildContext context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Studies Form Builder UD',
          theme: CustomTheme.lightTheme(),

          onGenerateRoute: router.generateRoute,

        ),
      ),
    );


  }

}




