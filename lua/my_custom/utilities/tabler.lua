local extend = function(table_to_modify, items)
    for _, item in pairs(items)
    do
        table.insert(table_to_modify, item)
    end
end


local module = {}

module.extend = extend

return module
