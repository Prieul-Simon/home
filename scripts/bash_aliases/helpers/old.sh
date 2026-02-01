function help.git() {
    echo "Reminder of git useful commands:"
    echo "  > git commit --amend [--no-edit]"
    echo "  > git commit --no-verify"
    echo "  > git remote add <repo-name> ssh://git@repository.com:7999/<repo-name>.git"
    echo "  > git remote update"
    echo "  > git remote -v"
}
function help.systemd() {
    echo "Reminder of systemd usage:"
    echo "  > journalctl --user-unit <my-user-service>"
    echo "  > systemctl --user enable/disable/start/stop/restart/status <my-user-service>"
    echo "  > systemctl --user daemon-reload"
}
function help.net() {
    echo "Reminder of netstat/ssh/netcat/socat useful commands:"
    echo "  Forward local port"
    echo "    > socat tcp-listen:41234,reuseaddr,fork tcp:localhost:8000"
    echo "  List"
    echo "    > netsat -ntulp"
    echo "    > lsof -i"
    echo "  Open a port"
    echo "    > iptables -A INPUT -p tcp --dport 41234 -j ACCEPT"
    echo "    Or simpler with ufw"
    echo "    > sudo ufw status"
    echo "    > sudo ufw allow 41234"
    echo "    > sudo ufw enable"
    echo "  Status of port"
    echo "    > nmap localhost -p 41234"
    echo "    > telnet localhost 41234"
    echo "  To reach local URL fom outside"
    echo "    1/ In computer, forward port to test (here 31504) to a temporary port (here 41234):"
    echo "      > socat tcp-listen:41234,reuseaddr,fork tcp:localhost:31504"
    echo "    2/ Have a static IP for computer"
    echo "    3/ In box configuration, forward internal port 41234 to external port 8080 (TCP/UDP) for computer (which have a static IP)"
    echo "    4/ In box configuration, in firewall custom rules, accept destination port 8080 (UDP/TCP)"
    echo "    5/ Test from another connection (like shared 4G):"
    echo "      > curl http://<box_ip>:8080"
    echo "    6/ Then in my example, enter http://<box_ip>:8080/some_api_endpoint"
}
function help.ip() {
    echo "IP utils"
    echo "    > ifconfig enx28ee520f4df3"
    echo "    > ip addr show enx28ee520f4df3"
    echo "    > ip link show"
}
function help.curl() {
    echo "Reminder of curl usage:"
    echo "  > (I already have an alias \"ccurl\" for \"curl -i -w '\n'\")"
    echo "  > curl -s -D - -o /dev/null  https://example.org"
    echo "  > curl localhost:31599 -i -w '\n' -X POST -d '{"
    echo "    \"key\": \"value\""
    echo "  }'"
    echo "  > curl localhost:31599 -i -w '\n' -X POST -d @.test-req.json"
}
function help.docker() {
    echo "Reminder of docker useful commands:"
    echo "  > docker service ls"
    echo "  > docker service ps prefix_<NAME> --no-trunc"
    echo "  > docker service logs prefix_<NAME>"
    echo "  > docker images [<search_pattern>]"
    echo "  > docker rmi <image_id> # remove image"
    echo "  > docker build -f Dockerfile_volume -t <service>:local . # build image"
    echo "  > docker service create --replicas 1 --name prefix_NAME_simon_qualif NAME_simon_qualif:local"
    echo "  > docker service update --publish-add published=9000,target=80 prefix_NAME_simon_qualif"
}
function help.chown() {
    echo "  > chown username filename.ext"
}
function help.grep() {
    echo "Some tips / useful options of grep:"
    echo "  --exclude-dir"
    echo "  > grep -RHIn --exclude-dir=node_modules \"<my-search-sequence>\" ./folder_to_search"
    echo "  # multiple directories with --exclude-dir={one,two}"
    echo "  # Can also be used with recursive-grep:"
    echo "  > recursive-grep --exclude-dir={dist,node_modules} \"<my-search-sequence>\" "
    echo "  # Find then grep"
    echo "  > find . -type f -iname \"compose-test.yml\" -exec grep \"args\" {} \+"
}
function help.rabbit() {
    echo "Command for RabbitMQ server"
    echo "  > rabbitmqctl list_queues"
    echo "  > rabbitmqctl list_bindings"
}
