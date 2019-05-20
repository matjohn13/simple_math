import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.play_for_work),
            title: Text('Challange'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Personal Best'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/personalBest');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/history');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Ranking'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ranking');
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, '/settings');
          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.info),
          //   title: Text('About'),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, '/about');
          //   },
          // ),
          // Divider(),
        ],
      ),
    );
  }
}
