import 'dart:convert';
import 'package:cursed_city/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _taskListKey = 'taskList';
  static const String _balanceKey = 'balance';
  static const String _slotStageKey = 'slotStage';

  SharedPreferences? _preferences;

  Preferences._();

  static final Preferences _instance = Preferences._();

  static Preferences get instance => _instance;

  Future<SharedPreferences> get pref async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<void> saveTaskList(List<TaskModel> taskList) async {
    List<String> jsonList =
        taskList.map((task) => json.encode(task.toJson())).toList();
    (await pref).setStringList(_taskListKey, jsonList);
  }

  Future<List<TaskModel>> getTaskList() async {
    List<String>? jsonList = (await pref).getStringList(_taskListKey);
    if (jsonList == null) return [];
    return jsonList
        .map((jsonString) => TaskModel.fromJson(json.decode(jsonString)))
        .toList();
  }

  Future<void> saveBalance(int balance) async {
    await (await pref).setInt(_balanceKey, balance);
  }

  Future<int?> getBalance() async {
    return (await pref).getInt(_balanceKey);
  }

  Future<void> saveSlotStage(int slotStage) async {
    await (await pref).setInt(_slotStageKey, slotStage);
  }

  Future<int?> getSlotStage() async {
    return (await pref).getInt(_slotStageKey);
  }
}
