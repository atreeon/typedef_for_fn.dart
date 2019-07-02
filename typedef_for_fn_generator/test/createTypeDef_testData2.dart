var testCodeLinesInput2 = """@TypedefForFn(exNames: ["firebaseDb"])
Future<Map> getFirebaseData(FirebaseDatabase firebaseDb, String uid,
    String collectionType, bool isStaticData) async {
  assert(uid != null);
  print('request:\$collectionType');

  String strRef;
  if (isStaticData) {
    strRef = 'fr/static/\$collectionType/';
  } else {
    strRef = 'fr/user/\$uid/\$collectionType}/';
  }

  var ref = firebaseDb.reference().child(strRef);

  //so, assume that once will simply hang there indefinitely unless it completes or an erro occurs

  // TODO: do error handling; var docs = ref.once().then(onValue).catchError(onError);
  return ref.once().then((docs) {
    print('got \$strRef');

    if (docs.value == null || docs.value.length == 0) {
      // store.dispatch(SetFbLoadTypeStatus(collectionType, true));
      print('no data at:\$strRef');
      return null;
    }

    return docs.value;
  });
}
""";