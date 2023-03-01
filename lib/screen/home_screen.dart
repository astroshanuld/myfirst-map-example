import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.push(context, LoginScreen.route());
      } else {
        print('Logged in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child: const Text(
              '4',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 4,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) => ListTile(
          trailing: SizedBox(
            width: 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          title: const Text('Note title'),
          subtitle: const Text('Note content'),
          onTap: () {},
          onLongPress: () {},
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //         child: const Icon(Icons.menu),
      //         tooltip: 'Show less. Hide notes content',
      //         onPressed: () {}),

      //     /* Notes: for the "Show More" icon use: Icons.menu */

      //     FloatingActionButton(
      //       child: const Icon(Icons.add),
      //       tooltip: 'Add a new note',
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
    );
  }
}
