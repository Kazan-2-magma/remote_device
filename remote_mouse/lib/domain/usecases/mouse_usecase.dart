import 'package:flutter/cupertino.dart';
import 'package:remote_mouse/core/usecases/usecases.dart';
import 'package:remote_mouse/domain/repositories/keyboard_mouse_repo.dart';
import 'package:remote_mouse/models/mouse_data_model.dart';

class MouseUseCase extends UseCasesWithParams<void,MouseParams>{
  const MouseUseCase(this._keyboardMouseRepo);
  final KeyboardMouseRepo _keyboardMouseRepo;

  @override
  Future<void> call(MouseParams params) async {
    try{
      _keyboardMouseRepo.sendMouseEvent(params.mouseDataModel);
    }on Exception catch(e){
      debugPrint(e.toString());
    }
  }

}


class MouseParams {
  final MouseDataModel mouseDataModel;

  MouseParams(this.mouseDataModel);


}