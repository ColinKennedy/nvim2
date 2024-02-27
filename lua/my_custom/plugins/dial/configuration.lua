local augend = require("dial.augend")

require("dial.config").augends:register_group{
    default = {
        augend.constant.alias.bool,
        augend.constant.new{ elements = {"True", "False"} },
        augend.semver.alias.semver,
        augend.integer.alias.decimal,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
    },
}
