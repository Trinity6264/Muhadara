import 'package:flutter/material.dart';

import 'package:muhadara/model/post_content_model.dart';
import 'package:muhadara/shared/collor_pallet.dart';
import 'package:muhadara/view_models/view_all_view_model.dart';
import 'package:stacked/stacked.dart';

class ViewAllView extends StatelessWidget {
  final List<PostContentModel>? content;
  const ViewAllView({
    Key? key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ViewModelBuilder<ViewAllViewModel>.reactive(
      viewModelBuilder: () => ViewAllViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.greenAccent[100],
          appBar: AppBar(
            title: const Text('View All'),
            automaticallyImplyLeading: false,
            elevation: 0.0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'All Lectures',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: content?.length ?? 1,
                  itemBuilder: (context, index) {
                    final data = content?[index];
                    return ListTile(
                      leading: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          data!.imageurl!,
                          height: _size.height * 0.1,
                          width: _size.width * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        data.lecturerName.toString(),
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        data.lectureTitle.toString(),
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          model.openFiless(
                            data.audioUrl!,
                            '${data.lecturerName}.mp3',
                          );
                        },
                        icon: const Icon(
                          Icons.download_for_offline_outlined,
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
