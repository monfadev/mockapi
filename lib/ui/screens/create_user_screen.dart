import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_http_mockapi/core/https/user_http.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _etName = TextEditingController();

  @override
  void dispose() {
    _etName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: _etName,
          ),
          SizedBox(height: 100),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
                child: Text("Save"),
                onPressed: () async {
                  if (_etName.text.trim().length == 0) return;
                  // var resp = await UserHttp().addUsers(_etName.text);
                  var resp = await UserHttp().addUser(_etName.text);
                  if (resp) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Success Add New User");
                  }
                }),
          )
        ],
      ),
    );
  }
}
