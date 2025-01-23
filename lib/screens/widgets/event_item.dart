import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_c13_monday/firebase/firebase_manager.dart';
import 'package:todo_c13_monday/models/task_model.dart';

class EventItem extends StatelessWidget {
  TaskModel taskModel;

  EventItem({required this.taskModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
      child: Container(
        height: 260,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/${taskModel.category}.png",
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Text(taskModel.title),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          )),
                      IconButton(
                          onPressed: () {
                            FirebaseManager.deleteEvent(taskModel.id);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 8, top: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateTime.fromMillisecondsSinceEpoch(taskModel.date)
                        .toString()
                        .substring(8, 10),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    DateFormat.MMM().format(
                        DateTime.fromMillisecondsSinceEpoch(taskModel.date)),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
