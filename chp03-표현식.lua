--! 3.1 산술연산자
--[[
  루아의 대부분 산술 연산자들은 모두 실수로 작동함

  -- 나머지 연산의 정의
  a % b == a - math.floor(a/b)*b
  ]]
--[[
  local x = math.pi
  print(x - x%0.01) --x%0.01은 소수점 세번째 자릿수부터 출력
  ]]

--! 3.2 비교 연산
--[[
  비교 연산의 결과는 모두 불리언 타입임
  단, 특별히 nil은 오직 nil과 같음
]]

--! 3.3 논리 연산자
--[[
  and, or, not
  -- and
  !첫번째 인자가 거짓이면 그 인자의 값을 반환하고 참이면 두번째 값은 반환함
  -- or
  !and와 반대로 첫번째 인자가 참이면 그 인자를 반환하고 거짓이면 두번째 값을 반환함
  -- not
  !not은 항상 boolean값을 반환하고 <false,nil : true , 그 외 : false> 반환
]]
--[[
  -- 유용한 관용표현
  local x = 10
  local y = 100
  local max = (x > y) and x or y --C에서 3항연산자인 max ? x : y와 같음
  -- x>y가 참이면 x를 반환하고 다시 or연산에서 x가 실수여서 참이므로 최종적으로 x반환
  -- x>y가 거짓이면 false를 반환하고 다시 or연산에서 두번째 피연산자인 y반환
  print(max)
]]

--! 3.4 이어 붙이기
--[[
  -- ..
  루아에서는 이어붙이기 연산자(..)의 피연산자는 실수일때 문자열로 변환함
  !명심할 것은 루아에서 이어붙이기 연산자가 있더라도 기존 문자열을 수정한 것이 아님
  !기존 문자열에 붙일 문자열을 합쳐서 새로운 문자열을 반환함
]]
--[[
  print('Hello ' .. 'World')
  print(0 .. 1)
  print(000 .. 1) -- 0001아님! 01임 000 = 0
  a = 'Hello'
  print(a .. ' World')
  print(a)  -- 기존 문자열은 그대로임
]]

--! 3.5 길이 연산자
--[[
  #
  길이 연산자는 문자열과 테이블에 쓰임
  !더 정확하게 말하면 비어있는 공간이 없는(nil이 없는) 리스트로 정의된 순열에만 유효함
  !항상 명심할 것은 값이 nil인 키는 실제로 테이블에 없는 것이라는 사실을 잊지 말자~~~~
  ?내가 다루는 순열인 테이블이 중간에 nil값이 있는 경우에는 실제 길이를 어딘가에 보관해놔야 함!
]]
--[[
  local a = {}
  a[1] = 1
  a[#a+1] = 2
  a['abc'] = 3
  print(a[#a])
  for _, v in pairs(a) do
    print(v)
  end
  a[#a] = nil
  a[#a+1] = 'v'
  a = {10, 20, 30, nil, nil}
  print(#a)
]]

--! 3.6 연산 우선순위
--[[
  ?위에서 부터 차례대로 우선순위가 높음
  1. ^
  2. not # - (단항)
  3. * / %
  4. + -
  5. ..
  6. < > <= >= ~= ==
  7. and
  8. or
  ^ 과 .. 연산자는 오른쪽 결합순이고 나머지는 왼쪽 결합순
]]
--예시
--[[
  a+i < b/2+1  ===== (a+i) < ((b/2)+1)
  5+x^2*8      ===== 5+((x^2)*8)
  a<y and y<=z ===== (a<y) and (y<=z)
  -x^2         ===== -(x^2)
  x^y^z        ===== x^(y^z)
]]

--! 3.7 테이블 생성자
-- 순열로 초기화
--[[
  local days = {
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
  }
  print(days[4]) -- Wednesday, 루아는 1번부터 순열 시작임

  --레코드 형식으로 초기화
  -- a = {}; a.x = 10; a.y = 20 이것과 아래는 같은 방법으로 초기화 한 것임
  local a = {x = 10, y = 20}

  for _, v in pairs(a) do
    print(v)
  end
  --!단, 첫번째 예시가 당연하게도 더 빠름(얼만큼 크기로 할지 이미 알고 있어서)

  -- 생성자를 사용해서 테이블을 생성해도 항상 필드를 추가 및 제거 가능
  local w = {
    x = 0,
    y = 0,
    label = 'console'
  }
  local x = {
    math.sin(0),
    math.sin(1),
    math.sin(2),
  }
  w[1] = 'another field'
  x.f = w
  print(w['x']) -- 0
  print(w[1])   -- 'another field'
  print(x.f[1]) -- 'another filed'
  w.x = nil
  --! 단 이 방법은 별로 보기 안좋음

  local polyline = {
    -- 레코드 스타일 초기화
    -- 여기서 color, thickness, npoints는 식별자
    color = 'blue',
    thickness = 2,
    npoints = 4,
    -- 리스트 스타일 초기화
    {x = 0, y = 0},   -- polyline[1]
    {x = -10, y = 0}, -- polyline[2]
    {x = -10, y = 1}, -- polyline[3]
    {x = 0, y = 1}    -- polyline[4]
  }
  print(polyline[2].x)
  print(polyline[4].y)
  --!이러한 방식들의 한계는 음수인덱스나 식별자가 아닌 문자열 인덱스로 필드를 초기화 할 수 없음

  local opnames = {
    ['+'] = 'add',
    ['-'] = 'sub',
    ['*'] = 'mul',
    ['/'] = 'div'
  }

  local i, s = 20, '-'
  a = {
    [i+0] = s,
    [i+1] = s .. s,
    [i+2] = s .. s .. s,
  }
  print(opnames[s]) -- sub
  print(a[22])      -- ---
  --! 루아의 테이블은 이러한 유연성때문에
  --!생성자 코드를 자동 생성하는 프로그램에서 마지막 요소를 특수처리할 필요 없음

  -- 그리고 이 책의 저자는 레코드 스타일 초기화와 리스트 스타일 초기화를 구분하기 위해 세미콜론 씀
  local example = {x = 10, y = 45; 'one', 'two', 'three'}
]]

--! 연습문제
-- 3.1
for i = -10, 10 do
  print(i, i % 3)
end

print(2^3^4)
print(2^-3^4)