# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 21:00:39 2021

@author: jaewoo.joung
"""

function makeadeck(조커=2)
    if (조커>2 || 조커<0) #혹시 조커를 두장이상 또는 0이하로 썻다면 그냥 두장으로 합니다.
        조커 = 2
    end
    #Tuple suit{무늬(카드뜻/함축의미)}: ♥(성직자/방어),♦(상인/돈),♣(농민/지혜),♠(기사/공격)
    Suit = ('♥','♦','♣','♠')
    DeckRank = ('A',2,3,4,5,6,7,8,9,10,'잭','퀸','킹')
    oneDeck =[]
    for i in 1:length(Suit)
        for j in 1:length(DeckRank)
            push!(oneDeck,(DeckRank[j],Suit[i],j))
        end
    end
    while 조커 > 0
        push!(oneDeck,('조','커',14))
        조커 -= 1
    end
    println("카드를 만듭니다.")
    return oneDeck
end

function shuffle(deck)
    maxnum = length(deck)
    for i in 1:1000
        mtemp = popat!(deck,rand(1:maxnum)) #하나를 골라서 뽑습니다.
        push!(deck,mtemp)                   #고른것을 다시 넣습니다.
    end
    println("카드를 섞습니다.")
    return deck
end

function F_Ace(m_sumVal,m_ACE)
    while m_ACE >0
        if ((m_sumVal >= 7)&&(m_sumVal <= 10))
             m_sumVal += 11
        else
             m_sumVal += 1
        end
        m_ACE -=1
    end
    return m_sumVal
end

function F_Jocker(m_sumVal,m_Jocker)
    while m_Jocker >0
        for i in 1:11
            m_sumVal += 1
            (m_sumVal >= 21) && break
        end
        m_Jocker -=1
    end
    return m_sumVal
end

function F_CalculateBest(m_deck,myDeck)
    m_ACE = 0 ; m_Jocker = 0
    m_size = length(m_deck)
    m_sumVal = 0
    local m_value
    while m_size >0
        m_card = popfirst!(m_deck)
        if (m_card[3]>1 && m_card[3]<11)
            m_sumVal += m_card[3]
        elseif m_card[3] == 1
            m_ACE +=1
        elseif ((m_card[3] > 10) && (m_card[3] < 14))
            m_sumVal += 10
        elseif m_card[3] == 14
            m_Jocker +=1
        end
        m_size -= 1
        push!(m_deck,m_card)
    end
    m_sumVal = F_Ace(m_sumVal,m_ACE)
    m_sumVal = F_Jocker(m_sumVal,m_Jocker)
    return m_sumVal
end

function F_display(myDeck)
    for i in 1:length(myDeck)
        m_card = popfirst!(myDeck)
        print("""( '$(m_card[1])❕':'$(m_card[2])' )""")
        push!(myDeck,m_card)
    end
end

function F_DealersTurn(dealerdeck,myDeck)
    sumofdealer = F_CalculateBest(dealerdeck,myDeck)
    while sumofdealer < 17
        push!(dealerdeck,deal(myDeck))
        sumofdealer = F_CalculateBest(dealerdeck,myDeck)
    end
    println("딜러")
    F_display(dealerdeck)
    sumofdealer > 21 ? (println(""" $sumofdealer 은 꽝(버스트)입니다 \n  제가 졌습니다.""")) : (println("컴퓨터는 $sumofdealer <-- 이숫자입니다. 도전하세요!"))
    return sumofdealer
end

function F_PlayerChoice(m_deck)
    m_size = length(m_deck)
    m_sumVal = 0
    local m_value
    while m_size >0
        m_card = popfirst!(m_deck)
        if (m_card[3]>1 && m_card[3]<11)
            m_sumVal += m_card[3]
        elseif m_card[3] == 1
            @label start1
            print("ACE를 1 로 할까요? 아니면 11로 할까요?: ")
            try
                m_value = parse(Int, readline())
            catch
                println("죄송합니다, 숫자가 아닙니다.")
                @goto start1
            end
            if ((m_value == 1) || (m_value == 11))
                println("감사합니다,",m_value, " 로 정했습니다.")
                m_sumVal +=m_value
            else
                println("죄송합니다, 1또는 11이 아닙니다.")
                @goto start1
            end
        elseif ((m_card[3] > 10) && (m_card[3] < 14))
            m_sumVal += 10
        elseif m_card[3] == 14
            @label start2
            print("조커를 1 부터 11중  무었으로 할까요?: ")
            try
                m_value = parse(Int, readline())
            catch
                println("죄송합니다, 숫자가 아닙니다.")
                @goto start2
            end
            if ((m_value >= 1) && (m_value <= 11))
                println("감사합니다,",m_value, " 로 정했습니다.")
                m_sumVal +=m_value
            else
                println("죄송합니다, 1또는 11이 아닙니다.")
                @goto start2
            end
        end
        m_size -= 1
        push!(m_deck,m_card)
    end
    return m_sumVal
end

function F_PlayerTurn(playerdeck,myDeck)
    Sumofuser = F_PlayerChoice(playerdeck)
    local m_recieve
    while Sumofuser < 21
        println("더 받으시겠습니까? Y/N  ")
        m_recieve = readline()
        if !((m_recieve == "Y") || (m_recieve == "y") || (m_recieve == "N")|| (m_recieve == "n"))
            println("죄송합니다, (원했던)문자가 아닙니다.")
            F_PlayerTurn(playerdeck,myDeck)
        elseif (m_recieve == "Y")|| (m_recieve == "y")
            println("카드를 뽑겠습니다.")
            push!(playerdeck,deal(myDeck))
            Sumofuser = F_PlayerChoice(playerdeck)
            F_display(playerdeck)
        elseif (m_recieve == "N")|| (m_recieve == "n")
            println("여기서 멈추겠습니다.")
            break
        else
            println("죄송합니다, Y또는 N이 아닙니다.")
            F_PlayerTurn(playerdeck,myDeck)
        end
    end
    return  Sumofuser
end

deal = deck -> return pop!(deck) #function

firstdeal(deck) = return [(deal(deck)) for i in 1:2]
########### Main program ###############
@time myDeck = makeadeck()
#println(myDeck)
@time myDeck = shuffle(myDeck)
#println(myDeck)
dealerdeck = firstdeal(myDeck)
playerdeck = firstdeal(myDeck)
Dealer_SUM = F_DealersTurn(dealerdeck,myDeck)
println("나의덱: ")
F_display(playerdeck)

if (Dealer_SUM < 22)
    Sumofuser = F_PlayerTurn(playerdeck,myDeck)
    if (Sumofuser > 21)
        println("당신이 졌습니다. TT","합산하면 $Sumofuser 입니다.")
    elseif (Dealer_SUM == Sumofuser)
        println("우리는 비겼습니다. :)","합산하면 $Sumofuser 입니다.")
    elseif (Dealer_SUM < Sumofuser)
        println("당신이 이겼습니다. :)","합산하면 $Sumofuser 입니다.")
    else
        println("당신이 졌습니다. TT","합산하면 $Sumofuser 입니다.")
    end
else
    println("당신이 이겼습니다. :)","합산하면 $Sumofuser 입니다.")
end
