int bar(int x, void (*f[])(int x)) {
  if (x > 0)
    f[0](x);
  f[1](x);
}
