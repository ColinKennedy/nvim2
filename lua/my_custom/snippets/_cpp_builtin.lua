snippet #prag "#pragma once" Ab
#pragma once
endsnippet


snippet prag "#pragma once" Ab
#pragma once
endsnippet


snippet ii "#include" bA
#include <$1>
endsnippet


snippet ifndef "#ifndef pre-processor" bA
#ifndef
$1
#endif
endsnippet


snippet "^typedef" "Create a typedef line" rbA
typedef ${1:type} ${2:alias};
endsnippet


snippet for_iteration "Do a 'for (int index = 0; index < size; ++index)'-style loop"
for (${1:int} ${2:index} = 0; $2 < ${3:size}; ++$2) {
        $4
}
endsnippet


snippet for_each "Do a 'for (auto foo : bar)-style loop"
for (${1:auto} ${2:item} : ${3:items}) {
        $4
}
endsnippet

