#make week
using Dates

function generate_markdown_table(year::Int)
    start_date = Dates.Date(year, 1, 2)
    end_date = Dates.Date(year, 12, 31)
    current_date = start_date
    week_number = 1
    table = "| Week   | Start Date       | End Date         |\n|--------|------------------|------------------|\n"

    while current_date <= end_date
        start_date_str = Dates.format(current_date, "MMMM d, yyyy")
        current_date += Dates.Day(6)
        end_date_str = Dates.format(current_date, "MMMM d, yyyy")
        table = table * "| Week $week_number | $start_date_str | $end_date_str |\n"
        current_date += Dates.Day(1)
        week_number += 1
    end

    return table
end

# Example usage
year = 2023
table = generate_markdown_table(year)
println(table)
