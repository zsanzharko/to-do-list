import 'package:flutter/material.dart';
import 'package:to_do_app/toDo/to_do_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'ToDo List'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  final Widget _toDoList = ToDoListPage(title: "work");
  final Widget _myEmails = MyEmails();
  final Widget _myProfile = MyProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar (
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: "List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "Emails",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if(selectedIndex == 0) {
      return _toDoList;
    } else if(selectedIndex==1) {
      return _myEmails;
    } else {
      return _myProfile;
    }
  }

  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
    });
  }
}

class MyEmails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Emails"));
  }
}

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile"));
  }
}
