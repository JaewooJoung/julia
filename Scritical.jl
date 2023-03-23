using Dates
#Short functions
fkph2mpms = Kph -> return(Kph/3.6) #KPH to Meter Per Sec function
fmps2kph = mps -> return(mps*3.6) #Meter Per Sec to KPH function
TTC = (Kph,distance) -> return(distance/fkph2mpms(Kph))
RelativeSPD = (MySpeed,OtherSpeed) -> return(abs(MySpeed-OtherSpeed))
Scritical = (𝑎,tG,tB,vRear,vACSF) -> return(((vRear - vACSF) * tB) + ((vRear - vACSF)^2)/ (2 * 𝑎) + vACSF * tG)
VSmin = (𝑎,tG,tB,Vapp,Srear) -> return(𝑎 * (tB - tG) + Vapp - √(𝑎^2 * (tB - tG)^2 - 2 * 𝑎 * (Vapp * tG - Srear)))
#END Short functions
#define
mycarspeed = 60
othercarspeed = 130
Srear = 70 #meter Srear shall be declared by the OEM. The value shall not be less than 55 m. 
Vapp = fkph2mpms(othercarspeed) #km/h 
a = 3 #m/s² Deceleration of the approaching vehicle)
tB = 0.4 #s (deceleration of the approaching vehicle starts)
tG = 1 #s (Remaining gap of the vehicles after the deceleration of the approaching vehicle)
vrear = fkph2mpms(othercarspeed) #km/h 
vACSF = fkph2mpms(mycarspeed) #km/h
#end define
#excute
println(Date(today())," generated report")
println("Vs_min: ",fmps2kph(VSmin(a,tG,tB,Vapp,Srear))," KPH")
println("S_critical: ",Scritical(a,tG,tB,vrear,vACSF)," Meter")
println("Time To Collision : ",TTC(RelativeSPD(mycarspeed,othercarspeed),Srear), " Second")
println(fmps2kph(10))
println(string(now()))
