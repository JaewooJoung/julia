#functions
aNb2A = (a,b) -> return(rad2deg(atan(b/a))) #when you know a & b what is A 
aNb2B = (a,b) -> return(90-aNb2A(a,b)) #when you know a & b what is B
aNb2c = (a,b) -> return(√(a^2+b^2)) #when you know a & b what is c

aNc2b = (a,c) -> return(√(c^2-a^2)) #when you know a & c what is b
aNc2A = (a,c) -> return(rad2deg(acos(a/c))) #when you know a & c what is A
aNc2B = (a,c) -> return(90-aNc2A(a,c)) #when you know a & c what is B

aNA2b = (a,A) -> return(a*tan(deg2rad(A))) #when you know a & A what is b
aNA2c = (a,A) -> return(a/cos(deg2rad(A))) #when you know a & A what is c
aNA2B = (a,A) -> return(90-A) #when you know a & A what is B

bNA2a = (a,A) -> return(b/tan(deg2rad(A))) #when you know b & A what is a
bNA2c = (a,A) -> return(b/sin(deg2rad(A))) #when you know b & A what is c
bNA2B = (a,A) -> return(90-A) #when you know b & A what is B

bNc2A = (b,c) -> return(rad2deg(asin(b/c))) #when you know b & c what is A
bNc2B = (b,c) -> return(90-bNc2A(b,c)) #when you know b & c what is B
bNc2a = (b,c) -> return(√(c^2-b^2))  #when you know b & c what is a

cNA2a = (c,A) -> return(c*cos(deg2rad(A))) #when you know c & A what is a
cNA2b= (c,A) -> return(c*sin(deg2rad(A))) #when you know c & A what is b
cNA2B = (c,A) -> return(90-A) #when you know c & A what is B
a= 270; b= 175
c =350; A= 30
function input(prompt::AbstractString="")
    print(prompt)
    return chomp(readline())
end

response = input("Do you know a & b ? (Y/N)")
println(response)
if(response=="y")
    println(aNb2A(a,b))
    println(aNb2B(a,b))
    println(aNb2c(a,b))
    println()
    println(aNc2b(a,c))
    println(aNc2A(a,c))
    println(aNc2B(a,c))
    println()
    println(aNA2b(a,A))
    println(aNA2c(a,A))
    println(aNA2B(a,A))
    println()
    println(bNA2a(a,A))
    println(bNA2c(a,A))
    println(bNA2B(a,A))
    println()
    println(bNc2A(b,c))
    println(bNc2B(b,c))
    println(bNc2a(b,c))
    println()
    println(cNA2a(c,A))
    println(cNA2b(c,A))
    println(cNA2B(c,A))
    println("finished")
end
