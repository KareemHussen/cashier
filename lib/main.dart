import 'package:cashier/data/local/database.dart';
import 'package:cashier/screens/gain/gain_cubit.dart';
import 'package:cashier/screens/home/home.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:cashier/utils/bloc_observer/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SQLHelper.initDb();
  Bloc.observer = MyBlocObserver();
  /*
  *   full screen code
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async{
    // await windowManager.setSize(const Size(1920, 1080));
    // await windowManager.center();

    await windowManager.setTitleBarStyle(TitleBarStyle.normal );
    await windowManager.setFullScreen(true);
    await windowManager.show();
  });
  * */

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StorageCubit()..getProducts()),
        BlocProvider(create: (context) => GainCubit()..getInvoices()),

      ],
      child: MaterialApp(

          debugShowCheckedModeBanner: false,
          home: ScreenUtilInit(
            designSize: const Size(1920, 1080),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                // You can use the library anywhere in the app even in theme
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: child,
              );
            },
            child: const MyApp(),
          ))));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'أولاد مبروك',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomeScreen(),
    );
  }
}
