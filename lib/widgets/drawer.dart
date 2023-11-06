import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
            child: Text(
              'Chatter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                height: 2,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushNamed('/home'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Settings'),
            onTap: () => Navigator.of(context).pushNamed('/account'),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
