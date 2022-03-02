print('Hello World')

local function fact(n)
  if n < 0 then
    return print('음수는 입력하면 안됨!')
  end
  if n == 0 then
    return 1
  else
    return n * fact(n - 1)
  end
end

local a = 1
local NULL = 2
print(NULL)
print(fact(a))

dofile('example\\lib1.lua')
local n = norm(3.4, 1.0)
print(twice(n))