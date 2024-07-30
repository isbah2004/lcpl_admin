import 'package:flutter/material.dart';
import 'package:lcpl_admin/provider/upload_provider.dart';
import 'package:lcpl_admin/reusablewidgets/reusable_button.dart';
import 'package:lcpl_admin/reusablewidgets/reusable_text_field.dart';
import 'package:lcpl_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class AddFile extends StatefulWidget {
  final String appBartitle, collection;
  const AddFile(
      {super.key, required this.appBartitle, required this.collection});

  @override
  State<AddFile> createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {
  final TextEditingController titleController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<UploadProvider>(
            builder:
                (BuildContext context, UploadProvider value, Widget? child) {
              return GestureDetector(
                onTap: () {
                  if (titleController.text.isEmpty) {
                    Utils.toastMessage(message: 'Please enter title');
                  } else {
                    value.uploadFile(
                        context: context,
                        collection: widget.collection,
                        title: titleController.text);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: value.uploadLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.done),
                ),
              );
            },
          )
        ],
        title: Text(widget.appBartitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableTextField(
            hintText: 'Title',
            controller: titleController,
            keyboardType: TextInputType.text,
            prefix: const Icon(Icons.title_rounded),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer<UploadProvider>(
            builder:
                (BuildContext context, UploadProvider value, Widget? child) {
              return Column(
                children: [
                  value.file == null
                      ? const SizedBox()
                      : Text(
                          textAlign: TextAlign.center,
                          value.file!.path.split('/').last,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableButton(
                      title: 'Pick File',
                      onTap: value.pickFile,
                      loading: value.pickerLoading),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
