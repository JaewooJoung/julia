using Dates, HTTP, JSON

function is_workday(date::Date, country::String)::Bool
    # check if the date is a weekend day
    if dayofweek(date) == "Saturday"|| dayofweek(date) == "Sunday"
        return false
    end
    
    # check if the date is a national holiday
    holidays = get_holidays(country)
    if holidays != nothing && date in holidays
        return false
    end
    
    return true
end

function parse_dates(json_string::AbstractString)
    events = JSON.parse(json_string)
    dates = Date.(getproperty.(events, :date), "yyyy-mm-dd")
    println(dates)
    return dates
end

function get_holidays(country::String)::Union{Nothing, Array{Date,1}}
    # check if the country is supported
    if country ∉ ["KR", "CN", "SE", "US"]
        return nothing
    end
    
    # retrieve the national holidays from an API
    response = HTTP.get("https://date.nager.at/api/v3/publicholidays/$(Dates.year(now()))/$(country)")
    
    # convert the holiday dates to Date objects
    holiday_dates = parse_dates(String(response.body))
    
    return holiday_dates
end

function workdays_between(start_date::Date, end_date::Date, country::String)::Int
    # iterate over each day in the date range and count the workdays
    workdays = 0
    date = start_date
    while date <= end_date
        if is_workday(date, country)
            workdays += 1
        end
        date += Day(1)
    end
    
    return workdays
end

start_date = Date(2023, 3, 1)
end_date = Date(2023, 3, 31)
country = "SE"
workdays = workdays_between(start_date, end_date, country)
println("There are $workdays workdays between $start_date and $end_date in $country.")
