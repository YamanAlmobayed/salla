import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/ui/search/cubit/search_cubit.dart';
import 'package:salla/ui/search/widgets/product_list.dart';
import 'package:salla/utils/utils.dart';

import '../widgets/default_formfield.dart';
import '../widgets/default_separator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SearchCubit(
          shopRepository: context.read<ShopRepository>(),
        ),
        child: Builder(
          builder: (context) => Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DefaultFormField(
                    controller: textController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return 'Type a text to search';
                      }
                      return null;
                    },
                    onSubmit: (String text) {
                      context.read<SearchCubit>().searchProducts(text);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const LinearProgressIndicator();
                      }
                      if (state is SearchSuccess) {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => ProductList(
                                    model:
                                        state.searchResults.data!.data![index],
                                    isSearch: true,
                                  ),
                              separatorBuilder: (context, index) =>
                                  const DefaultSeparator(),
                              itemCount:
                                  state.searchResults.data!.data!.length),
                        );
                      } else if (state is SearchError) {
                        showToast(
                            text: state.errorMessage, state: ToastStates.error);
                        return const SizedBox.shrink();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
