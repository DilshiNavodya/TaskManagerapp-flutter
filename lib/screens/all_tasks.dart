import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taskmanagerapp/utils/app_colors.dart';
import 'package:taskmanagerapp/utils/db_controller.dart';
import 'package:taskmanagerapp/widgets/button_widget.dart';
import 'package:taskmanagerapp/widgets/task_widget.dart';
import 'package:get/get.dart';
import 'package:taskmanagerapp/screens/edit_task.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List taskList = ["Flutter Project", "React native"];
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253).withOpacity(0.5),
      alignment: Alignment.centerLeft,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.redAccent.withOpacity(0.5),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
            padding: const EdgeInsets.only(left: 10, top: 60),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/alltasks.jpg"))),
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.secondaryColor,
              ),
            )),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(children: [
            Icon(
              Icons.home,
              color: AppColors.secondaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.5),
                  color: Colors.black54),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.calendar_month_sharp,
              color: AppColors.secondaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "2",
              style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
            ),
          ]),
        ),
        Flexible(
            child: StreamBuilder(
                stream: DBController.readItems(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          String documentId =
                              streamSnapshot.data!.docs[index].id;
                          return Dismissible(
                            background: leftEditIcon,
                            secondaryBackground: rightDeleteIcon,
                            onDismissed: (DismissDirection direction) {},
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF2e3253)
                                                .withOpacity(0.4),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ButtonWidget(
                                                    backgroundcolor:
                                                        AppColors.mainColor,
                                                    text: "View",
                                                    textColor: Colors.white),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () => EditTask(
                                                              currentTaskname:
                                                                  documentSnapshot[
                                                                      'task_name'],
                                                              currentDescription:
                                                                  documentSnapshot[
                                                                      'description'],
                                                              currentId:
                                                                  documentId,
                                                            ),
                                                        transition:
                                                            Transition.fade,
                                                        duration:
                                                            const Duration(
                                                                seconds: 1));
                                                  },
                                                  child: ButtonWidget(
                                                      backgroundcolor:
                                                          AppColors.mainColor,
                                                      text: "Edit  ",
                                                      textColor: Colors.white),
                                                )
                                              ]),
                                        ),
                                      );
                                    });
                                return false;
                              } else {
                                return Future.delayed(
                                    const Duration(seconds: 1),
                                    () =>
                                        direction ==
                                        DismissDirection.endToStart);
                              }
                            },
                            key: ObjectKey(index),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: TaskWidget(
                                text: documentSnapshot['task_name'],
                                color: Colors.blueGrey,
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })),
      ]),
    );
  }
}
