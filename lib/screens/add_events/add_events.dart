import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_monday/providers/add_event_provider.dart';
import 'package:todo_c13_monday/widgets/event_category_item.dart';

class AddEventsScreen extends StatelessWidget {
  static const String routeName = "AddEvent";

  AddEventsScreen({super.key});

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
                )
              ],
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