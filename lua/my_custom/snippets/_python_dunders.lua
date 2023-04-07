local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __abs__ method for a class",
            trig="abs",
        },
        format(
            [[
                def __abs__(self):
                    return {}
            ]],
            { index(1, "0") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __add__ method for a class",
            trig="add",
        },
        format(
            [[
                def __add__(self, other):
                    {}
            ]],
            { index(1, "return 0") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __call__ method for a class",
            trig="call",
        },
        format(
            [[
                def __call__(self{}):
                    {}
            ]],
            { index(1, ""), index(2, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __cmp__ method for a class",
            trig="cmp",
        },
        format(
            [[
                def __cmp__(self, other):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __complex__ method for a class",
            trig="complex",
        },
        format(
            [[
                def __complex__(self):
                    {}
            ]],
            { index(1, "return 1") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __contains__ method for a class",
            trig="contains",
        },
        format(
            [[
                def __contains__(self, item):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __contains__ method for a class",
            trig="contains",
        },
        format(
            [[
                def __contains__(self, item):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __del__ method for a class",
            trig="del",
        },
        format(
            [[
                def __del__(self):
                    {}
            ]],
            { index(1, "pass") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __delattr__ method for a class",
            trig="delattr",
        },
        format(
            [[
                def __delattr__(self, name):
                    {}
            ]],
            { index(1, "pass") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __delete__ method for a class",
            trig="delete",
        },
        format(
            [[
                def __delete__(self, instance):
                    del instance.{}
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __delitem__ method for a class",
            trig="delitem",
        },
        format(
            [[
                def __delitem__(self, key):
                    del self.{}[key]
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __div__ method for a class",
            trig="div",
        },
        format(
            [[
                def __div__(self, other):
                    {}
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __enter__ method for a class",
            trig="enter",
        },
        format(
            [[
                def __enter__(self):
                    {}
                    return {}
            ]],
            { index(1, ""), index(2, "self") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __eq__ method for a class",
            trig="eq",
        },
        format(
            [[
                def __eq__(self, other):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __exit__ method for a class",
            trig="exit",
        },
        format(
            [[
                def __exit__(self, exec_type, exec_value, traceback):
                    {}
            ]],
            { index(1, "pass") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __float__ method for a class",
            trig="float",
        },
        format(
            [[
                def __float__(self):
                    {}
            ]],
            { index(1, "return 0.0") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __floordiv__ method for a class",
            trig="floordiv",
        },
        format(
            [[
                def __floordiv__(self, other):
                    {}
            ]],
            { index(1, "return 0") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __ge__ method for a class",
            trig="ge",
        },
        format(
            [[
                def __ge__(self, other):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __get__ method for a class",
            trig="get",
        },
        format(
            [[
                def __get__(self, instance, owner):
                    return self.{}
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __getattr__ method for a class",
            trig="getattr",
        },
        format(
            [[
                def __getattr__(self, name):
                    {}
            ]],
            { index(1, "return") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __getattribute__ method for a class",
            trig="getattribute",
        },
        format(
            [[
                def __getattribute__(self, name):
                    {}
            ]],
            { index(1, "return") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __getitem__ method for a class",
            trig="getitem",
        },
        format(
            [[
                def __getitem__(self, key):
                    return self.{}[key]
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __gt__ method for a class",
            trig="gt",
        },
        format(
            [[
                def __gt__(self, other):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __gt__ method for a class",
            trig="gt",
        },
        format(
            [[
                def __gt__(self, other):
                    {}
            ]],
            { index(1, "return False") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __hash__ method for a class",
            trig="hash",
        },
        format(
            [[
                def __hash__(self):
                    {}
            ]],
            { index(1, "return") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __hex__ method for a class",
            trig="hex",
        },
        format(
            [[
                def __hex__(self):
                    return "{}"
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Set at beginning, only
    snippet(
        {
            docstring="Create a __iadd__ method for a class",
            trig="iadd",
        },
        format(
            [[
                def __iadd__(self, other):
                    {}
                    return self
            ]],
            { index(1, "return") }
        )
    ),
}

-- TODO: FINISH THIS
-- snippet iand "Create a __iand__ method for a class" b
-- def __iand__(self, other):
--     return ${1:pass}
-- endsnippet
--
-- snippet idiv "Create a __idiv__ method for a class" b
-- def __idiv__(self, other):
--     return $1
-- endsnippet
--
-- snippet ifloordiv "Create a __ifloordiv__ method for a class" b
-- def __ifloordiv__(self, other):
--     return $1
-- endsnippet
--
-- snippet ilshift "Create a __ilshift__ method for a class" b
-- def __ilshift__(self, other):
--     return $1
-- endsnippet
--
-- snippet imod "Create a __imod__ method for a class" b
-- def __imod__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet imul "Create a __imul__ method for a class" b
-- def __imul__(self, other):
--     return $1
-- endsnippet
--
-- snippet index "Create a __index__ method for a class" b
-- def __index__(self):
--     return ${1:0}
-- endsnippet
--
-- snippet init "Create a __init__ method for a class" b
-- def __init__(self$1):
--     ${2:pass}
-- endsnippet
--
-- snippet int "Create a __int__ method for a class" b
-- def __int__(self):
--     return ${1:0}
-- endsnippet
--
-- snippet invert "Create a __invert__ method for a class" b
-- def __invert__(self):
--     ${1:pass}
-- endsnippet
--
-- snippet ior "Create a __ior__ method for a class" b
-- def __ior__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet ipow "Create a __ipow__ method for a class" b
-- def __ipow__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet irshift "Create a __irshift__ method for a class" b
-- def __irshift__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet isub "Create a __isub__ method for a class" b
-- def __isub__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet iter "Create a __iter__ method for a class" b
-- def __iter__(self):
--     yield $1
-- endsnippet
--
-- snippet itruediv "Create a __itruediv__ method for a class" b
-- def __itruediv__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet ixor "Create a __ixor__ method for a class" b
-- def __ixor__(self, other):
--     ${1:pass}
-- endsnippet
--
-- snippet le "Create a __le__ method for a class" b
-- def __le__(self, other):
--     return ${1:False}
-- endsnippet
--
-- snippet len "Create a __len__ method for a class" b
-- def __len__(self):
--     return ${1:0}
-- endsnippet
--
-- snippet long "Create a __long__ method for a class" b
-- def __long__(self):
--     return $1
-- endsnippet
--
-- snippet lshift "Create a __lshift__ method for a class" b
-- def __lshift__(self, other):
--     return $1
-- endsnippet
--
-- snippet lt "Create a __lt__ method for a class" b
-- def __lt__(self, other):
--     return ${1:False}
-- endsnippet
--
-- snippet missing "Create a __missing__ method for a class" b
-- def __missing__(self, key):
--     ${1:pass}
-- endsnippet
--
-- snippet mod "Create a __mod__ method for a class" b
-- def __mod__(self, other):
--     return $1
-- endsnippet
--
-- snippet mul "Create a __mul__ method for a class" b
-- def __mul__(self, other):
--     return $1
-- endsnippet
--
-- snippet ne "Create a __ne__ method for a class" b
-- def __ne__(self, other):
--     return ${1:False}
-- endsnippet
--
-- snippet neg "Create a __neg__ method for a class" b
-- def __neg__(self):
--     return $1
-- endsnippet
--
-- snippet new "Create a __new__ method for a class" b
-- def __new__(self, mcs, clsname, bases, attrs):
--     return $1
-- endsnippet
--
-- snippet nonzero "Create a __nonzero__ method for a class" b
-- def __nonzero__(self):
--     return ${1:False}
-- endsnippet
--
-- snippet oct "Create a __oct__ method for a class" b
-- def __oct__(self):
--     return "$1"
-- endsnippet
--
-- snippet pos "Create a __pos__ method for a class" b
-- def __pos__(self):
--     return $1
-- endsnippet
--
-- snippet radd "Create a __radd__ method for a class" b
-- def __radd__(self, other):
--     return $1
-- endsnippet
--
-- snippet rcmp "Create a __rcmp__ method for a class" b
-- def __rcmp__(self, other):
--     return ${1:False}
-- endsnippet
--
-- snippet rdiv "Create a __rdiv__ method for a class" b
-- def __rdiv__(self, other):
--     return $1
-- endsnippet
--
-- snippet rdivmod "Create a __rdivmod__ method for a class" b
-- def __rdivmod__(self, other):
--     return $1
-- endsnippet
--
-- snippet repr "Create a __repr__ method for a class" b
-- def __repr__(self):
--     return "$1"
-- endsnippet
--
-- snippet reversed "Create a __reversed__ method for a class" b
-- def __reversed__(self):
--     for ${1:data} in reversed(self.$2):
--         yield ${1:data}
-- endsnippet
--
-- snippet rfloordiv "Create a __rfloordiv__ method for a class" b
-- def __rfloordiv__(self):
--     return $1
-- endsnippet
--
-- snippet rlshift "Create a __rlshift__ method for a class" b
-- def __rlshift__(self, other):
--     return $1
-- endsnippet
--
-- snippet rmod "Create a __rmod__ method for a class" b
-- def __rmod__(self, other):
--     return $1
-- endsnippet
--
-- snippet rmul "Create a __rmul__ method for a class" b
-- def __rmul__(self, other):
--     return $1
-- endsnippet
--
-- snippet ror "Create a __ror__ method for a class" b
-- def __ror__(self, other):
--     return $1
-- endsnippet
--
-- snippet rpow "Create a __rpow__ method for a class" b
-- def __rpow__(self, other):
--     return $1
-- endsnippet
--
-- snippet rrshift "Create a __rrshift__ method for a class" b
-- def __rrshift__(self, other):
--     return $1
-- endsnippet
--
-- snippet rshift "Create a __rshift__ method for a class" b
-- def __rshift__(self, other):
--     return $1
-- endsnippet
--
-- snippet rsub "Create a __rsub__ method for a class" b
-- def __rsub__(self, other):
--     return $1
-- endsnippet
--
-- snippet rtruediv "Create a __rtruediv__ method for a class" b
-- def __rtruediv__(self, other):
--     return $1
-- endsnippet
--
-- snippet rxor "Create a __rxor__ method for a class" b
-- def __rxor__(self, other):
--     return $1
-- endsnippet
--
-- snippet set "Create a __set__ method for a class" b
-- def __set__(self, instance, owner):
--     ${1:pass}
-- endsnippet
--
-- snippet setattr "Create a __setattr__ method for a class" b
-- def __setattr__(self, name, value):
--     ${1:pass}
-- endsnippet
--
-- snippet setitem "Create a __setitem__ method for a class" b
-- def __setitem__(self, key, value):
--     ${1:pass}
-- endsnippet
--
-- snippet str "Create a __str__ method for a class" b
-- def __str__(self):
--     return "$1"
-- endsnippet
--
-- snippet sub "Create a __sub__ method for a class" b
-- def __sub__(self, other):
--     return $1
-- endsnippet
--
-- snippet truediv "Create a __truediv__ method for a class" b
-- def __truediv__(self, other):
--     return $1
-- endsnippet
--
-- snippet unicode "Create a __unicode__ method for a class" b
-- def __unicode__(self):
--     return unicode($1)
-- endsnippet
--
-- snippet xor "Create a __xor__ method for a class" b
-- def __xor__(self, other):
--     return $1
-- endsnippet
