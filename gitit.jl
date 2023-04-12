#c:\tools\git\bin\git.exe config --global user.name "JaewooJoung"
#c:\tools\git\bin\git.exe config --global user.email "jaewoo.joung@outlook.com"
#c:\tools\git\bin\git.exe config --list # 계정확인
#cd C:\Users\jaewoo.joung\ #로컬 위치
#git clone https://github.com/JaewooJoung/julia#git pull origin main
using Dates 
my_message = "Auto push" 
repo_path = "C:\\Users\\jaewoo.joung\\julia"
cd(repo_path)
run(`c:\\tools\\git\\bin\\git.exe add .`)
dt=now()
commit_message = Dates.format(dt, "yyyymmddHHMMSS ") * my_message
run(`c:\\tools\\git\\bin\\git.exe commit -m $commit_message`)
run(`c:\\tools\\git\\bin\\git.exe push --all`)
#new comment