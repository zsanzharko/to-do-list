import 'package:flutter/material.dart';
import 'package:to_do_app/toDo/to_do_list.dart';

class AffairInformation extends StatelessWidget {
  const AffairInformation(
      {Key? key,
      required this.title,
      required this.affair,
      required this.affairPassing,
      required this.index})
      : super(key: key);

  final String title;
  final String affair;
  final bool affairPassing;
  final int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, affairPassing);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(title),
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.delete, size: 26.0,),
              onTap: () {
                //TODO Write function when it will removing the affair
              },
            ),
          )
        ],
      ),
      body: getText(),
    );
  }

  Widget getText() {
    return ListTile(
      leading: AffairInformationWidget(
        title: title,
        affair: affair,
        affairPassing: affairPassing,
        index: index,
      ),
      title: Text(affair),

    );
  }
}

class AffairInformationWidget extends StatefulWidget {
  AffairInformationWidget(
      {Key? key,
      required this.title,
      required this.affair,
      required this.affairPassing,
      required this.index})
      : super(key: key);

  String title;
  String affair;
  bool affairPassing;
  int index;

  @override
  State<StatefulWidget> createState() => AffairInformationWidgetState();
}

class AffairInformationWidgetState extends State<AffairInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      value: widget.affairPassing,
      onChanged: (bool? value) {
        setState(() {
          widget.affairPassing = value!;
        });
      },
    );
  }
}
