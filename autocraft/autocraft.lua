local component = require('component')
local meController = component.me_controller
local shell = require('shell')

function wait(operation)
    while not operation.isDone()
    do
    end
    print('done')
end

local args, options = shell.parse(...)

if not args[1]
then
    local cr = meController.getCraftables()
    for i=1, cr.n
    do
        print(i, cr[i].getItemStack().label)
    end
end

local cr = meController.getCraftables()
local craftOp = nil
if args[1]
then
    craftOp = cr[args[1]].request(1)
else if args[1] and args[2]
then
    craftOp = cr[args[1].request(args[2])]
end

wait(craftOp)
