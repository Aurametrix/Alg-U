void func() {
  sigset_t block;
  sigemptyset(&block);
  sigaddset(&block, SIGTERM);
  sigsetmask(SIG_BLOCK, &block, NULL);
  //DoSomething critical
  sigsetmask(SIG_UNBLOCK, &block, NULL);
}
