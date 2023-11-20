remove:
	rm -rf ~/.soarchain

reset:
	soarchaind tendermint unsafe-reset-all

install-lib:
	@if [ -f $(CURDIR)/libwasmvm.x86_64.so ]; then \
		sudo cp $(CURDIR)/libwasmvm.x86_64.so /usr/lib/; \
		echo "Dependencies copied successfully."; \
	else \
		echo "libwasmvm.x86_64.so not found in the current directory."; \
	fi

NODE_NAME ?= default_name
init:
	soarchaind init "$(NODE_NAME)" --chain-id soarchaintestnet

update-config:
	sed -i '0,/^\(laddr = \).*/s||\1"tcp://0.0.0.0:26657"|' ~/.soarchain/config/config.toml
	sed -i 's|^\(persistent_peers = \).*|\1"paste-node-id-here@paste-instance-ip-here:26656"|' ~/.soarchain/config/config.toml
	sed -i 's|^\(timeout_commit = \).*|\1"15s"|' ~/.soarchain/config/config.toml
	soarchaind config keyring-backend os
	soarchaind config chain-id soarchaintestnet
	sudo cp $(CURDIR)/genesis.json ~/.soarchain/config/genesis.json


ifdef start
	soarchaind start --log_level info --minimum-gas-prices=0.0001udmotus
endif

all: reset init config keys parameter_token_denomination allocate_genesis_accounts sign_genesis_transaction collect_genesis_tx validate_genesis
