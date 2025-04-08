# deep-reconnaissance-

import os 
import subprocess
domain = input("Enter target domain(example.com):")
print("[*]Running subfinder...")
subprocess.run(f"subfinder -d {domain} -o subs.txt",shell=true)
print("[*]Running httpx...")
subprocess.run("httpx -l subs.txt -silent -o live.txt",shell=true)
print("[*]Running ffuf on live domains..")
subprocess.run("ffuf",shell=true)

