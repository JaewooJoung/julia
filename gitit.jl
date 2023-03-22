using Dates 
my_message = "push git push" 
repo_path = "D:\\julia"
cd(repo_path)
run(`git add .`)
dt=now()
commit_message = Dates.format(dt, "yyyymmddHHMMSS ") * my_message
run(`git commit -m $commit_message`)
run(`git push --all`)