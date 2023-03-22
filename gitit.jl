#git config --global user.name "JaewooJoung"
#git config --global user.email "jaewoo.joung@outlook.com"
#git config --list # 계정확인
#cd d: #로컬 위치
#git clone https://github.com/JaewooJoung/julia#git pull origin main
using Dates 
my_message = "Auto push" 
repo_path = "D:\\julia"
cd(repo_path)
run(`git add .`)
dt=now()
commit_message = Dates.format(dt, "yyyymmddHHMMSS ") * my_message
run(`git commit -m $commit_message`)
run(`git push --all`)