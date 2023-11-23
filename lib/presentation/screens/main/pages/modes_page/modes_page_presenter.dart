import 'package:flutter/material.dart';
import 'package:remote_leds/domain/entities/picker_type.dart';
import 'package:remote_leds/domain/usecases/led_controller.dart';
import 'package:remote_leds/domain/usecases/led_mode_card.dart';
import 'package:remote_leds/presentation/screens/edit/edit_screen.dart';
import 'package:remote_leds/presentation/screens/screen_presenter.dart';
import 'package:remote_leds/presentation/widgets/appbar/appbar.dart';
import 'package:remote_leds/presentation/widgets/appbar/modes_page_appbar.dart';
import 'package:remote_leds/presentation/widgets/appbar/modes_page_delete_appbar.dart';

enum PageMode { view, delete }


class ModesPageModel extends ChangeNotifier {
  ModesPageModel();
  late ScreenModel _screenModel;
  void setScreenModel(ScreenModel screenModel){
    _screenModel = screenModel;
  }
  late AppBarModel _appBarModel;
  void setAppBarModel(AppBarModel appBarModel){
    _appBarModel = appBarModel;
  }
  PageMode _pageMode = PageMode.view;
  PageMode get pageMode => _pageMode;
  bool readyToAnimation = false;
  setDeleteMode() async{
    for (var element in _modes) {
      element.delete = false;
    }
    calculateSelectedToDelete();
    _isSelected = false;
    if(!_allDeleted){
      _appBarModel.setAppBar(ModesPageDeleteModeAppBar(
        moveBack: () { setViewMode(); },
        selectAll: () { makeAllSelected(); },));
      readyToAnimation = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 50));
      notifyListeners();
      _pageMode = PageMode.delete;
      await Future.delayed(const Duration(milliseconds: 250));
      notifyListeners();
      readyToAnimation = false;

    }
  }

  setViewMode() async{
    _appBarModel.setAppBar(ModesPageViewModeAppBar(
     onTap: () { _screenModel.setPage(ModeEditor(model: LEDModeModel(),type: PickerType.add,) ); },));
    readyToAnimation = true;
    notifyListeners();
    _pageMode = PageMode.view;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    readyToAnimation = false;
    notifyListeners();
  }
  pageSetMode(){
    if(pageMode==PageMode.view){
      setViewMode();
    } else {
      setDeleteMode();
    }
  }
  final List<LEDModeCardModel> _modes = [];
  List<LEDModeCardModel> get modes => _modes;

  addMode(LEDModeCardModel modeCard) {
    _modes.add(modeCard);
    _allDeleted = false;
    notifyListeners();
  }

  deleteMode(LEDModeCardModel modeCard) {
    print("удалил");
    int index = _modes.indexWhere((element) => element.model.key == modeCard.model.key);
    print(index);
    _modes.removeWhere((element) => element.model.key == modeCard.model.key);
     index = _modes.indexWhere((element) => element.model.key == modeCard.model.key);
    print(index);

    if (_modes.isEmpty) _allDeleted = true;
    calculateSelectedToDelete();
    notifyListeners();

  }

  editMode(LEDModeCardModel modeCard) {
    int index = _modes.indexWhere((element) => element.model.key == modeCard.model.key);
    print(index);
    if (index >= 0) {
      _modes[index] = modeCard;
      notifyListeners();
    }
  }

  int selectedToDelete = 0;

  calculateSelectedToDelete() {
    int count = 0;
    for (var element in _modes) {
      if (element.delete == true) count += 1;
    }
    if (count != selectedToDelete) {
      selectedToDelete = count;
      notifyListeners();
    }
  }

  deleteSelected() {
    _modes.removeWhere((element) => element.delete == true);
    if (_modes.isEmpty) _allDeleted = true;
    notifyListeners();
  }

  bool _isSelected = false;
  bool _allDeleted = false;
  makeAllSelected() {
    bool parameter = false;
    bool someIsSelect = false;
    bool allIsSelected = true;
    bool allIsUnselected = true;
    for (var element in _modes) {
      if (element.delete) {
        someIsSelect = true;
        allIsUnselected = false;
      } else {
        allIsSelected = false;
      }
    }
    if (allIsSelected && !allIsUnselected) {
      parameter = false;
    } else if (allIsUnselected && !allIsSelected) {
      parameter = true;
    } else {
      if (someIsSelect == false && _isSelected == false) {
        parameter = true;
      } else if (someIsSelect == false && _isSelected == true) {
        parameter = true;
      } else if (someIsSelect == true && _isSelected == false) {
        parameter = true;
      } else if (someIsSelect == true && _isSelected == true) {
        parameter = false;
      }
    }
    for (var element in _modes) {
      element.delete = parameter;
    }
    calculateSelectedToDelete();
    _isSelected = !_isSelected;
    notifyListeners();
  }
  cardOnLongPress(LEDModeCardModel modeCard){
    if(pageMode == PageMode.view){
      setDeleteMode();
    }
      modeCard.changeDeleteStatus();

      calculateSelectedToDelete();

  }
  cardOnPress(LEDModeCardModel modeCard){
    if(pageMode == PageMode.view){
      _screenModel.setPage(ModeEditor(model: modeCard.model,type: PickerType.edit,) );
    } else if( pageMode == PageMode.delete){
      modeCard.changeDeleteStatus();
      calculateSelectedToDelete();
    }
  }
  cardChangeDeleteStatus(LEDModeCardModel modeCard){
    modeCard.changeDeleteStatus();
    calculateSelectedToDelete();
  }
}
