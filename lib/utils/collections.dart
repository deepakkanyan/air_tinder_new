import 'package:air_tinder/utils/instances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference profiles = fireStore.collection('Profiles');
CollectionReference chatRooms = fireStore.collection('ChatRooms');
CollectionReference likes = fireStore.collection('Likes');

