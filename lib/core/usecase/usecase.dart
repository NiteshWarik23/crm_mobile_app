import 'package:crm_mobile_app/core/utils/type_def.dart';

abstract class UsecaseWithParams<Type, Params> {
  UsecaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  UsecaseWithoutParams();
  ResultWithoutFuture<Type> call();
}

abstract class UseCase<T> {
  Future<T> call();
}
