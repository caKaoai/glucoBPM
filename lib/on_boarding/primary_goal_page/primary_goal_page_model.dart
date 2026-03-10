import '/flutter_flow/flutter_flow_util.dart';
import '/on_boarding/primary_goal1/primary_goal1_widget.dart';
import '/on_boarding/primary_goal2/primary_goal2_widget.dart';
import '/on_boarding/primary_goal3/primary_goal3_widget.dart';
import '/on_boarding/primary_goal4/primary_goal4_widget.dart';
import '/index.dart';
import 'primary_goal_page_widget.dart' show PrimaryGoalPageWidget;
import 'package:flutter/material.dart';

class PrimaryGoalPageModel extends FlutterFlowModel<PrimaryGoalPageWidget> {
  ///  Local state fields for this page.

  List<String> genderList = ['Male', 'Female', 'prefer_not_to_say'];
  void addToGenderList(String item) => genderList.add(item);
  void removeFromGenderList(String item) => genderList.remove(item);
  void removeAtIndexFromGenderList(int index) => genderList.removeAt(index);
  void insertAtIndexInGenderList(int index, String item) =>
      genderList.insert(index, item);
  void updateGenderListAtIndex(int index, Function(String) updateFn) =>
      genderList[index] = updateFn(genderList[index]);

  double? progressVal = 0.25;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for PrimaryGoal1 component.
  late PrimaryGoal1Model primaryGoal1Model;
  // Model for PrimaryGoal2 component.
  late PrimaryGoal2Model primaryGoal2Model;
  // Model for PrimaryGoal3 component.
  late PrimaryGoal3Model primaryGoal3Model;
  // Model for PrimaryGoal4 component.
  late PrimaryGoal4Model primaryGoal4Model;

  @override
  void initState(BuildContext context) {
    primaryGoal1Model = createModel(context, () => PrimaryGoal1Model());
    primaryGoal2Model = createModel(context, () => PrimaryGoal2Model());
    primaryGoal3Model = createModel(context, () => PrimaryGoal3Model());
    primaryGoal4Model = createModel(context, () => PrimaryGoal4Model());
  }

  @override
  void dispose() {
    primaryGoal1Model.dispose();
    primaryGoal2Model.dispose();
    primaryGoal3Model.dispose();
    primaryGoal4Model.dispose();
  }
}
