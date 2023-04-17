#c:\tools\git\bin\git.exe config --global user.name "JaewooJoung"
#c:\tools\git\bin\git.exe config --global user.email "jaewoo.joung@outlook.com"
#c:\tools\git\bin\git.exe config --list # authetification
#cd C:\Users\jaewoo.joung\ #local drive 
#git clone https://github.com/JaewooJoung/julia#git pull origin main
using Dates 
my_message = "dude check the 14th line here " 
repo_path = "C:\\Users\\jaewoo.joung\\julia"
cd(repo_path)

run(`c:\\tools\\git\\bin\\git.exe add .`)
dt=now()
commit_message = Dates.format(dt, "yyyymmddHHMMSS ") * my_message
run(`c:\\tools\\git\\bin\\git.exe commit -m $commit_message`)
run(`c:\\tools\\git\\bin\\git.exe pull --rebase`)
run(`c:\\tools\\git\\bin\\git.exe push --all`) #this is my fix today
#new comment againa