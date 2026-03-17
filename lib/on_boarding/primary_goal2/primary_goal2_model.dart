import '/flutter_flow/flutter_flow_util.dart';
import 'primary_goal2_widget.dart' show PrimaryGoal2Widget;
import 'package:flutter/material.dart';

class PrimaryGoal2Model extends FlutterFlowModel<PrimaryGoal2Widget> {
  ///  Local state fields for this component.

  String? selectedGender = 'male';

  List<String> diabetType = [
    'type_1',
    'type_2',
    'gestational',
    'prefer_not_to_say'
  ];
  void addToDiabetType(String item) => diabetType.add(item);
  void removeFromDiabetType(String item) => diabetType.remove(item);
  void removeAtIndexFromDiabetType(int index) => diabetType.removeAt(index);
  void insertAtIndexInDiabetType(int index, String item) =>
      diabetType.insert(index, item);
  void updateDiabetTypeAtIndex(int index, Function(String) updateFn) =>
      diabetType[index] = updateFn(diabetType[index]);

  String selectedDaib = 'type_2';

  int? age;

  int? height;

  /// 1=cm.
  ///
  /// 0=ft
  int? heightType = 0;

  int? weight;

  /// kg=1.
  ///
  /// 0=lbs
  int? weightType;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
