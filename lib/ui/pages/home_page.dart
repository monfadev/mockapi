import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_http_mockapi/core/https/user_http.dart';
import 'package:my_http_mockapi/core/models/user.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserHttp _userHttp = UserHttp();

  List<User> _user = [];

  bool _loading = false;

  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    getUsers(true);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: CircularProgressIndicator())],
          )
        : SmartRefresher(
            controller: _refreshController,
            onRefresh: () => getUsers(true),
            child: ListView.builder(
              itemCount: _user.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_user[index].name ?? ""),
                  subtitle: Text(DateFormat('HH.mm').format(_user[index].createdAt!)),
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () async {
                      var resp = await UserHttp().deleteUsers(_user[index].id ?? "");
                      if (resp) {
                        Fluttertoast.showToast(msg: "Delete Success");
                      }
                    },
                  ),
                  onTap: () {},
                );
              },
            ),
          );
  }

  void getUsers([bool refresh = false]) async {
    if (refresh) {
      setState(() {
        _refreshController.resetNoData();
        _user.clear();
        _loading = true;
      });
    }
    _user = await _userHttp.users();
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
    if (mounted)
      setState(() {
        _loading = false;
      });
  }
}
