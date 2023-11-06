import 'package:chatter_application/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({super.key});

  @override
  State<ChatsWidget> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsWidget> {
  final _instance = Supabase.instance;

  @override
  void initState() {
    super.initState();
  }

  dynamic _fetchConversations() {
    return _instance.client
        .from('conversations')
        .stream(primaryKey: ['id'])
        .eq('origin', _instance.client.auth.currentUser?.id)
        .order('created_at');
  }

  // void onNewData(List<Map<String, dynamic>> data) {
  //   debugPrint('New data');
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _fetchConversations(),
        // builder: (_, snapshot) => ListView()
        //set the build to receive the data from the stream, the data is a list of maps with origin, dest, created_at, id, all of these are ints
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                final timestampToDateTime = DateFormat.jm()
                    .format(DateTime.parse(item['created_at'].toString()));
                return ListTile(
                  title: Text(item['dest'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent)),
                  subtitle: Text(timestampToDateTime),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatPage(convId: item['id'])));
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
