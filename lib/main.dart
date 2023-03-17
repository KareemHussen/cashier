import 'package:cashier/data/local/database.dart';
import 'package:cashier/screens/home/home.dart';
import 'package:cashier/screens/storage/storage.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:cashier/utils/bloc_observer/bloc_observer.dart';
import 'package:cashier/Invoice/invoice_cubit.dart';
import 'package:cashier/utils/prtint/print_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLHelper.initDb();
  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StorageCubit()..getProducts()),
        BlocProvider(create: (context) => InvoiceCubit()..getInvoice()),

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
