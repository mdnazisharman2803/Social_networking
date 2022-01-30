import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/share_post.dart';


//import 'package:instagram_clone_flutter/screens/feed_screen.dart';
//import 'package:instagram_clone_flutter/screens/profile_screen.dart';
//import 'package:instagram_clone_flutter/screens/search_screen.dart';

const webScreenSize=600;

List<Widget> homeScreenItems = [
 // const FeedScreen(),
 // const SearchScreen(),
 const SharePostScreen(),
 // const Text('notifications'),
//  ProfileScreen(
 //   uid: FirebaseAuth.instance.currentUser!.uid,
 // ),
];