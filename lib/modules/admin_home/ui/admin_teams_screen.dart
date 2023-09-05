import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminTeamsScreen extends StatefulWidget {
  const AdminTeamsScreen({super.key});

  @override
  State<AdminTeamsScreen> createState() => _AdminTeamsScreenState();
}

class _AdminTeamsScreenState extends State<AdminTeamsScreen> {

  final teamController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your teams'),
      ),
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openDialog();
        },
        icon: Icon(Icons.add),
        label: Text('Create team'),
      ),
    );
  }

  Future openDialog() async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Team'),
          content: TextField(
            controller: teamController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter team name',
                prefixIcon: Icon(Icons.people_alt_rounded)
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel')
            ),
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Create')
            ),
          ],
        );
      },
    );
  }
}
