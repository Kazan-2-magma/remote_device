
abstract class UseCasesWithParamsStream<Type,Params> {
  const UseCasesWithParamsStream();

  Stream<Type> call(Params params);
}

abstract class UseCaseWithoutParamsStream<Type>{
  const UseCaseWithoutParamsStream();
  Stream<Type> call();
}



abstract class UseCaseWithoutParams<Type>{
  const UseCaseWithoutParams();
  Future<Type> call();
}

abstract class UseCasesWithParams<Type,Params> {
  const UseCasesWithParams();

  Future<Type> call(Params params);
}
