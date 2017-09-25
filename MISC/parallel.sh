time wc -l lines.txt
time wc -l long-lines.txt

time fedora-25-wc -l lines.txt

time split -n$(nproc) --filter='wc -l' lines.txt | add
time split -n$(nproc) --filter='wc -l' long-lines.txt | add

time for i in $(seq $(nproc)); do
    split -n$i/$(nproc) lines.txt | wc -l&
  done | add
real	0m0.432s  # second fastest

time for i in $(seq $(nproc)); do
    split -n$i/$(nproc) long-lines.txt | wc -l&
  done | add
real	0m0.266s  # third fastest


time find -name 'l.*' -exec make -j$(nproc) {} + | add
time find -name 'll.*' -exec make -j$(nproc) {} + | add
