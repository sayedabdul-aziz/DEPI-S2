void main() async {
  print("task 1");
  try {
    await doTask2().then(
      (value) {
        throw Exception('error');
      },
      onError: (e) {
        print(e.toString());
      },
    );
  } catch (e) {
    print(e.toString());
  } finally {
    print("task 2");
  }
  print("task 3");
}

Future<String> doTask2() async {
  return await Future.delayed(Duration(seconds: 2), () => 'task2');
}


