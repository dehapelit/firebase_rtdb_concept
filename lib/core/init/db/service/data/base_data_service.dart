import 'package:firebase_rtdb_concept/core/init/db/model/data_model.dart';

abstract class IDataService<T> {
  Future<List<E>> _all<E>({
    required Future<E> Function({String? id, T? data}) op,
    List<String>? ids,
    List<T>? dataList,
  }) async {
    assert(
      ((ids?.isNotEmpty ?? false) &&
              (dataList?.isNotEmpty ?? false) &&
              (ids!.length == dataList!.length)) ||
          (ids?.isNotEmpty ?? false) ||
          (dataList?.isNotEmpty ?? false),
      'Both id and data list cannot be empty and '
      'if both lists are provided than list lengths must be equal',
    );
    final len = ids != null
        ? ids.length
        : dataList != null
            ? dataList.length
            : 0;
    final list = <E>[];
    for (var index = 0; index < len; index++) {
      final item = await op(
        id: ids?.elementAt(index),
        data: dataList?.elementAt(index),
      );
      list.add(item);
    }
    return list;
  }

  Future<T?> get(String id);
  Future<String> push(T data);
  Future<void> update(String id, T data);
  Future<void> remove(String id);

  Future<List<Data<T>>> getAll();
  Future<List<String>> pushAll(List<T> dataList) => _all<String>(
        op: ({data, id}) => push(data as T),
        dataList: dataList,
      );
  Future<List<void>> updateAll(List<String> ids, List<T> dataList) =>
      _all<void>(
        op: ({data, id}) => update(id!, data as T),
        ids: ids,
        dataList: dataList,
      );
  Future<List<void>> removeAll(List<String> ids) => _all<void>(
        op: ({data, id}) => remove(id!),
        ids: ids,
      );
}
