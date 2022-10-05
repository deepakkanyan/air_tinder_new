import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/provider/flight_details/flight_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
UserDetailModel userDetailModel = UserDetailModel.instance;
