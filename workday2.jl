using Dates, HTTP, JSON


function is_workday(date::Date, holidays)::Bool
    # check if the date is a weekend day
    if dayofweek(date) == 6|| dayofweek(date) == 7
        return false
    end
    
    # check if the date is a national holiday
    if holidays != nothing && date in holidays
        return false
    end
    
    return true
end

function get_holidays(country::String)
    # check if the country is supported
    if country ∉ ["KR", "SE", "US", "CN" ]
        return nothing
    end
    
    # retrieve the national holidays from an API
    response = HTTP.get("https://date.nager.at/api/v3/publicholidays/$(Dates.year(now()))/$(country)")
    
    # convert the holiday dates to Date objects
    #holiday_dates = parse_dates(String(response.body))
    json_data = JSON.parse(String(response.body))
    holiday_dates = [d["date"] for d in json_data]
    return holiday_dates
end


function workdays_between(start_date::Date, end_date::Date, country::String)::Int
    # iterate over each day in the date range and count the workdays
    workdays = 0
    mHolidays=get_holidays(country)
    mdate = start_date
    while mdate <= end_date
        if is_workday(mdate, mHolidays)
            workdays += 1
        end
        mdate += Day(1)
    end
    
    return workdays
end

start_date = Date(2023, 4, 1)
FSD = String(Dates.monthname(start_date;locale="english"))

end_date = Date(2023, 9, 30)
FED = Dates.format(end_date, "B d, Y")
FED = replace(FED, " 0" => " ")
FED = replace(FED, ", 0" => ", ")
country = "SE"
WD = workdays_between(start_date, end_date, country)
MHC = 333 #Man Hour Cost
BC = MHC*8*WD


println("Just to confirm, the number of working days in $country from $FSD to $FED is $WD days. \n Based on your man hour cost of $MHC SEK, the basic cost for this period will be $BC SEK.")
