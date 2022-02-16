import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_http_mockapi/core/https/user_http.dart';
import 'package:my_http_mockapi/core/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: UserHttp().listOfUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData && snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.map((e) => itemCategory(e, context)).toList(),
        );
      },
    );
  }

  Widget itemCategory(User data, BuildContext context) {
    return ListTile(
      title: Text(data.name ?? ""),
      trailing: GestureDetector(onTap: () => _showCupertinoDialog(data, context), child: Icon(Icons.more_horiz)),
    );
  }

  void _showCupertinoDialog(User data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Delete User?'),
            content: Text('Cannot restored if you select yes'),
            actions: [
              TextButton(
                  onPressed: () async {
                    var resp = await UserHttp().deleteUsers(data.id!);
                    if (resp) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: "Success Delete User");
                      setState(() {});
                    }
                  },
                  child: Text('Yes')),
              TextButton(onPressed: () => Navigator.pop(context), child: Text('No')),
            ],
          );
        });
  }
}
