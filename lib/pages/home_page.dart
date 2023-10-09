import 'package:chatter_application/pages/chats_page.dart';
import 'package:chatter_application/widgets/drawer.dart';
import 'package:flutter/material.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  //add a hamburger slider

  @override
  State<HomePage> createState() => _HomePageState();
  //add a hamburger slider
}

class _HomePageState extends State<HomePage> {
  void _newChat() {
    //log debug to console
    debugPrint('Creating a new chat');
    setState(() {
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Chats"),
      ),
      drawer: const NavDrawer(),
      body: const ChatsPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _newChat,
        tooltip: 'New chat',
        child: const Icon(Icons.add),
      ),
    );
  }
}
