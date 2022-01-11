__attribute__((noinline)) void foo() {}
__attribute__((noinline)) void baz() {}

int bar(int x) {
  // Should generate jumptable
  switch (x) {
  case 0:
    return 10;
  case 1:
    baz("-14");
  case 3:
    return -25;
  case 4:
    return -27;
  case 5:
    return 35;
  case 6:
    return 99;
  case 7:
    return 33;
  case 8:
    return 12;
  case 9:
    foo();
    return 12;
  }
}
