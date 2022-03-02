--! 4.1 할당문
--[[
  루아는 여러 값을 한번에 여러 변수에 대입하는 다중 할당을 지원함
]]
--[[
  local x = 4
  local a, b, c = 10, 2*x, nil
  print(a, b)
  a, b = b, a -- swap 'a' for 'b'
  print(a, b)
  a, b, c = 0, 1
  print(a, b, c) -- 0 1 nil
  a, b = a + 1, b + 1, b + 2 -- b + 2 값은 무시 됨
  print(a, b)    -- 1 2
  a, b, c = 0
  print(a, b, c) -- 0 nil nil
  --? lua의 다중 할당이 중요하게 쓰는 경우는 다중으로 값을 반환하는 경우임!!
]]

--! 4.2 지역 변수와 구역
--[[
  루아에는 전역변수 외에 지연변수도 있음(local)
  지역 변수는 선언된 구역(Block)으로만 범위가 한정됨
  선언된 구역 예시
  TODO : 제어구조, 함수의 몸체, 청크(변수가 선언된 파일이나 문자열)
]]
--[[
  x = 10
  local i = 1 -- 이 청크의 지역 변수

  while i <= x do
    local x = i*2 --while 안에서만 사용할 수 있는 지역 변수
    print(x)
    i = i + 1
  end

  if i > 20 then
    local x --'then'몸체의 지역 변수
    x = 20
    print(x + 2)
  else
    print(x) -- 10 (이 x는 위에서 선언한 전역변수임)
  end

  print(x)   -- 10 (이 x는 전역 변수)

  -- do ~ end 쓰는 경우도 있긴 함(주로 대화모드)
  -- do
  --   local a2 = 2 * a
  --   local d = (b^2 - 4*a*c)^(1/2)
  --   x1 = (-b+d)/a2
  --   x2 = (-b-d)/a2
  -- end   --'a2'와'd'의 범위는 여기서 끝임
  -- print(x1, x2)

  --? 루아에서는 지역변수를 적극적으로 활용하자!!

  --!1. 지역변수를 쓰면 굳이 필요하지 않은 이름으로 전역환경을 지저분하게 만드는 것을 피할 수 있음
  --!2. 전역변수에 접근하는 것보다 지역 변수에 접근하는 것이 더 빠름
  --!3. 지역변수는 유효범위가 끝나자마자 사라지므로 GC(가비지컬렉터)의 메모리 재사용을 용이하게 해줌


  local a, b = 1, 10
  if a < b then
    print(a)  -- 1
    local a   -- '=nil'이 생략된 것과 같음
    print(a)  -- nil
  end         -- 'then'으로 시작된 구역이 끝남
  print(a, b) -- 1 10

  --? 루아에는 전역변수를 로컬변수에 캐싱하는 관용표현이 있음
  local foo = foo -- 여기서 r-value는 전역변수

  -- 두가지 이점이 있음
  --!1. 이 관용 표현은 다른 함수에서 나중에 전역 변수 foo의 값을 바꾸더라도 청크에서 foo의 원래값을 유지할 수 있음
  --!2. foo에 접근하는 속도를 높이는 효과도 있음
  --TODO : 코딩의 좋은 습관 중 하나는 지역 변수를 필요할때마다 구역 중간에서 선언하는 것임
  --? 이는 변수를 초기화 없이 선언할 필요가 거의 없어지게됨, 또한 변수의 유효 범위를 줄여서 가독성을 높일 수 있음
]]

--! 4.3 제어 구조
--[[
  모든 제어문은 명시적으로 끝을 표현함
  if, for, while ~ end
  repeat ~ until
]]
  --! 4.3.1 if then else문
--? 간단해서 생략

  --! 4.3.2 while문
--[[
  조건이 참일 동안 몸체를 반복해서 실행함
  다른 언어의 while문과 마찬가지로 조건을 먼저 검사함
]]
--[[
  local i = 1
  local a = {}
  while a[i] do
    print(a[i])
    i = i + 1
  end
]]

  --! 4.3.3 repeat문
-- 다른 언어의 do ~ while문과 비슷하나 지역변수 범위가 약간 다름
--[[
  local line
  repeat
    line = io.read()
  until line ~= ''
  print(line .. '=')

  local x = 234
  local sqr = x/2
  repeat
    sqr = (sqr + x/sqr)/2
    local error = math.abs(sqr^2 - x)
  until error < x/10000 -- 지역변수 'error'를 여기서도 쓸 수 있음
  --! 지역변수의 범위가 repeat문안에서 선언한 것도 until에서 쓸수 있음
]]

  --! 4.3.4 수치 for문
--[[
  *루아에서의 for문은 수치 for문과 일반 for문 두 종류로 나뉨
]]
--[[
  -- 수치 for문
  for var = 1, 10, 2 do
    --<something>
    print(var*5)  -- var 1,3,5,7,9
  end

  -- 상한이 없이 반복하고 싶은 경우에는 math.huge쓰기
  for i = 1, math.huge do
    if (0.3*i^3 - 20*i^2 - 500 >= 0) then
      print(i)
      break
    end
  end

  TODO : for문에는 미묘한 점이 있어서 제대로 사용하기 위해서는 몇 가지 사항을 주의해야함
  !1. 조건식에 존재하는 문장들은 반복문이 실행전 한번씩 실행됨
  !2. 조건에 사용되는 제어변수는 for문 안에서만 사용 가능한 지역변수임
  !3. 반복문이 끝난 후의 제어 변수값이 필요한 경우 반드시 다른 값을 저장해 둬야 함
  !4. 제어변수의 값은 절대로 바꾸면 안됨(당연한거 아냐?)
--]]

  --! 4.3.5 일반 for문
--[[
  일반 for문은 반복자함수(pairs, ipairs)가 반환해 주는 모든 값에 대해 반복하는 문장
  특히 이 방법은 루아 기본 라이브러리에서 제공하는 테이블을 순회하는 데 편리함

  TODO : 루아에서는 테이블을 탐색하는 것은 별로임, 대신에 역참조 테이블을 만들어 버려서 찾음 ㅎㄷㄷ;
]]
--[[
  local days = {
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
  }

  -- 역참조 테이블 만들기
  local revDays = {}
  for k, v in pairs(days) do
    revDays[v] = k
  end

  local x = 'Tuesday'
  print(revDays[x]) --> 3
]]

--! 4.4 break, return, goto
--[[
  * break : 반복문을 끝내기 위해 사용 (for, repeat, while)
  * return : 함수를 그냥 끝내거나 함수를 끝내고 함수의 결과를 반환함
  * goto : 아무렇게나 쓸수는 없음, 일반적으로 continue, 다단계break, 다단계continue, redo, 지역오류
  *        등의 제어구조를 루아에서 흉내내기 위해 쓰는 경우
]]

::s1:: do
  local c = io.read(1)
  if c == '0' then goto s2
  elseif c == nil then print 'ok' ; return
  else goto s1
  end
end

::s2:: do
  local c = io.read(1)
  if c == '0' then goto s1
  elseif c == nil then print 'not ok'; return
  else goto s2
  end
end