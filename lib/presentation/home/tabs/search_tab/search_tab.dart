import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/reusable_components/custom_text_from_field.dart';
import 'package:movies_app/presentation/home/tabs/search_tab/search_viewModel.dart';
import '../../../../core/DI/di.dart';
import '../../../../core/reusable_components/long_movie_card_widget.dart';

class SearchTab extends StatefulWidget {
  SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late TextEditingController textCon;

  @override
  void initState() {
    super.initState();
    textCon = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: REdgeInsets.all(10.0),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: textCon,
            decoration: InputDecoration(
              hintText: 'Search for movies...',
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: REdgeInsets.all(8.0),
                child: InkWell(
                    onTap: (){
                      SearchViewModel.get(context).search(textCon.text);
                    },
                    child: const Icon(Icons.search,color: Colors.white,)),
              ),
            ),
          ),
        ),
        BlocBuilder<SearchViewModel, SearchState>(
          builder: (context, state) {
            if (state is SearchSuccessState) {
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: REdgeInsets.all(8.0),
                        child: LongMovieCardWidget(
                            movie: state.moviesList![index]),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                          color: Colors.white.withOpacity(0.4),
                          height: 1.h,
                          width: double.infinity,
                        ),
                    itemCount: state.moviesList!.length),
              );
            } else if (state is SearchErrorState) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            }
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie,color: Colors.white,size: 130,),
                  SizedBox(height: 12.h,),
                  Text("No Movies Found",style: TextStyle(color: Colors.white,fontSize: 20.sp),)
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

/*TextField(
                style: TextStyle(color: Colors.white),
                controller: textCon,
                decoration: InputDecoration(
                  hintText: 'Search for movies...',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: Padding(
                    padding: REdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: (){
                          SearchViewModel.get(context).search(textCon.text);
                        },
                        child: Icon(Icons.search)),
                  ),
                ),
              )*/
