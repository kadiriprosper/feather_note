import 'package:flutter/material.dart';

class NoteModel {
  NoteModel({
    required this.title,
    required this.content,
    this.isPinned = false,
    this.bgColor = Colors.black,
  });
  String title;
  String content;
  DateTime noteUpdateTime = DateTime.now();
  DateTime creationTime = DateTime.now();
  Color bgColor;
  bool isPinned;
  //TODO: Add the background art feature

  String updateTitle(String newTitle) {
    title = newTitle;
    return 'success';
  }

  String updateContent(String newContent) {
    content = newContent;
    return 'success';
  }

  void updateTime() {
    noteUpdateTime = DateTime.now();
  }

  void updateBgColor(Color newColor) {
    bgColor = newColor;
  }

  // bool noteNotEmpty() =>
  //     this != NoteModel(title: '', content: '') &&
  //     this != NoteModel(title: ' ', content: ' ');
  bool noteNotEmpty() => title.isNotEmpty && content.isNotEmpty;

  factory NoteModel.fromMap(Map mappedData) {
    return NoteModel(
      title: mappedData['title'],
      content: mappedData['content'],
    );
  }

  @override
  String toString() {
    return {
      'title': title,
      'content': content,
      'creation time': creationTime,
      'bgcolor': bgColor,
    }.toString();
  }
}
