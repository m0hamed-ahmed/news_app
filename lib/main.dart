import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isThemeModeDark = CacheHelper.getData('isThemeModeDark')??true;
  BlocOverrides.runZoned(
    () => runApp(MyApp(isThemeModeDark)),
    blocObserver: MyBlocObserver()
  );
}

class MyApp extends StatelessWidget {
  final bool isThemeModeDark;

  const MyApp(this.isThemeModeDark, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getBusiness()..getSports()..getScience()..changeThemeMode(fromShared: isThemeModeDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
                      elevation: 0,
                      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      iconTheme: IconThemeData(color: Colors.black)
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20,
                      backgroundColor: Colors.white
                  ),
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)
                  )
              ),
              darkTheme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: const Color.fromRGBO(39, 38, 39, 1),
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Color.fromRGBO(39, 38, 39, 1),
                      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(39, 38, 39, 1), statusBarIconBrightness: Brightness.light),
                      elevation: 0,
                      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      iconTheme: IconThemeData(color: Colors.white)
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20,
                      backgroundColor: Color.fromRGBO(39, 38, 39, 1)
                  ),
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)
                  )
              ),
              themeMode: cubit.isThemeModeDark ? ThemeMode.dark : ThemeMode.light,
              home: const HomeLayout()
          );
    },
      )
    );
  }
}