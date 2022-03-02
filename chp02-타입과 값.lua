print(type('Hello world')) -- string
print(type(10.4*3)) -- number
print(type(print)) -- function
print(type(type)) -- function
print(type(true)) -- boolean
print(type(nil))  -- nil
--[[
  type 함수는 항상 string으로 값을 반환하므로
  print(type(type(x)))은 항상 string을 출력하게됨
]]

--[[
  print(type(type(x)))  -- string

  print(type(a)) --> a가 초기화 되지않아도 상관없음
  local a = 10
  print(type(a)) --> number
  a = 'a string!!'
  print(type(a)) --> string
  a = print
  a(type(a))    --> function

  print(4)
  print(0.4)
  print(4.57e-3)
  print(0.3e12)
  print(5E+20)

  print(0xff)
  print(0x1A3)
  print(0x1a3)
  print(0x0.2)
  print(0x1p-1)
  print(0xa.bp2)

  a = 'one string'
  local b = string.gsub(a, 'one', 'another')
  print(a)
  print(b)
--]]

--[[
  a = 'hello'
  print(#a)
  print(#'good\0bye')

  print("one line\nnext line\n\"in quotes\", 'in quotes'")
  print('a backslash inside quotes: "\\"')
  print("a simpler way: '\\'")
  local page = [[
    <html>
    <head>
      <title>An HTML Page</title>
    </head>
    <body>
      <a href="http://www.lua.org">Lua</a>
    </body>
    </html>
  ]]

--[[
  print(page)

  local data = '\x00\x01\z
                  \x02\x03'

  print(data)
  print(type(data))

  -- 루아는 실행 중에 숫자와 문자열 사이의 자동 변환을 지원함!!
  print('10'+1) --11
  print('10+1') --10+1
  print('-5.3e-10'*'2') -- -1.06e-09
  -- print('hello'+1)  -- ERROR ('hello'로 변환 할 수 없음)
  --! 만약 10뒤에 바로 ..을 띄어쓰기 안하고 붙이면 소수점표기라고 해석해버리니깐 조심
  print(10 .. 20) --1020

  local num = '15'
  n = tonumber(num)
  if n == nil then
    error(num .. " is not a valid number")
  else
    print(n*2)
  end
--]]

-- 실수를 문자열로 바꾸는 다양한 방법
-- print(tostring(10)=='10')
-- print(10 .. ''=='10') -- 숫자와 빈 문자열을 합쳐서 문자열을 만듬

--[[
  테이블 타입은 연관 배열의 구현체임
  연관배열은 배열의 인덱스로 실수 외에도 nil을 제외한 나머지 모든 값을 쓸 수 있는 배열
  루아의 테이블은 평범한 자료구조 외에도 패키지나 객체를 표현하기 위해서도 사용함
  --! 루아의 테이블은 변수도 값도 아닌 객체임(테이블을 동적 할당된 객체라고 생각해도 됨)
  프로그램은 객체에 대한 참조나 포인터만 조작함
--]]
--[[
  local a = {}  -- 테이블을 생성하고 'A'로 참조하게 함
  k = 'x'
  a[k] = 10       -- 키가 'x'이고 값이 10인 원소를 추가
  a[20] = 'great' -- 키가 20이고 값이 'great'인 원소를 추가
  print(a['x'])
  k = 20
  print(a[k])     -- 'great'
  a['x'] = a['x'] + 1 --키가 'x'인 원소의 값을 1 증가
  print(a['x']) -- 11

  a = {}
  a['x'] = 10
  local b = a   -- 'b'는 'a'와 같은 테이블을 참조함
  print(b['x'])
  b['x'] = 20
  print(a['x'])
  a = nil
  b = nil

  a = {}
  -- 새 원소 1000개를 추가
  for i = 1, 1000 do a[i] = i*2 end
  print(a[9])
  a['x'] = 10
  print(a['x']) -- 10
  print(a['y']) -- nil

  a.x = 10  --a['x'] = 10과 같음
  print(a.x)
  print(a.y)

  a = {}
  x = 'y'
  a[x] = 10
  print(a[x])
  print(a.x)
  print(a.y)
--]]

--! 루아 테이블 인덱스
--[[
  루아에서는 테이블의 키값으로 문자열이나 숫자 둘다 사용 가능하므로 명시적으로 변환해서 하지않으면
  발견하기 힘든 버그를 생산해낼 수 있음
--]]
--[[
  local i, j, k = 10, '10', '+10'
  local a = {}
  a[i] = 'one value'
  a[j] = 'another value'
  a[k] = 'yet another value'
  print(a[i]) -- one value
  print(a[j]) -- another value
  print(a[k]) -- yet another value
  print(a[tonumber(j)]) -- one value
  print(a[tonumber(k)]) -- one value
--]]

--! 2.6 함수
--[[
  루아의 함수는 1급값임
  !즉 함수를 변수에 저장할 수 있고 다른 함수의 인자로 넘길 수 있으면 함수를 반환 받을 수도 있다는 말임
  이 특성으로 콜백함수를 사용할 때 매우 편리하게 함수포인터를 넘길 수 있음
  !또한 1급 함수는 객체 지향을 위한 기능에서 핵심 역할을 수행함
]]

--! 2.7 유저테이터와 스레드
--[[
  유저테이터 타입을 써서 임의의 C데이터를 루아 변수에 저장할 수 있다.
  !C로 작성된 응용 프로그램이나 라이브러리에서 정의한 새로운 타입을 표현하기 위해 유저데이터 사용
]]

--! 연습문제

--! 1번문제
--[[
  print(type(nil) == nil) -- 당연히 결과는 false
  ]]
--! 2번문제

-- local table = {
--   .e12, 0.0e, 0x12, 0xABFG, 0xA, FFFF, 0xFFFFFFFFF, 0x, 0x1P10, 0.1e1, 0x0.1p1
-- }

-- for i = 1, #table do
--   if type(table[i]) == 'number' then
--     print(table[i])
--   end
-- end