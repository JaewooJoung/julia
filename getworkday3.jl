using Dates,DataFrames, XLSX

function get_week2date(year::Int, week::Int)
    first_day = Date(year, 1, 1)
    first_day_of_week = first_day - Dates.Day(dayofweek(first_day) - 1)
    days_to_add = 7 * (week)
    monday_date = first_day_of_week + Dates.Day(days_to_add)
    return monday_date
end

function get_date2week(date::Date)
    week_number = week(date)
    return week_number
end

function is_workday(date::Date)
    day_of_week = Dates.dayofweek(date)
    return day_of_week != Dates.Saturday && day_of_week != Dates.Sunday
end

function count_days(start_date::Date, end_date::Date)
    total_days = Dates.value(end_date - start_date) + 1
    return total_days
end

function add_work(start_date::Date, num_days::Int)
    current_date = start_date
    workdays_added = 0
    
    while workdays_added < num_days
        current_date += Dates.Day(1)
        if is_workday(current_date)
            workdays_added += 1
        end
    end
    
    return current_date
end
function Typecheck(input)
    if typeof(input) == Date
        return true
    elseif typeof(input) == String
        return false
    else
        println("Invalid input")
    end
end

function print_dataframe(df::DataFrame)
    Current = Date(2024, 1, 1)
    FollowFlag = false
    for (i, row) in enumerate(eachrow(df))
        # Store each column value in separate variables
        NM = row.TaskName
        SM = row.Status
        TM = row.MSorID
        if (Typecheck(row.Startdate))
            SD = row.Startdate
            Current = row.Startdate::Date
            FollowFlag = false
        else
            SD = add_work(Current,1)
            Current = SD::Date
            FollowFlag = true
        end

        if (FollowFlag)
            CM = count_days(Current, add_work(Current,row.days))
            Current = add_work(Current,row.days)::Date
            CM = "$(CM)d"
        else
            CM = row.days
            CM = "$(CM)d"
        end
        # Print the stored values together
        println("\t$NM\t: $SM, $TM, $SD,$CM")
    end
end

PreMark = """```mermaid
%%{init: {'theme': 'nuetral' } }%%
gantt
    dateFormat YYWW
    axisFormat %yW%W
    title Test Preparation\n
    section General Preparation\n"""#Set title here

EndMark = """\n```"""

println(PreMark)

df = DataFrame(XLSX.readtable("data.xlsx", "Sheet3"))

print_dataframe(df)

println(EndMark)
