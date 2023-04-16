#∌ ∋ ∉ ∈ π ℯ ∛ √ √ ⊻ ⊋ ⊊ ⊉ ⊈ ⊇ ⊆ ≥ ≤ ∪ ∩ ⨳ ▷ ⩐ ⩒ ⩔ ⩖ ⩏ σ ϵ φ λ ∀ ◑ ◒ ◐ ◓ ✓
# 📁File      💬 DSSADminMemory.jl
# 📙Brief     💬 Shows How DSSAD Memory works
# 🧾Details   💬 Also makes the C code variable for fun
# 🚩OAuthor   💬 Original Author: Jaewoo Joung/郑在祐(jaewoo.joung@outlook.com)
# 👨‍🔧LAuthor   💬 Last Author: Jaewoo Joung/郑在祐(jaewoo.joung@outlook.com)
# 📆LastDate  💬 2023-04-16 🔄Please support to keep update🔄
# 🏭License   🛑 JSD:Just Simple Distribution (a License made by Jaewoo)
# ✅Guarantee 💬 None
# ÷⋅∘∩⊻≢≡≠≉≈≈≉≠≡≢≥≤≥⊞ ⊟ ⊔ ⋓ ⧺ ⧻ ⨹ ⨺ ⩁ ⩂ ⩅ ⩊ ⩌  ⊍ 

using DataFrames

mutable struct MyData
    Variable_Name::String
    Explain::String
    Memory_Byte::Int
    count::Int
    sample_rate::Int
end


function add_data_to_dataframe(df::DataFrame, Variable_Name::String,Explain::String,Memory_Byte::Int,count::Int,sample_rate::Int)
    push!(df, (Variable_Name, Explain, Memory_Byte, count, sample_rate))
end

function convert_bytes(bytes::Int64)
    if bytes < 1024
        return "$(bytes) bytes"
    elseif bytes < 1024^2
        return "$(round(bytes/1024, digits=2)) KB"
    elseif bytes < 1024^3
        return "$(round(bytes/1024^2, digits=2)) MB"
    else
        return "$(round(bytes/1024^3, digits=2)) GB"
    end
end


function print_cpp_variables(df::DataFrame)
    str = ""
    for row in eachrow(df)
        if row.Memory_Byte == 16
            str *= "Int $(row.Variable_Name); //$(row.Explain)\n"
        elseif row.Memory_Byte == 128
            str *= "String $(row.Variable_Name); //$(row.Explain)\n"
        elseif row.Memory_Byte == 1
            str *= "bool $(row.Variable_Name); //$(row.Explain)\n"
        elseif row.Memory_Byte == 32
            str *= "float $(row.Variable_Name); //$(row.Explain)\n"
        end
    end
    return str
end


# Create an empty DataFrame with the appropriate columns
df = DataFrame(Variable_Name=[], Explain=[], Memory_Byte=[], count=[], sample_rate=[])

# Add all data
add_data_to_dataframe(df, "sDSSADm_tcs","time counter stamp",16,31,20)
add_data_to_dataframe(df, "sDSSADm_edrc","event data recording complete",1,31,20)
add_data_to_dataframe(df, "sDSSADm_ehd","engine hours download",32,1,1)
add_data_to_dataframe(df, "sDSSADm_odo","odometer",32,31,2)
add_data_to_dataframe(df, "sDSSADm_hd_hwp","HD EDR unit hardware part no.",128,1,2)
add_data_to_dataframe(df, "sDSSADm_hd_swp","HD EDR unit software part no.",128,1,2)
add_data_to_dataframe(df, "sDSSADm_dsr2vs","conversion factor between drive shaft rpm and vehicle speed",16,1,2)
add_data_to_dataframe(df, "sDSSADm_tt","trigger thresholds",32,1,2)
add_data_to_dataframe(df, "sDSSADm_tta","trigger threshold activated",16,1,2)
add_data_to_dataframe(df, "sDSSADm_vssm","vehicle safety system manifest",16,2,2)
add_data_to_dataframe(df, "sDSSADm_vs","vehicle speed",16,31,10)
add_data_to_dataframe(df, "sDSSADm_rtm","retarder torque mode",32,6,10)
add_data_to_dataframe(df, "sDSSADm_pbs","brake status - parking",32,31,10)
add_data_to_dataframe(df, "sDSSADm_sbs","brake status - service",32,31,10)
add_data_to_dataframe(df, "sDSSADm_es","engine speed",32,31,10)
add_data_to_dataframe(df, "sDSSADm_el","engine load",32,31,10)
add_data_to_dataframe(df, "sDSSADm_app","accelerator pedal position",32,31,10)
add_data_to_dataframe(df, "sDSSADm_mv_abs","ABS brake control status - motor vehicle",32,31,10)
add_data_to_dataframe(df, "sDSSADm_tr_abs","ABS brake control status - trailer",32,0,10)
add_data_to_dataframe(df, "sDSSADm_accm","adaptive cruise control mode",32,31,10)
add_data_to_dataframe(df, "sDSSADm_accmd","ACC mode",32,6,10)
add_data_to_dataframe(df, "sDSSADm_accsd","ACC set distance",32,31,10)
add_data_to_dataframe(df, "sDSSADm_ccs","cruise control states",32,31,10)
add_data_to_dataframe(df, "sDSSADm_aeb","automatic emergency braking",16,31,10)
add_data_to_dataframe(df, "sDSSADm_ldwsss","lane departure warning system state status",16,31,10)
add_data_to_dataframe(df, "sDSSADm_ldws","lane departure warning system state",32,31,10)
add_data_to_dataframe(df, "sDSSADm_swa","steering wheel angle",32,31,10)
add_data_to_dataframe(df, "sDSSADm_rpec","rollover protection engine control",32,31,10)
add_data_to_dataframe(df, "sDSSADm_rpec2","rollover protection engine control2",32,31,10)
add_data_to_dataframe(df, "sDSSADm_scsb","stability control system braking",32,31,2)
add_data_to_dataframe(df, "sDSSADm_scs","stability control system state",32,31,2)
add_data_to_dataframe(df, "sDSSADm_bswsvd","blind spot warning system status (vehicle detection)",32,31,10)
add_data_to_dataframe(df, "sDSSADm_bsws","blind spot warning system status",32,31,2)
add_data_to_dataframe(df, "sDSSADm_ct","crash type",32,31,10)
add_data_to_dataframe(df, "sDSSADm_dsbs","safety belt status (driver)",32,12,2)
add_data_to_dataframe(df, "sDSSADm_dseatbs","seat belt status (driver)",32,12,2)
add_data_to_dataframe(df, "sDSSADm_psbs","safety seat belt status (passenger)",32,12,2)
add_data_to_dataframe(df, "sDSSADm_fopsbs","seat belt status (front outboard passenger)",32,12,2)
add_data_to_dataframe(df, "sDSSADm_srs","safety restraint system status",32,1,2)
add_data_to_dataframe(df, "sDSSADm_vss","VRU secondary safety system status",32,1,2)
add_data_to_dataframe(df, "sDSSADm_lva","VRU alert - left side",16,31,10)
add_data_to_dataframe(df, "sDSSADm_rva","VRU alert - right side",16,31,10)
add_data_to_dataframe(df, "sDSSADm_fva","VRU alert - front",16,31,10)
add_data_to_dataframe(df, "sDSSADm_bva","VRU alert - rear",16,31,10)
add_data_to_dataframe(df, "sDSSADm_mdv","maximum delta-V, longitudinal",32,2,2)
add_data_to_dataframe(df, "sDSSADm_tmdv","time, maximum delta-V, longitudinal",32,2,2)
add_data_to_dataframe(df, "sDSSADm_rr","roll rate",32,31,10)
add_data_to_dataframe(df, "sDSSADm_pclfa","pre-crash low frequency longitudinal acceleration",32,31,10)
add_data_to_dataframe(df, "sDSSADm_pclflla","pre-crash low frequency lateral acceleration",32,31,10)
add_data_to_dataframe(df, "sDSSADm_aecs","accident emergency call system status",32,31,10)
add_data_to_dataframe(df, "sDSSADm_tpm","tyre pressure monitoring system warning lamp status",32,2,2)
add_data_to_dataframe(df, "sDSSADm_acsfca","automatically commanded steering function category A status",32,31,10)
add_data_to_dataframe(df, "sDSSADm_acsfcb","automatically commanded steering function category B status",32,31,10)
add_data_to_dataframe(df, "sDSSADm_acsfcc","automatically commanded steering function category C status",32,31,10)
add_data_to_dataframe(df, "sDSSADm_acsfcd","automatically commanded steering function category D status",32,31,10)
add_data_to_dataframe(df, "sDSSADm_acsfce","automatically commanded steering function category E status",32,31,10)

# Let's See it 
println(df)

# multiply  Memory_Byte * count * sample_rate
df[!, :product] = df.Memory_Byte .* df.count .* df.sample_rate

# Compute the sum of the product column
println(convert_bytes(sum(df.product)))

println(print_cpp_variables(df))
