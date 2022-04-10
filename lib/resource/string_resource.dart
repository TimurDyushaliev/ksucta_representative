class StringResource {
  static final auth = _Auth();
  static final register = _Register();

  static const emptyTextField = 'Поле не может быть пустым';
}

class _Auth {
  final login = 'Войти';
  final textFieldHint = 'Фамилия Имя';
  final username = 'Абышев Улан';

  final invalidUsername = 'Такого пользователя не существует';
}

class _Register {
  final fullName = 'Ф.И.О';
  final address = 'Адрес';
  final dateTime = 'Дата и Время';
  final vehicle = 'Авто';
  final vehicleNumber = 'Гос #';
  final vehicleBrand = 'Марка';
  final done = 'Готово';
}
