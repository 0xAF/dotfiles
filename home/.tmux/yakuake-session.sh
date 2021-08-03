#!/bin/bash

# create new profile in yakuake and set this script as a login shell


# this script will:
# start a root shell... and give it some time before starting multitail
# so the screen is initialized and multitail will see the real screen size
# then after a second, start multitail
# only after that, split screen and start htop
# set the unattached options after we are attached, otherwise the session will be killed before we are attached

sess="yakuake"

#tmux start-server

tmux new-session -d -s $sess 'HISTFILE= su;exit'
tmux set -t $sess status off
#tmux set -t $sess mouse on

sleep 1
tmux send-keys -t $sess "HISTFILE= stdbuf -i0 -o0 -e0 tail -F -n 1500 /var/log/messages.log | stdbuf -i0 -o0 -e0 grep -vE '(qml: temp unit: 0|org.kde.pim.akonadiserver: ItemRetrievalJob for request|kernel: audit:|kernel: mce:|kded5\[|plasmashell\[|systemsettings5\[|kwin_x11\[|kio_http_cache_cleaner\[|akonadiserver\[|kdeinit5\[|akonadi_imap_resource\[|kontact\[|akonadi_maildispatcher_agent\[|org_kde_powerdevil\[|krunner\[|akonadi_indexing_agent\[|gcr-prompter\[|plasma_session\[|rtkit-daemon\[|psi-plus\[|akonadi_followupreminder_agent\[|kgpg\[|akonadi_notes_agent\[|akonadi_sendlater_agent\[|kwalletmanager5\[|kiod5\[|at-spi-bus-launcher\[|akonadi_control\[|gpg-agent\[|gnome-keyring-daemon\[)' | stdbuf -i0 -o0 -e0 grcat conf.log; exit" Enter
#tmux send-keys -t $sess "HISTFILE= grc --colour=on -c conf.log tail -F -n 150 /var/log/messages; exit" Enter
#tmux send-keys -t $sess "HISTFILE= journalctl -xef | grep -v 'qml: temp unit: 0' | grep -v 'org.kde.pim.akonadiserver: ItemRetrievalJob for request' | grcat conf.log; exit" Enter
#tmux send-keys -t $sess "HISTFILE= TERM=xterm-256color journalctl -f;exit" Enter
#tmux send-keys -t $sess "HISTFILE= TERM=xterm-256color multitail -D /var/log/messages;exit" Enter
#tmux send-keys -t $sess "HISTFILE= TERM=xterm-256color lnav /var/log/messages;exit" Enter
sleep 1
tmux send-keys -t $sess Enter
tmux split-window -t $sess:1 -d -p 50 htop
tmux attach -t $sess \; set -t $sess exit-unattached on \; set -t $sess destroy-unattached on






# old stuff

#/usr/bin/tmux new-session -d -s yakuake \; set -g status off \; set -g mouse on \; send-keys 'su -c "multitail -D /var/log/messages";exit' Enter \; send-keys Enter \; split-window -d -p 55 htop \; attach


echo
echo
echo "finished... press enter to restart."
read

