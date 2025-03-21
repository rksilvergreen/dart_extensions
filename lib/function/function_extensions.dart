
extension FunctionExtension on Function {
  /// All parameter methods are for functions with unnamed non-optional parameters
  int get numOfParameters {
    if (this is Function()) return 0;
    else if (this is Function(Null)) return 1;
    else if (this is Function(Null, Null)) return 2;
    else if (this is Function(Null, Null, Null)) return 3;
    else if (this is Function(Null, Null, Null, Null)) return 4;
    else if (this is Function(Null, Null, Null, Null, Null)) return 5;
    else if (this is Function(Null, Null, Null, Null, Null, Null)) return 6;
    else if (this is Function(Null, Null, Null, Null, Null, Null, Null)) return 7;
    else if (this is Function(Null, Null, Null, Null, Null, Null, Null, Null)) return 8;
    else if (this is Function(Null, Null, Null, Null, Null, Null, Null, Null, Null)) return 9;
    else if (this is Function(Null, Null, Null, Null, Null, Null, Null, Null, Null, Null)) return 10;
    else throw('Function has over 10 arguments');
  }

  bool hasParameters(int x) {
    assert(x <= 10, 'hasArguments method checks for up to 10 arguments');
    return x == numOfParameters;
  }

  bool hasOutputType<T>() {
    switch(numOfParameters) {
      case 0: return this is T Function();
      case 1: return this is T Function(Null);
      case 2: return this is T Function(Null, Null);
      case 3: return this is T Function(Null, Null, Null);
      case 4: return this is T Function(Null, Null, Null, Null);
      case 5: return this is T Function(Null, Null, Null, Null, Null);
      case 6: return this is T Function(Null, Null, Null, Null, Null, Null);
      case 7: return this is T Function(Null, Null, Null, Null, Null, Null, Null);
      case 8: return this is T Function(Null, Null, Null, Null, Null, Null, Null, Null);
      case 9: return this is T Function(Null, Null, Null, Null, Null, Null, Null, Null, Null);
      case 10: return this is T Function(Null, Null, Null, Null, Null, Null, Null, Null, Null, Null);
    }
    return false;
  }

  bool isAsync() => hasOutputType<Future>();
}