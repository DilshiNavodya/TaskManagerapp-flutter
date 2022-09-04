import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taskmanagerapp/utils/app_colors.dart';
import 'package:taskmanagerapp/utils/db_controller.dart';
import 'package:taskmanagerapp/widgets/button_widget.dart';
import 'package:taskmanagerapp/widgets/textfield_widget.dart';
import 'package:get/get.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
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
                  hintText: "Task name",
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  textController: detailsController,
                  hintText: "Task details",
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
                      text: "Add",
                      textColor: Colors.white),
                  onPressed: () async {
                    await DBController.addItem(
                        task_name: nameController.text,
                        description: detailsController.text);
                    nameController.clear();
                    detailsController.clear();
                  },
                ),
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
