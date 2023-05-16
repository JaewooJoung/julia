#∌ ∋ ∉ ∈ π ℯ ∛ √ √ ⊻ ⊋ ⊊ ⊉ ⊈ ⊇ ⊆ ≥ ≤ ∪ ∩ ⨳ ▷ ⩐ ⩒ ⩔ ⩖ ⩏ σ ϵ φ λ ∀ ◑ ◒ ◐ ◓ ✓
# 📁File 💬 SensorFusion.jl
# 📙Brief 💬 Shows How Sensor Fusion works
# 🧾Details 💬 Also shows how to get the Good Measurement(MMC) from the tested value
# 🚩OAuthor 💬 Original Author: Jaewoo Joung/郑在祐(jaewoo.joung@outlook.com)
# 👨‍🔧LAuthor 💬 Last Author: 陈柏州(baizhou.chen@geely.com)
# 📆LastDate 💬 2022-03-24 🔄Please support to keep update🔄
# 🏭License 🛑 JSD:Just Simple Distribution (a License made by Jaewoo)
# ✅Guarantee 💬 None
# ÷⋅∘∩⊻≢≡≠≉≈≈≉≠≡≢≥≤≥⊞ ⊟ ⊔ ⋓ ⧺ ⧻ ⨹ ⨺ ⩁ ⩂ ⩅ ⩊ ⩌ ⊍ 

#💬 functions for Checking Confusion Matrix 
TPR = (TP,FN) -> return(TP/(TP+FN)) #True Positive Ratio (Recall Rate)
TNR = (TN,FP) -> return(TN/(TN+FP)) #True Negative Ratio
FPR = (TN,FP) -> return(FP/(FP+TN)) # False Postive Ratio
FNR = (TP,FN) -> return(FN/(FN+TP)) #False Negative Ratio
PPV = (TP,FP) -> return(TP/(TP+FP)) #Postive Prediction Value (Precision)
NPV = (TN,FN) -> return(TN/(TN+FN)) #Negative Prediction Value
ACC = (TP,TN,FN,FP) -> return((TP+TN)/(TP+TN+FP+FN)) #Accuracy
BC = (TP,TN,FN,FP) -> return((TPR(TP,FN)+TNR(TN,FP))/2) #Balanced Accuracy
F1S = (TP,TN,FN,FP) -> return(2*((TPR(TP,FN)*PPV(TP,FP))/(TPR(TP,FN)+PPV(TP,FP)))) #F1 Score 
MCC = (TP,TN,FN,FP) -> return((TP*TN-FP*FN)/(√((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))) #MCC (Matthews Correlation Coefficient) MCC is bestways to see the performance of the Sensor 
rd = (x,dg=2) -> return(round(x; digits=dg))
function DP(CMM, TP,TN,FN,FP)# 💬 Display func.
    println(CMM)
    print("Sensitivity:-> ");print(rd(TPR(TP,FN)*100));println(" %")
    print("TNR:-> ");print(rd(TNR(TN,FP)*100));println(" %")
    print("FPR:-> ");print(rd(FPR(TN,FP)*100));println(" %")
    print("FNR:-> ");print(rd(FNR(TP,FN)*100));println(" %")
    print("Precision:-> ");print(rd(PPV(TP,FP)*100));println(" %")
    print("NPV:-> ");print(rd(NPV(TN,FN)*100));println(" %")
    print("Accuracy:-> ");print(rd(ACC(TP,TN,FN,FP)*100));println(" %")
    print("Balanced Accuracy:-> ");print(rd(BC(TP,TN,FN,FP)*100));println(" %")
    print("F1-Score:-> ");print(rd(F1S(TP,TN,FN,FP)*100));println(" %")
    print("Matthews Correlation Coefficient:-> ");print(MCC(TP,TN,FN,FP)*100);println(" %")  
end #END Display
function TestData(TS)
    USS = rand(Bool,TS) #USS detection
    Cam = rand(Bool,TS) #Camera Detection
    GT = rand(Bool,TS) #Ground Truth
    GTP=1;GTN=1;GFN=0;GFP=0 #initialize Ground Truth for show
    UTP=0;UTN=0;UFN=0;UFP=0 #initialize the USS confusion matrix
    CTP=0;CTN=0;CFN=0;CFP=0 #initialize the Camera confusion matrix
    for i in 1:length(GT)
        if (GT[i]) #True: There is something in realife
            (USS[i]) ? (UTP+=1) : (UFN+=1)
            (Cam[i]) ? (CTP+=1) : (CFN+=1)
        else #false: There is nothing in realife
            (USS[i]) ? (UFP+=1) : (UTN+=1)
            (Cam[i]) ? (CFP+=1) : (CTN+=1)
        end
    end
    UTP/=TS;UTN/=TS;UFN/=TS;UFP/=TS
    CTP/=TS;CTN/=TS;CFN/=TS;CFP/=TS
    DP("~~~~~~~ Ground Truth ~~~~~ ",GTP,GTN,GFN,GFP)
    DP("~~~~~~~ USS Sensor TEST ~~~~~ ",UTP,UTN,UFN,UFP)
    DP("~~~~~~~ Camera Sensor TEST ~~~~~ ",CTP,CTN,CFN,CFP)
end
#END function

TP=0.547945205479452
FP=0.150684931506849
FN=0.136986301369863
TN=0.164383561643836

DP("test model",TP,TN,FN,FP)
TestData(10000)
