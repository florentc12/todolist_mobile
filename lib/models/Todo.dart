class Todo {
  Todo(this.title, this.content, this.done);

  String title;
  String content;
  bool done;

  set setTitle(String param) {
    this.title = param;
  }

  set setContent(String param) {
    this.content = param;
  }

  set setDone(bool param) {
    this.done = param;
  }

  String get getTitle {
    return this.title;
  }

  String get getContent {
    return this.content;
  }

  bool get getDone {
    return this.done;
  }
}
