import 'package:flutter/material.dart';
import 'package:to_do_app/toDo/to_do_information.dart';

class ToDoList {
  final String title;
  final String listTitle;
  final List<String> list;
  final List<bool> listPassing;

  ToDoList(this.title, this.listTitle, this.list, this.listPassing);

  void addAffair(String text) {
    list.add(text);
    listPassing.add(false);
  }

  void removeLastAffair() {
    list.removeLast();
    listPassing.removeLast();
  }

  void removeAffair(int index) {
    list.removeAt(index);
    listPassing.removeAt(index);
  }

  String getAffair(int index) {
    return list[index];
  }

  void isDoing(int index, bool value) {
    listPassing[index] = value;
  }

  bool getRadio(int index) {
    return listPassing[index];
  }

  int getLength() {
    return list.length;
  }

  @override
  String toString() {
    return 'ToDoList{title: $title, listTitle: $listTitle, list: $list, listPassing: $listPassing}';
  }
}

class ToDoListPage extends StatefulWidget {
  ToDoListPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final ToDoList toDoList = ToDoList("title", "listTitle", [], []);

  @override
  State<StatefulWidget> createState() => ToDoListPageState();
}

class ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController _controller = TextEditingController();

  String value = "";

  ToDoListPageState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(child: radioAffair()),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _enterTheText()),
              _addButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _addButton() {
    return FloatingActionButton(
      onPressed: () {
        _addText(value);
      },
      tooltip: 'AddText',
      child: const Icon(Icons.add),
    );
  }

  Widget _enterTheText() {
    return TextField(
      obscureText: false,
      decoration: const InputDecoration(
        labelText: 'Add Affair',
      ),
      controller: _controller,
      onChanged: (String text) {
        value = text;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void  _addText(String text) {
    setState(() {
      widget.toDoList.addAffair(text);
    });
  }

  void _passAffair(int index, bool value) {
    setState(() {
      widget.toDoList.isDoing(index, value);
    });
  }

  Widget affairs() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: widget.toDoList.getLength(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: 55,
            // color: Colors.blue,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.toDoList.getAffair(index)),
                IconButton(
                  onPressed: () => removeAffair(index),
                  iconSize: 24.0,
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent[300],
                ),
              ],
            ),
          );
        });
  }

  Widget radioAffair() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.toDoList.getLength(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListTile(
                leading: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: widget.toDoList.getRadio(index),
                  onChanged: (bool? value) {
                    setState(() {
                      _passAffair(index, value!);
                    });
                  },
                ),
                title: Text(widget.toDoList.getAffair(index)),
                trailing: IconButton(
                  onPressed: () => removeAffair(index),
                  iconSize: 24.0,
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent[300],
                ),
                onTap: () => reloadState(context, index),
              ));
        });
  }

  void reloadState(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AffairInformation(
          title: widget.toDoList.title,
          affair: widget.toDoList.getAffair(index),
          affairPassing: widget.toDoList.getRadio(index),
          index: index,
        ),
      ),
    );
    _passAffair(index, result);
  }

  void removeAffair(int index) {
    setState(() {
      widget.toDoList.removeAffair(index);
    });
  }

  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.red;
  }
}
