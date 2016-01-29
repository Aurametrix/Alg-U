log(){
  pushd ~/logs;
  echo >> $*;
  date >> $*;
  cat >> $*;
  } 
