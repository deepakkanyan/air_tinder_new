import 'package:air_tinder/model/complete_profile_model/what_makes_you_happy_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/provider/chat_provider/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
UserDetailModel userDetailModel = UserDetailModel.instance;
InterestModels interestModels = InterestModels.instance;
ChatProvider chatProvider = ChatProvider.instance;
