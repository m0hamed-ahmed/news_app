import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingControllerSearch = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildTextFormField(
                    textEditingController: textEditingControllerSearch,
                    textInputType: TextInputType.text,
                    labelText: 'Search',
                    prefixIcon: Icons.search,
                    onChanged: (val) => cubit.getSearch(val)
                ),
              ),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => buildArticleItem(cubit.search[index], context),
                  itemCount: cubit.search.length
                )
              )
            ],
          ),
        );
      },
    );
  }
}
