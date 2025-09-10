import 'package:flutter/foundation.dart';
import 'package:remote_mouse/core/usecases/usecases.dart';
import 'package:remote_mouse/domain/repositories/keyboard_mouse_repo.dart';
import 'package:remote_mouse/models/keybaord_model.dart';

class KeyboardUseCase extends UseCasesWithParams<void,KeyboardParams> {
  final KeyboardMouseRepo _keyboardMouseRepo;

  const KeyboardUseCase(this._keyboardMouseRepo);

  @override
  Future<void> call(KeyboardParams params) async {
    try{
      _keyboardMouseRepo.sendKeyboardEvent(params.keyboardModel);
    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }

}

class KeyboardParams {
  final KeyboardModel keyboardModel;

  const KeyboardParams(this.keyboardModel);
}