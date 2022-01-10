import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/shared/search_input_decor.dart';
import 'package:muhadara/views/widgets/search_view.form.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'search'),
])
class SearchView extends StatelessWidget with $SearchView {
  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        key: const PageStorageKey('searchView'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.1 / 2.2,
                    child: TextField(
                      decoration: searchInputDecor.copyWith(
                        prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              searchFocusNode.unfocus();
                              print(searchController.text);
                              searchController.clear();
                            }),
                      ),
                      controller: searchController,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
              child: Text(
                'Recent Searches',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
