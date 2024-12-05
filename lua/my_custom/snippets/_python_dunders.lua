--- Add "double underscore" snippets.
---
---@module 'my_custom.snippets._python_dunders'
---

local texter = require("my_custom.utilities.texter")

local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local index = luasnip.i
local snippet = luasnip.s


-- TODO: When treesitter is working, add a check for "if inside of a class"
--- Check if `trigger` matches the current cursor line.
---
---@param trigger string Some LuaSnip trigger.
---@return fun(line_to_cursor: string): boolean # Returns `true` if the line matches.
---
local function is_dunder_prefix(trigger)
    local wrapper = function(line_to_cursor)
        -- If there is no indent, it can't be a Python dunder method
        if not texter.has_leading_whitespace(line_to_cursor)
        then
            return false
        end

        return is_source_beginning(trigger)(line_to_cursor)
    end

    return wrapper
end


return {
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
        ),
        { show_condition = is_dunder_prefix("abs") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("add") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("call") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("cmp") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("complex") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("contains") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("del") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("delattr") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("delete") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("delitem") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("div") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("enter") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("eq") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("exit") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("float") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("floordiv") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("ge") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("get") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("getattr") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("getattribute") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("getitem") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("gt") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("hash") }
    ),

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
        ),
        { show_condition = is_dunder_prefix("hex") }
    ),

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
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("iadd") }
    ),

    snippet(
        {
            docstring="Create a __iand__ method for a class",
            trig="iand",
        },
        format(
            [[
                def __iand__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("iand") }
    ),

    snippet(
        {
            docstring="Create a __idiv__ method for a class",
            trig="idiv",
        },
        format(
            [[
                def __idiv__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("idiv") }
    ),

    snippet(
        {
            docstring="Create a __ifloordiv__ method for a class",
            trig="ifloordiv",
        },
        format(
            [[
                def __ifloordiv__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("ifloordiv") }
    ),

    snippet(
        {
            docstring="Create a __ilshift__ method for a class",
            trig="ilshift",
        },
        format(
            [[
                def __ilshift__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("ilshift") }
    ),

    snippet(
        {
            docstring="Create a __imod__ method for a class",
            trig="imod",
        },
        format(
            [[
                def __ilshift__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("imod") }
    ),

    snippet(
        {
            docstring="Create a __imul__ method for a class",
            trig="imul",
        },
        format(
            [[
                def __imul__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("imul") }
    ),

    snippet(
        {
            docstring="Create a __index__ method for a class",
            trig="index",
        },
        format(
            [[
                def __index__(self):
                    return {}
            ]],
            { index(1, "0") }
        ),
        { show_condition = is_dunder_prefix("index") }
    ),

    snippet(
        {
            docstring="Create a __init__ method for a class",
            trig="init",
        },
        format(
            [[
                def __init__(self{}):
                    {}
            ]],
            { index(1, ""), index(2, "pass") }
        ),
        { show_condition = is_dunder_prefix("init") }
    ),

    snippet(
        {
            docstring="Create a __int__ method for a class",
            trig="int",
        },
        format(
            [[
                def __int__(self):
                    return {}
            ]],
            { index(1, "0") }
        ),
        { show_condition = is_dunder_prefix("int") }
    ),

    snippet(
        {
            docstring="Create a __invert__ method for a class",
            trig="invert",
        },
        format(
            [[
                def __invert__(self):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("invert") }
    ),

    snippet(
        {
            docstring="Create a __ior__ method for a class",
            trig="ior",
        },
        format(
            [[
                def __ior__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("ior") }
    ),

    snippet(
        {
            docstring="Create a __ipow__ method for a class",
            trig="ipow",
        },
        format(
            [[
                def __ipow__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("ipow") }
    ),

    snippet(
        {
            docstring="Create a __irshift__ method for a class",
            trig="irshift",
        },
        format(
            [[
                def __irshift__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("irshift") }
    ),

    snippet(
        {
            docstring="Create a __isub__ method for a class",
            trig="isub",
        },
        format(
            [[
                def __isub__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("isub") }
    ),

    snippet(
        {
            docstring="Create a __iter__ method for a class",
            trig="iter",
        },
        format(
            [[
                def __iter__(self):
                    yield {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("iter") }
    ),

    snippet(
        {
            docstring="Create a __itruediv__ method for a class",
            trig="itruediv",
        },
        format(
            [[
                def __itruediv__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("itruediv") }
    ),

    snippet(
        {
            docstring="Create a __ixor__ method for a class",
            trig="ixor",
        },
        format(
            [[
                def __ixor__(self, other):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("ixor") }
    ),

    snippet(
        {
            docstring="Create a __le__ method for a class",
            trig="le",
        },
        format(
            [[
                def __le__(self, other):
                    return {}
            ]],
            { index(1, "False") }
        ),
        { show_condition = is_dunder_prefix("le") }
    ),

    snippet(
        {
            docstring="Create a __len__ method for a class",
            trig="len",
        },
        format(
            [[
                def __len__(self):
                    return {}
            ]],
            { index(1, "0") }
        ),
        { show_condition = is_dunder_prefix("len") }
    ),

    snippet(
        {
            docstring="Create a __long__ method for a class",
            trig="long",
        },
        format(
            [[
                def __long__(self):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("long") }
    ),

    snippet(
        {
            docstring="Create a __lshift__ method for a class",
            trig="lshift",
        },
        format(
            [[
                def __lshift__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("lshift") }
    ),

    snippet(
        {
            docstring="Create a __lt__ method for a class",
            trig="lt",
        },
        format(
            [[
                def __lt__(self, other):
                    return {}
            ]],
            { index(1, "False") }
        ),
        { show_condition = is_dunder_prefix("lt") }
    ),

    snippet(
        {
            docstring="Create a __missing__ method for a class",
            trig="missing",
        },
        format(
            [[
                def __missing__(self, key):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("missing") }
    ),

    snippet(
        {
            docstring="Create a __mod__ method for a class",
            trig="mod",
        },
        format(
            [[
                def __mod__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("mod") }
    ),

    snippet(
        {
            docstring="Create a __mul__ method for a class",
            trig="mul",
        },
        format(
            [[
                def __mul__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("mul") }
    ),

    snippet(
        {
            docstring="Create a __ne__ method for a class",
            trig="ne",
        },
        format(
            [[
                def __ne__(self, other):
                    return {}
            ]],
            { index(1, "False") }
        ),
        { show_condition = is_dunder_prefix("ne") }
    ),

    snippet(
        {
            docstring="Create a __neg__ method for a class",
            trig="neg",
        },
        format(
            [[
                def __neg__(self):
                    return {}
            ]],
            { index(1, "False") }
        ),
        { show_condition = is_dunder_prefix("neg") }
    ),

    snippet(
        {
            docstring="Create a __new__ method for a class",
            trig="new",
        },
        format(
            [[
                def __new__(self, mcs, clsname, bases, attrs):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("new") }
    ),

    snippet(
        {
            docstring="Create a __nonzero__ method for a class",
            trig="nonzero",
        },
        format(
            [[
                def __nonzero__(self):
                    return {}
            ]],
            { index(1, "False") }
        ),
        { show_condition = is_dunder_prefix("nonzero") }
    ),

    snippet(
        {
            docstring="Create a __oct__ method for a class",
            trig="oct",
        },
        format(
            [[
                def __oct__(self):
                    return "{}"
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("oct") }
    ),

    snippet(
        {
            docstring="Create a __pos__ method for a class",
            trig="pos",
        },
        format(
            [[
                def __pos__(self):
                    return "{}"
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("pos") }
    ),

    snippet(
        {
            docstring="Create a __radd__ method for a class",
            trig="radd",
        },
        format(
            [[
                def __radd__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("radd") }
    ),

    snippet(
        {
            docstring="Create a __rcmp__ method for a class",
            trig="rcmp",
        },
        format(
            [[
                def __rcmp__(self, other):
                    return {}
            ]],
            { index(1, "False") }
        ),
        { show_condition = is_dunder_prefix("rcmp") }
    ),

    snippet(
        {
            docstring="Create a __rdiv__ method for a class",
            trig="rdiv",
        },
        format(
            [[
                def __rdiv__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rdiv") }
    ),

    snippet(
        {
            docstring="Create a __rdivmod__ method for a class",
            trig="rdivmod",
        },
        format(
            [[
                def __rdivmod__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rdivmod") }
    ),

    snippet(
        {
            docstring="Create a __repr__ method for a class",
            trig="repr",
        },
        format(
            [[
                def __repr__(self):
                    return "{{self.__class__.__name__}}({})".format(self=self)
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("repr") }
    ),

    snippet(
        {
            docstring="Create a __reversed__ method for a class",
            trig="reversed",
        },
        format(
            [[
                def __reversed__(self):
                    for {} in reversed(self.{}):
                        yield {}
            ]],
            { index(1, "data"), index(2, ""), rep(1) }
        ),
        { show_condition = is_dunder_prefix("reversed") }
    ),

    snippet(
        {
            docstring="Create a __rfloordiv__ method for a class",
            trig="rfloordiv",
        },
        format(
            [[
                def __rfloordiv__(self, other):
                    {}
            ]],
            { index(1, "return 0") }
        ),
        { show_condition = is_dunder_prefix("rfloordiv") }
    ),

    snippet(
        {
            docstring="Create a __rlshift__ method for a class",
            trig="rlshift",
        },
        format(
            [[
                def __rlshift__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rlshift") }
    ),

    snippet(
        {
            docstring="Create a __rmod__ method for a class",
            trig="rmod",
        },
        format(
            [[
                def __rmod__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rmod") }
    ),

    snippet(
        {
            docstring="Create a __rmul__ method for a class",
            trig="rmul",
        },
        format(
            [[
                def __rmul__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rmul") }
    ),

    snippet(
        {
            docstring="Create a __ror__ method for a class",
            trig="ror",
        },
        format(
            [[
                def __ror__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("ror") }
    ),

    snippet(
        {
            docstring="Create a __rpow__ method for a class",
            trig="rpow",
        },
        format(
            [[
                def __rpow__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rpow") }
    ),

    snippet(
        {
            docstring="Create a __rrshift__ method for a class",
            trig="rrshift",
        },
        format(
            [[
                def __rrshift__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rrshift") }
    ),

    snippet(
        {
            docstring="Create a __rshift__ method for a class",
            trig="rshift",
        },
        format(
            [[
                def __rshift__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rshift") }
    ),

    snippet(
        {
            docstring="Create a __rsub__ method for a class",
            trig="rsub",
        },
        format(
            [[
                def __rsub__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rsub") }
    ),

    snippet(
        {
            docstring="Create a __rtruediv__ method for a class",
            trig="rtruediv",
        },
        format(
            [[
                def __rtruediv__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rtruediv") }
    ),

    snippet(
        {
            docstring="Create a __rxor__ method for a class",
            trig="rxor",
        },
        format(
            [[
                def __rxor__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("rxor") }
    ),

    snippet(
        {
            docstring="Create a __set__ method for a class",
            trig="set",
        },
        format(
            [[
                def __set__(self, instance, owner):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("set") }
    ),

    snippet(
        {
            docstring="Create a __setattr__ method for a class",
            trig="setattr",
        },
        format(
            [[
                def __setattr__(self, name, value):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("setattr") }
    ),

    snippet(
        {
            docstring="Create a __setitem__ method for a class",
            trig="setitem",
        },
        format(
            [[
                def __setitem__(self, key, value):
                    {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_dunder_prefix("setitem") }
    ),

    snippet(
        {
            docstring="Create a __str__ method for a class",
            trig="str",
        },
        format(
            [[
                def __str__(self):
                    return "<{{self.__class__.__name__}} {}>".format(self=self)
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("str") }
    ),

    snippet(
        {
            docstring="Create a __sub__ method for a class",
            trig="sub",
        },
        format(
            [[
                def __sub__(self, other):
                    {}
            ]],
            { index(1, "return blah") }
        ),
        { show_condition = is_dunder_prefix("sub") }
    ),

    snippet(
        {
            docstring="Create a __truediv__ method for a class",
            trig="truediv",
        },
        format(
            [[
                def __truediv__(self, other):
                    return "{}"
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("truediv") }
    ),

    snippet(
        {
            docstring="Create a __unicode__ method for a class",
            trig="unicode",
        },
        format(
            [[
                def __unicode__(self):
                    return unicode({})
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("unicode") }
    ),

    snippet(
        {
            docstring="Create a __xor__ method for a class",
            trig="xor",
        },
        format(
            [[
                def __xor__(self, other):
                    return {}
            ]],
            { index(1, "") }
        ),
        { show_condition = is_dunder_prefix("xor") }
    )
}
