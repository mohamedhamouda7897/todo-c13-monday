import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_monday/firebase/firebase_manager.dart';
import 'package:todo_c13_monday/models/task_model.dart';
import 'package:todo_c13_monday/providers/add_event_provider.dart';
import 'package:todo_c13_monday/widgets/event_category_item.dart';

class AddEventsScreen extends StatelessWidget {
  static const String routeName = "AddEvent";

  AddEventsScreen({super.key});

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  var textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEventProvider(),
      builder: (context, child) {
        var provider = Provider.of<AddEventProvider>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Create Event",
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Image.asset(
                      "assets/images/${provider.imageName}.png",
                      height: 225,
                    ),
                  ),
                  Container(
                    height: 44,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.changeEventCategory(index);
                          },
                          child: EventCategoryItem(
                            title: provider.eventsCategories[index],
                            isSelected: provider.eventsCategories[index] ==
                                provider.selectedEventName,
                          ),
                        );
                      },
                      itemCount: provider.eventsCategoriesLength,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    key: textKey,
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Date"),
                      InkWell(
                        onTap: () async {
                          var chosenDate = await showDatePicker(
                              context: context,
                              initialDate: provider.selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                Duration(days: 365),
                              ));

                          if (chosenDate != null) {
                            provider.changeSelectedDate(chosenDate);
                          }
                        },
                        child: Text(
                          provider.selectedDate.toString().substring(0, 10),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        TaskModel task = TaskModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            date: provider.selectedDate.millisecondsSinceEpoch,
                            category: provider.imageName,
                            title: titleController.text,
                            description: descriptionController.text);
                        FirebaseManager.addEvent(task);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      child: Text("Add Event",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Select all FROM TABLE_NAME
/// INSERT INTO TABLE_NAME
/// DELETE
/// UPDATE
///
///
/// SQFLite  vs SQL
///
/// flutterfire configure --project=todo-c13-monday --android-app-id=com.example.todo_c13_monday
