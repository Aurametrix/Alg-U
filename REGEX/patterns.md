1. Find and replace a pattern in a codebase with capture groups
git grep -l pattern | xargs gsed -ri 's|pat(tern)|\1s are birds|g'

git grep -l: make sure we're only looking for files in our codebase (ag -l is another good option)
xargs: allow running this with gsed -i
gsed -i: edit files (default mac sed is bad, so gnu-sed is essential)
gsed -r: use regular expression for the pattern to allow capture groups
s|: the first character after the s is used as the delimiter. / is pretty consistently annoying because it's used in file paths & urls.
gsed '...': the single quotes are important to avoid escapes
's|pat(tern)|\1s are birds|g': being able to easily use capture groups in a find and replace is amazing
|g: replace this multiple times in a line
2. Track down a commit when a command started failing
while command; do git checkout HEAD^; done;

while command: As long as command exits successfully (with a 0), this loop will keep going. (this is why while true; works! The same thing works with if: if git grep yay; then echo "found yay"; fi)
git checkout HEAD^: go back in time.
git bisect is the "real" way to do this, but it's not something I've ever needed, and while command and while ! command are both generally useful to know
A similar pattern to poll until something succeeds could be while ! curl localhost:8080; do sleep 1; done;.
3. Parallelize running commands by grabbing PIDs.
pids="";
do_thing_1 &
pids="$pids $!"
do_thing_2 &
pids="$pids $!"
EXIT_CODE=0
for p in $pids; do
  if ! wait $p; then EXIT_CODE=1; fi
done

exit $EXIT_CODE;
4. Use $SECONDS to track how long things take
echo "Your command completed after $SECONDS seconds";

Try running this in your shell: SECONDS=0; sleep 5; echo $SECONDS;
I often prefer this over time when setting up logs for a script
5. Use for to iterate over simple lists:
for route in foo bar baz; do
  curl localhost:8080/$route
done
