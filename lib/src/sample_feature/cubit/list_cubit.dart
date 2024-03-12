import 'package:bloc/bloc.dart';
import 'package:pyme_app/src/sample_feature/sample_item.dart';
import 'package:realm/realm.dart';

class ListCubit extends Cubit<List<SampleItem>> {
  ListCubit(this._realm, {required this.items})
      : super(_realm.all<SampleItem>().toList());

  final Realm _realm;
  final RealmResults<SampleItem> items;

  void addNewItem() {
    _realm.write(() {
      _realm.add(SampleItem(1 + (state.lastOrNull?.id ?? 0)));
    });
    emit(_realm.all<SampleItem>().toList());
  }

  void deleteItem(SampleItem item) {
    _realm.write(() {
      _realm.delete(item);
    });
    emit(_realm.all<SampleItem>().toList());
  }
}
