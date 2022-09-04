import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taskmanagerapp/utils/app_colors.dart';
import 'package:taskmanagerapp/widgets/button_widget.dart';
import 'package:taskmanagerapp/widgets/textfield_widget.dart';
import 'package:taskmanagerapp/utils/db_controller.dart';
import 'package:get/get.dart';

class EditTask extends StatelessWidget {
  final String currentTaskname;
  final String currentDescription;
  final String currentId;
  const EditTask(
      {Key? key,
      required this.currentTaskname,
      required this.currentDescription,
      required this.currentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: currentTaskname);
    TextEditingController detailsController =
        TextEditingController(text: currentDescription);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/addtask1.jpg"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFieldWidget(
                  textController: nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  textController: detailsController,
                  borderRadius: 15,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    primary: Colors.transparent,
                  ),
                  child: ButtonWidget(
                      backgroundcolor: AppColors.mainColor,
                      text: "Edit",
                      textColor: Colors.white),
                  onPressed: () async {
                    await DBController.updateItem(
                      task_name: nameController.text,
                      description: detailsController.text,
                      taskId: currentId,
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1000,
            )
          ],
        ),
      ),
    );
  }
}
