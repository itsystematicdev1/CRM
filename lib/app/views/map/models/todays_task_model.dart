import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String description;
  final GeoPoint location;

  Task({required this.description, required this.location});
}
