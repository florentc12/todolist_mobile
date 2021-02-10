import 'package:flutter/material.dart';
import 'package:todolist/models/Todo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> listMyHomePage = <Todo>[];
  final TextEditingController _textFieldControllerTitle =
      TextEditingController();
  final TextEditingController _textFieldControllerContent =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TodoList')),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title, String content, bool done) {
    setState(() {
      Todo todo = new Todo(title, content, done);
      listMyHomePage.add(todo);
    });
    _textFieldControllerTitle.clear();
    _textFieldControllerContent.clear();
  }

  void _modifyTodoItem(String title, String content, bool done, index) {
    setState(() {
      listMyHomePage[index].setTitle = title;
      listMyHomePage[index].setContent = content;
      listMyHomePage[index].setDone = done;
    });
    _textFieldControllerTitle.clear();
    _textFieldControllerContent.clear();
  }

  void _deleteTodoItem(String title, String content, bool done) {
    setState(() {
      listMyHomePage.removeWhere((item) =>
          item.getTitle == title &&
          item.getContent == content &&
          item.getDone == done);
    });
  }

  Widget _buildTodoItem(String title, String content, bool done) {
    return ListTile(
        leading: done == true ? Icon(Icons.done) : Icon(Icons.clear),
        title: Text(title),
        subtitle: Text(content),
        onTap: () {
          int index = listMyHomePage.indexWhere((i) =>
              i.getTitle == title &&
              i.getContent == content &&
              i.getDone == done);

          _displayEdit(context, listMyHomePage[index], index);
        },
        trailing: new IconButton(
          icon: new Icon(Icons.delete),
          onPressed: () {
            _deleteTodoItem(title, content, done);
          },
        ));
  }

  Future<AlertDialog> _displayEdit(
      BuildContext context, Todo todo, int index) async {
    bool _isChecked = todo.getDone;
    return showDialog(
        context: context,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Modifier la tâche'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: _textFieldControllerTitle..text = todo.getTitle,
                    decoration: const InputDecoration(
                        hintText: 'Entrer le titre de la tâche'),
                  ),
                  TextField(
                    controller: _textFieldControllerContent
                      ..text = todo.getContent,
                    decoration: const InputDecoration(
                        hintText: 'Entrer le contenu de la tâche'),
                  ),
                  CheckboxListTile(
                    title: Text("Tâche éffectuée ?"),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Modifier'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _modifyTodoItem(_textFieldControllerTitle.text,
                      _textFieldControllerContent.text, _isChecked, index);
                },
              ),
              FlatButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }));
  }

  Future<AlertDialog> _displayDialog(BuildContext context) async {
    bool _isChecked = false;
    return showDialog(
        context: context,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Ajouter une tâche à la liste'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: _textFieldControllerTitle,
                    decoration: const InputDecoration(
                        hintText: 'Entrer le titre de la tâche'),
                  ),
                  TextField(
                    controller: _textFieldControllerContent,
                    decoration: const InputDecoration(
                        hintText: 'Entrer le contenu de la tâche'),
                  ),
                  CheckboxListTile(
                    title: Text("Tâche éffectuée ?"),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Ajouter'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldControllerTitle.text,
                      _textFieldControllerContent.text, _isChecked);
                },
              ),
              FlatButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }));
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (Todo todo in listMyHomePage) {
      _todoWidgets
          .add(_buildTodoItem(todo.getTitle, todo.getContent, todo.getDone));
    }
    return _todoWidgets;
  }
}
