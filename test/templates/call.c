__attribute__((noinline))
#ifdef HIDDEN
__attribute__((visibility("hidden")))
#endif
void foo() {
}

void bar() { foo(); }
