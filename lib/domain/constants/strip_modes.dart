// ignore_for_file: file_names

enum StripModes {
  static,
  fading,
  rainbow,
  fire,
  pulse,
}

String stripModeToString(StripModes mode) {
  switch (mode) {
    case StripModes.static:
      return "Статичный цвет";
    case StripModes.fading:
      return "Градиент";
    case StripModes.rainbow:
      return "Радуга";
    case StripModes.fire:
      return "Огонь";
    case StripModes.pulse:
      return "Пульсация";
  }
}

String stripModesToStringDescription(StripModes mode) {
  switch (mode) {
    case StripModes.static:
      return "Статичный цвет";
    case StripModes.fading:
      return "Светодиоды медленно меняют яркость от максимума к минимуму и обратно, создавая приятный эффект плавного затухания и разгорания";
    case StripModes.rainbow:
      return "Цвета радуги плавно двигаются по всей ленте, создавая красочный и яркий эффект.";
    case StripModes.fire:
      return "Имитация пламени, где светодиоды мигают и изменяют цветы, чтобы создать видимость огня.";
    case StripModes.pulse:
      return "Свет светодиодов пульсирует внутри каждого участка, создавая визуально завораживающий эффект.";
  }
}
