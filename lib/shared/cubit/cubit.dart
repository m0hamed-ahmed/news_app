import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  bool isThemeModeDark = false;
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science'
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  void changeThemeMode({bool fromShared}) {
    if(fromShared == null) {
      isThemeModeDark = !isThemeModeDark;
      CacheHelper.setData('isThemeModeDark', isThemeModeDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }
    else {
      isThemeModeDark = fromShared;
      emit(AppChangeThemeModeState());
    }
  }

  void getBusiness() {
    emit(AppGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '73c9e552d6fa4bb98cd8c07720933337',
      }
    ).then((value) {
      business = value.data['articles'];
      emit(AppGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(AppGetSportsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '73c9e552d6fa4bb98cd8c07720933337',
        }
    ).then((value) {
      sports = value.data['articles'];
      emit(AppGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSportsErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(AppGetScienceLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '73c9e552d6fa4bb98cd8c07720933337',
        }
    ).then((value) {
      science = value.data['articles'];
      emit(AppGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetScienceErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(AppGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '73c9e552d6fa4bb98cd8c07720933337',
      }
    ).then((value) {
      search = value.data['articles'];
      emit(AppGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }
}