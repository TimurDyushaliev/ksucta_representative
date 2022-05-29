class StringResource {
  static final auth = _Auth();
  static final home = _Home();
  static final addItem = _AddItem();
  static final productList = _ProductList();
  static final productInfo = _ProductInfo();

  static const emptyTextField = 'Поле не может быть пустым';
}

class _Home {
  final stores = 'Магазины';
}

class _Auth {
  final login = 'Войти';
  final textFieldHint = 'Фамилия Имя';
  final username = 'Гламов Нурсултан';

  final invalidUsername = 'Такого пользователя не существует';
}

class _AddItem {
  final storeName = 'Название магазина';
  final storeAddress = 'Адрес магазина';
  final productName = 'Название продукта';
  final productStartDate = 'Дата начала';
  final productAmount = 'Количество';

  final done = 'Готово';
}

class _ProductList {
  final products = 'Продукты';
}

class _ProductInfo {
  final name = 'Название продукта';
  final startDate = 'Дата начала';
  final amount = 'Количество';
  final productsReturnAmount = 'Количество возвращаемых товаров';
  final highAmount = 'значение не может быть больше, чем текущее кол-во';
}
