import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/shared/search_input_decor.dart';
import 'package:muhadara/view_models/search_view_model.dart';
import 'package:muhadara/views/widgets/search_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'search'),
])
class SearchView extends StatelessWidget with $SearchView {
  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SearchViewModel>.reactive(
      onDispose: (model) {
        searchController.clear();
        searchController.dispose();
      },
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.1 / 2.2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          focusNode: searchFocusNode,
                          decoration: searchInputDecor.copyWith(
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.close, size: 20.0),
                                onPressed: () {
                                  searchFocusNode.unfocus();
                                  searchController.clear();
                                }),
                          ),
                          controller: searchController,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      searchFocusNode.unfocus();
                      model.fetchPost(searchController.text.trim());
                      model.addData(searchController.text.trim());
                    },
                    child: const Text(
                      'Search',
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
              model.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : model.cloudStoreList.isEmpty && model.storeList.isEmpty
                      ? model.cloudStoreList.isEmpty && model.dataReady
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: model.data!.length,
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  final data = model.data![index];
                                  return ListTile(
                                    onTap: () {
                                      model.fetchPost(
                                          data.searchText.toString());
                                    },
                                    title: Text(
                                      data.searchText.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: primaryColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No Data',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: model.cloudStoreList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = model.cloudStoreList[index];
                              return ListTile(
                                onTap: () {
                                  searchFocusNode.unfocus();
                                  model.toPlayer(
                                    audioUrl: data.audioUrl.toString(),
                                    imageurl: data.imageurl.toString(),
                                    lectureTitle: data.lectureTitle.toString(),
                                    lecturerName: data.lecturerName.toString(),
                                    postedAt: data.postedAt!,
                                  );
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    data.imageurl.toString(),
                                    width: size.width * 0.2,
                                    height: size.height * 0.2,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Text(
                                  data.lecturerName.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                subtitle: Text(
                                  data.lectureTitle.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
