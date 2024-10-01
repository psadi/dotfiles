#!/usr/bin/env zsh

echo "Bootstrapping your system..."
export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')

echo "OSTYPE: $OSTYPE"

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing Homebrew"
    if (( !$+commands[brew] )); then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        eval "$(/usr/local/bin/brew shellenv)"
    else
        echo "Homebrew is already installed"
    fi

elif [[ "$OSTYPE" == "linux"* ]]; then
    echo "Installing Linux dependencies"
    LANG=en_US.UTF-8
    sudo apt-get update -y && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    sudo python3-minimal python3-pip python3-venv locales git

    echo "Updating Locale"
    sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen
    dpkg-reconfigure --frontend=noninteractive locales
    update-locale LANG="${LANG}"
else
    echo "Unsupported OS"
    exit 1
fi

echo "Installing Python3 Dependencies"
pip3 install ansible pip --upgrade --break-system-packages --no-cache-dir --no-warn-script-location

if [ ! -d "${HOME}/.dotfiles" ]; then
    echo "Cloning psadi/.dotfiles"
    git clone https://github.com/psadi/dotfiles.git "${HOME}/.dotfiles"
else
    echo "psadi/.dotfiles already exists"
fi

# Ask input password and save it to a file
VAULT_PASS_FILE="${HOME}/.dotfiles/ansible/.vault_pass"

if [ ! -f "${VAULT_PASS_FILE}" ]; then
    echo "Creating '${VAULT_PASS_FILE}' as Ansible Vault password file"
    touch "${VAULT_PASS_FILE}"
    chmod 600 "${VAULT_PASS_FILE}"
fi

echo "Enter your password for Ansible Vault"
read -s -p "Password: " LINUX_USER_PASSWORD
echo $LINUX_USER_PASSWORD > "${VAULT_PASS_FILE}"

export ANSIBLE_CONFIG="${HOME}/.dotfiles/ansible/ansible.cfg"
export ANSIBLE_INVENTORY_WARNING=false
export ANSIBLE_VAULT_PASSWORD_FILE="${VAULT_PASS_FILE}"

echo "Running Ansible Playbook"
ansible-playbook "${HOME}/.dotfiles/ansible/site.yaml" --tags "${OSTYPE}"