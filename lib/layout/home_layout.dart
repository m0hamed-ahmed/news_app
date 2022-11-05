import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));},
                icon: const Icon(Icons.search)
              ),
              IconButton(
                onPressed: () => cubit.changeThemeMode(),
                icon: const Icon(Icons.brightness_4_outlined)
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavigationBarItems,
            onTap: (index) => cubit.changeBottomNavBar(index),
          ),
        );
      },
    );
  }
}