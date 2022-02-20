#pip3 install blastradius && sudo apt install -y graphviz
graph:
	terraform init
	terraform graph | /home/lukas/.local/bin/blast-radius --svg > graph.svg