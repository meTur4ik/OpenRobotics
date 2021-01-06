local Queue = {}
Queue.__index = Queue

function Queue:new()
    local obj = { first = 0, last = -1}
    setmetatable(obj, self)
    
    return obj
end

function Queue:pushLeft(value)
    local first = self.first - 1
    self.first = first
    self[first] = value
end

function Queue:pushRight(value)
    local last = self.last + 1
    self.last = last
    self[last] = value
end

function Queue:popLeft()
    local first = self.first
    if first > self.last then error('list is empty') end
    local value = self[first]
    self[first] = nil
    self.first = first + 1
    return value
end

function Queue:popRight()
    local last = self.last
    if self.first > last then error('list is empty') end
    local value = self[last]
    self[last] = nil
    self.last = last - 1
    return value
end

function Queue:empty()
    return self.first > self.last
end

function Queue:peekLeft()
    return self[self.first]
end

function Queue:peekRight()
    return self[self.last]
end

return Queue
