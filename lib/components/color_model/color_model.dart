import 'package:flutter/material.dart';


class ProfileCardModel with ChangeNotifier {
  late List<ModeModel> _modes;
  late String name;
  ProfileCardModel({required this.name, modes}){
    _modes = modes??[];
  }
  addMode(ModeModel mode){
    _modes.add(mode);
    notifyListeners();
  }
  deleteModeByIndex(int index){
    _modes.removeAt(index);
    notifyListeners();
  }
  getMode(int index){
    return _modes[index];
  }
}
enum ModeType {
  one,
  many,
  oneBlink
}
class ModeModel with ChangeNotifier{
  String? id;
  late ModeType _mode;
  late int _duration;
  late List<Color> _colors;
  late List<int> _range;
  ModeModel({required mode,required duration,required colors,range = const [0,300]}){
    mode = mode;
    duration = duration;

  }
  set mode(ModeType mode) {_mode = mode; notifyListeners();}
  ModeType get mode => _mode;

  set duration(int duration) {_duration = duration; notifyListeners();}
  int get duration => _duration;

  set colors(List<Color> colors) {
    if(colors.isNotEmpty) {
      if (mode == ModeType.one || mode == ModeType.oneBlink) {
        _colors = [colors[0]];
      } else if (mode == ModeType.many) {
        var maxIndex = colors.length>5?5:colors.length;
        _colors = [...colors.getRange(0, maxIndex)];
      }
    }
    notifyListeners();
  }
  List<Color> get colors => _colors;

  deleteColorByIndex(int index){
    colors.removeAt(index);
    notifyListeners();
  }

  set range(List<int> range) {_range = range; notifyListeners();}
  List<int> get range => _range;
}