import 'dart:ui';

import 'package:cashier/screens/Invoice/BuyProducts.dart';
import 'package:cashier/screens/gain/gain.dart';
import 'package:cashier/screens/shortfalls/shortfalls.dart';
import 'package:cashier/screens/storage/storage.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late Animation<double> _titleOpacityAnimation;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonOpacityAnimation;

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _titleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _titleAnimationController, curve: Curves.easeInOut),
    );
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _buttonOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _buttonAnimationController, curve: Curves.easeInOut),
    );

    // Set a timer to show the title animation after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _titleAnimationController.forward();
    });

    // Set a timer to show the button animation after 1.5 seconds
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
      _buttonAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<StorageCubit, StorageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: Container(
              width: 1920.w,
              padding: EdgeInsets.all(150.w),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/back.jpg'),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _titleOpacityAnimation,
                    builder: (context, child) => Opacity(
                      opacity: _titleOpacityAnimation.value,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: _isVisible ? 250.h : 0.0,
                        child: Text(
                          'أولاد مبروك',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 72.0.sp,
                              color: Colors.black,
                              fontFamily: 'arab'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 150.0.h),
                  AnimatedBuilder(
                    animation: _buttonOpacityAnimation,
                    builder: (context, child) => Opacity(
                      opacity: _buttonOpacityAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250.w,
                            height: 62.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black38,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Storage()));
                              },
                              child: const Text(
                                'المخزن',
                                style: TextStyle(fontFamily: 'arab'),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0.h),
                          SizedBox(
                            width: 250.w,
                            height: 62.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black38,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Shorfalls()));
                              },
                              child: const Text(
                                'جرد النواقص',
                                style: TextStyle(fontFamily: 'arab'),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0.h),
                          SizedBox(
                            width: 250.w,
                            height: 62.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black38,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductSelectionScreen()));
                              },
                              child: const Text(
                                'إصدار فاتورة',
                                style: TextStyle(fontFamily: 'arab'),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.w),
                          SizedBox(
                            width: 250.w,
                            height: 62.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black38,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Gain()));
                              },
                              child: const Text(
                                'سجل الفواتير',
                                style: TextStyle(fontFamily: 'arab'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }
}
