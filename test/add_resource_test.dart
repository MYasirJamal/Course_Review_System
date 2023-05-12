import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('Adding review validation', (WidgetTester tester) async {
    CollectionReference resources =
        FirebaseFirestore.instance.collection('reviews');
    await resources.add({
      'approvedOn': null,
      'course': "Test course",
      'resource': "Test resource",
      'description': "Some description",
      'status': 'Pending',
      'userEmail': "s0001@example.com",
    });

    String? courseName;

    FirebaseFirestore.instance
        .collection("reviews")
        .where("course", isEqualTo: "Test course")
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          courseName = docSnapshot.data()['name'];
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    expect("Test resource", courseName);
    expect("Wrong resource", courseName);
  });
}
