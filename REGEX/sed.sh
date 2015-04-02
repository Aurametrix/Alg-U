# sed (stream editor) is a Unix utility that parses and transforms text, using a simple, compact programming language.
# usage:
# sed 's/regexp/replacement/g'
#  's/… = substitute
#  …/g' = global replace (otherwise will only replace first occurrence on a line!)

# simple examples
 eg.txt =  The cops saw the robber with the binoculars
 sed 's/robber/thief/g' eg.txt
 The cops saw the thief with the binoculars
 sed 's/^/She said, "/g' eg.txt
 She said, "The cops saw the robber with the binoculars
 sed 's/^/She said, "/g' eg.txt | sed 's/$/"/g'
 She said, "The cops saw the robber with the binoculars"
