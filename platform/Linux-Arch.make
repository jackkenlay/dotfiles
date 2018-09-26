update:
	sudo pacman -Syu
	pacaur -Syu

clean:
	sudo pacman -Rns $(pacman -Qtdq)

battery-max:
	sudo tlp fullcharge

battery-normal:
	sudo tlp chargeonce

NETDEVICES := ip link show | grep -v '^   ' | cut -d ':' -f2 | grep -v 'lo'
net-online:
	$(NETDEVICES) | while read d; do sudo ip link set "$$d" up; done

net-offline:
	$(NETDEVICES) | while read d; do sudo ip link set "$$d" down; done

timezone:
	@echo "Updating time: $(shell date +"%r %Z")"
	timedatectl set-timezone "$(shell curl -s https://ipapi.co/timezone/)"
	#curl -s https://timezoneapi.io/api/ip/ | jq -r .data.timezone.id | xargs timedatectl set-timezone
	@echo "New time: $(shell date +"%r %Z")"
