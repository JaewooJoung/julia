using Dates


function chinese(year::Int)
    pinyin = Dict("甲" => "갑","乙" => "을","丙" => "병","丁" => "정","戊" => "무","己" => "기","庚" => "경","辛" => "신","壬" => "임","癸" => "계","子" => "자","丑" => "축","寅" => "인","卯" => "묘","辰" => "진","巳" => "사","午" => "오","未" => "미","申" => "신","酉" => "유","戌" => "술","亥" => "해")
    elements    = ["목(청색)", "화(적색)", "토(황색)", "금(백색)", "수(흑색)"]
    animals     = ["쥐(🐭)", "소(🐂)", "범(🐯)", "토끼(🐇)", "드래곤(🐉)", "뱀(🐍)", "말(🐴)", "양(🐏)", "원숭이(🐵)", "닭(🐔)", "개(🐶)", "돼지(🐷)"]
    celestial   = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    terrestrial = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    aspects     = ["양(+)", "음(-)"]
    base = 4
#
    cycleyear = year - base

    stemnumber = cycleyear % 10 + 1
    stemhan    = celestial[stemnumber]
    stempinyin = pinyin[stemhan]
  
    elementnumber = div(stemnumber, 2) +1
    (elementnumber >= 5) ? (element = elements[5]) : (element = elements[elementnumber])
    #element       = elements[elementnumber]

    branchnumber = cycleyear % 12 + 1
    branchhan    = terrestrial[branchnumber]
    branchpinyin = pinyin[branchhan]
    animal       = animals[branchnumber]

    aspectnumber = cycleyear % 2 + 1
    aspect       = aspects[aspectnumber]

    index = cycleyear % 60 + 1

    return "$year 년 [$stemhan$branchhan] 年 ($stempinyin$branchpinyin 년, $element $animal; $aspect 의 해 의며 육십갑자의 $index 번째 해)"
end

지금 = Dates.year(today())
println(chinese(지금))

🍎= 1
my = 🍎*3
println(my)
println(my)