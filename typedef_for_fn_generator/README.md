# typedef_for_fn

Use this code generator if you want to automatically create type definitions based on your functions

##### add the necessary dependencies
```
dependencies:
  typedef_for_fn: ^1.0.1-nnbd

dev_dependencies:
  build_runner: ^1.2.8
  typedef_for_fn_generator: 1.0.4-nnbd-2
```

##### decorate your function with the annotation

```
@TypedefForFn()
void f3(int input) {}
```

##### then set your function
```
fn_f3 fn = (a) => print("blah");
```

note, don't put any other code in with your function files (msg me if you want this changed!)

see fn_test.dart in the example folder of the github project for more examples