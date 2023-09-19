Download Termux from: https://f-droid.org/en/packages/com.termux/
in a terminal:

	termux-setup-storage #make a shared folder 
 
	pkg update && pkg upgrade -y
 	pkg install python build-essential curl git screen openssh -y

 	pkg install libarrow-cpp -y    # Fix for pyarrow
	export MATHLIB="m"          # Fix for numpy
	export LDFLAGS="-lpython3.11"    # Fix for pyarrow missing symbols
 	rm -rf /var/lib/apt/lists/*
 	streamlit hello                  # Run streamlit

    
    apt update
    apt upgrade
    apt install git screen openssh python
    
    passwd #set a password
    ifconfig #get ip
    whoami #gt username
    sshd #start ssh server


in windows cmd:

    ssh username@ip -p 8022
    ssh v0_417@10.174.21.163 -p 8022
    
	screen #start a new screen
	CTRL+a d #send to the back
	screen -d #get the screen from the background

MIR LENOVO - 2023.08.08

	pass: 1234
 	ssh u0_a92@10.0.40.19 -p 8022

	pip install virtualenv
	virtualenv venv -p python
	source venv/bin/activate

Python another version
	pkg install tur-repo
	pkg update
	pkg install python3.9
