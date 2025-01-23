import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_monday/firebase/firebase_manager.dart';
import 'package:todo_c13_monday/models/task_model.dart';
import 'package:todo_c13_monday/providers/user_provider.dart';
import 'package:todo_c13_monday/screens/widgets/event_item.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> eventsCategories = [
    "All",
    "birthday",
    "book_club",
    "eating",
    "exhibtion",
    "gaming",
    "holiday",
    "sport",
    "workshop",
    "meeting",
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 174,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back ✨",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            Text(
              userProvider.userModel?.name ?? "null",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on),
                Text(
                  "Cairo , Egypt",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  width: 16,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedCategory = index;

                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: selectedCategory != index
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(18)),
                      child: Text(
                        eventsCategories[index],
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: selectedCategory == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: eventsCategories.length,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sunny,
                color: Colors.white,
              )),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Text(
              "EN",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<TaskModel>>(
        stream: FirebaseManager.getEvents(eventsCategories[selectedCategory]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return EventItem(
                          taskModel: snapshot.data!.docs[index].data(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: snapshot.data?.docs.length ?? 0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
