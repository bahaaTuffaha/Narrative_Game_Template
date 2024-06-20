double operations(String op, double prev, double value) {
  switch (op) {
    case "+":
      return prev + value;
    case "-":
      return prev - value;
    case "*":
      return prev * value;
    case "/":
      return prev / value;
    default:
      return -1;
  }
}

bool checkOperation(String op, double prev, double value) {
  switch (op) {
    case "gt":
      return prev < value;
    case "lt":
      return prev < value;
    case "gte":
      return prev >= value;
    case "lte":
      return prev <= value;
    case "equal":
      return prev == value;
    default:
      return false;
  }
}
