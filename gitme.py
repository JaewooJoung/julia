import subprocess
from datetime import datetime

my_message = "Today I changed to python"
repo_path = r"C:\Users\jaewoo.joung\julia"
subprocess.run(["cd", repo_path], shell=True)

subprocess.run(["c:\\tools\\git\\bin\\git.exe", "add", "."])

dt = datetime.now()
commit_message = dt.strftime("%Y%m%d%H%M%S ") + my_message

subprocess.run(["c:\\tools\\git\\bin\\git.exe", "commit", "-m", commit_message])

subprocess.run(["c:\\tools\\git\\bin\\git.exe", "pull", "--rebase"])

subprocess.run(["c:\\tools\\git\\bin\\git.exe", "push", "--all"])