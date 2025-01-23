import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_c13_monday/models/task_model.dart';
import 'package:todo_c13_monday/models/user_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  static Future<void> addEvent(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id; // jqVCX3JiTbtxTqdF8H5d
    return docRef.set(task);
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Stream<QuerySnapshot<TaskModel>> getEvents(String categoryName) {
    var collection = getTaskCollection();
    if (categoryName == "All") {
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("date", descending: false)
          .snapshots();
    } else {
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("category", isEqualTo: categoryName)
          .orderBy("date", descending: false)
          .snapshots();
    }
  }

  static Future<UserModel?> readUser() async {
    var collection = getUsersCollection();
    DocumentSnapshot<UserModel> docRef =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docRef.data();
  }

  static Future<void> deleteEvent(String id) {
    var collection = getTaskCollection();

    return collection.doc(id).delete();
  }

  static Future<void> updateEvent(TaskModel task) {
    var collection = getTaskCollection();

    return collection.doc(task.id).update(task.toJson());
  }

  static Future<void> createAccount(
      String name,
      String emailAddress,
      String password,
      Function onLoading,
      Function onSuccess,
      Function onError) async {
    try {
      onLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      onError("Something went wrong");

      print(e);
    }
  }

  static Future<void> login(
    String email,
    String password,
    Function onLoading,
    Function onSuccess,
    Function onError,
  ) async {
    try {
      onLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // if (credential.user!.emailVerified) {
      onSuccess();
      // } else {
      //   onError("Please verify your mail , check your mail");
      // }
    } on FirebaseAuthException catch (e) {
      onError("Wrong Email or Password");
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
