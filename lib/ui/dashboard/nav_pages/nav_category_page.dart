import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../all bloc/category_bloc/category_bloc.dart';
import '../../all bloc/category_bloc/category_event.dart';
import '../../all bloc/category_bloc/category_state.dart';

class NavCategoryPage extends StatefulWidget {
  const NavCategoryPage({super.key});

  @override
  State<NavCategoryPage> createState() => _NavCategoryPageState();
}

class _NavCategoryPageState extends State<NavCategoryPage> {

  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchCategoryEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryBloc,CategoryState>(
          builder: (_,state){
            if(state is CategoryLoadingState){
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if(state is CategoryLoadedState){
              return ListView.builder(
                itemCount: state.allCategory.length,
                itemBuilder: (_,index){
                  var data = state.allCategory[index];
                  return ListTile(
                    title: Text(data.name),
                  );
                },
              );
            }
            if(state is CategoryFailureState){
              return Center(child: Text(state.errorMsg),);
            }
            return Container();
          }
      ),
    );
  }
}
