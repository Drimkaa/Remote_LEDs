import 'package:flutter/material.dart';
import 'package:remote_leds/domain/entities/picker_type.dart';
import 'package:remote_leds/domain/usecases/led_mode_card.dart';
import 'package:remote_leds/presentation/screens/main/pages/modes_page/modes_page_presenter.dart';
import 'package:remote_leds/domain/usecases/led_mode.dart';
import 'package:remote_leds/presentation/screens/screen_presenter.dart';
import 'package:remote_leds/presentation/widgets/animations_model.dart';

class EditScreenModel extends ChangeNotifier {
  late PickerType pageType;
  late LEDModeModel led;
  late ModesPageModel _modesPageModel;

  EditScreenModel();
  void setListPageModel(ModesPageModel ledModeListPage){
    _modesPageModel = ledModeListPage;
  }
  late ScreenModel _screenModel;
  void setScreenModel(ScreenModel screenModel){
    _screenModel = screenModel;
  }
  init({pageType = PickerType.add,required LEDModeModel led}){
    this.led = led;
    this.pageType = pageType;
    animationModel = AnimationModel(led.colors, led.mode, Duration(seconds: led.speed));
  }
  changeMode(StripModes? mode) {
    if (mode != null && mode != led.mode) {
      led.mode = mode;
      animationModel.mode = led.mode;
      notifyListeners();
    }
  }

  changeName(String name) {
    if (name == "" || name == " ") {
      name = "Новый режим";
    }
    if (name != led.name) {
      led.name = name;
      notifyListeners();
    }
  }

  changeSpeed(String speed) {
    int speed0;
    if (speed.isNotEmpty) {
      speed0 = int.parse(speed);
    } else {
      speed0 = 0;
    }
    if (speed0 != led.speed) {
      led.speed = speed0;
      animationModel.duration = Duration(milliseconds: speed0 * 1000);
      notifyListeners();
    }
  }

  changeColors(List<Color> colors) {
    led.colors = colors;
    animationModel.colors = colors;
    notifyListeners();
  }

  AnimationModel animationModel = AnimationModel([], StripModes.static, const Duration(milliseconds: 200));

  RangeValues get rangeValues => RangeValues(led.zoneStart.toDouble(), led.zoneEnd.toDouble());
  setZone(RangeValues values) {
    led.setZone(values.start.toInt(), values.end.toInt());
    notifyListeners();
  }
  List<Color> get colors => led.colors;
  int get colorLength => led.colorLength;
  changeColor(int index, Color color) {
    led.colors[index] = color;
    animationModel.colors = led.colors;
    notifyListeners();
  }

  addColor(Color color) {
    led.colors.add(color);
    animationModel.colors = led.colors;
    notifyListeners();
  }

  deleteColor(int index) {
    if (index >= 0) {
      led.colors.removeAt(index);
      animationModel.colors = led.colors;
      notifyListeners();
    }
  }
  addNewMode(){
    if(led.colors.isNotEmpty) _modesPageModel.addMode(LEDModeCardModel(led));
    moveBack();
  }
  editExistingMode(){
    if(led.colors.isNotEmpty) _modesPageModel.editMode(LEDModeCardModel(led));
    moveBack();
  }
  deleteExistingMode(){
    _modesPageModel.deleteMode(LEDModeCardModel(led));
    moveBack();
  }
  moveBack(){
    _screenModel.back();
  }
  int maxColors = 1;
}
