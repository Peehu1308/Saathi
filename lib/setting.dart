import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Colors.teal),
            title: Text("Language"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Implement language selection
            },
          ),
          ListTile(
            leading: Icon(Icons.volume_up, color: Colors.teal),
            title: Text("Voice Output"),
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.teal),
            title: Text("About Saathi"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Saathi",
                applicationVersion: "1.0.0",
                children: [Text("Saathi is an accessibility assistant powered by Flutter.")],
              );
            },
          ),
        ],
      ),
    );
  }
}
