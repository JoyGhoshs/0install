

echo -e '''
  ___  _          __       ____
 / _ \(_)__  ___ / /____ _/ / /
/ // / / _ \(_-</ __/ _ `/ / / 
\___/_/_//_/___/\__/\_,_/_/_/  
                  by @0xjoyghosh [Community Edition]
                               
'''

package_installer(){
  declare -A osInfo;
osInfo[/etc/redhat-release]='sudo yum install'
osInfo[/etc/arch-release]='sudo pacman -s'
osInfo[/etc/debian_version]='sudo apt-get install -qq -y'
osInfo[/etc/alpine-release]='apk add'

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        exec ${osInfo[$f]} $1
    fi
done

}
one_time_requirement(){
    touch $HOME/.0install.sh.requirements
    echo -e "\033[1;32m[ INSTALLING REQUIREMENTS ]\033[0m "
    echo -e "\033[1;32m[ INSTALLING curl,GIT,Jq,dig,golang,7zip,wget,pip3,gcc ]\033[0m "
    package_installer software-properties-common python3-pip libldns-dev curl git jq golang 7zip wget gcc
    echo "export GOPATH=$HOME/go" >> $HOME/.bashrc &> /dev/null
    echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> $HOME/.bashrc &> /dev/null
    echo "export GOPATH=$HOME/go" >> $HOME/.zshrc &> /dev/null
    echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> $HOME/.zshrc &> /dev/null
}

bin_from_git(){
  if (( $(arch) == "x86_64" )); then
    mkdir -p /tmp/0install &> /dev/null
    wget -P /tmp/0install $(curl -sL https://api.github.com/repos/$1/releases/latest | jq -r '.assets[].browser_download_url' | grep "linux_amd64") &> /dev/null
    7z x $(ls /tmp/0install/*.zip) -o/tmp/0install/ &> /dev/null
    sudo mv $(find /tmp/0install/ -executable -type f) /usr/bin &> /dev/null
    rm -rf /tmp/0install/* &> /dev/null
    
  else
    mkdir -p /tmp/0install &> /dev/null
    wget -P /tmp/0install $(curl -sL https://api.github.com/repos/$1/releases/latest | jq -r '.assets[].browser_download_url' | grep "linux_386") &> /dev/null
    7z x $(ls /tmp/0install/*.zip) -o/tmp/0install/ &> /dev/null
    sudo mv $(find /tmp/0install/ -executable -type f) /usr/bin &> /dev/null
    rm -rf /tmp/0install/* &> /dev/null
  fi
}

package_installer(){
   for package in ${packages[@]}
    do
        if command -v $package >/dev/null 2>&1; then
            echo -e "\033[1;32m[ $package is already installed ]\033[0m "
        else
            package=$(echo $package | tr -d '-')
            echo -e "\033[1;32m[ Installing $package ]\033[0m "
            eval $(curl -s https://raw.githubusercontent.com/JoyGhoshs/0install/main/tools.json | jq -r ".$package" | tr -d '"')
            sudo mv $HOME/go/bin/* /bin &>/dev/null
        fi
    done
}

# Define the tools name to install 
packages=(sublist3r knockpy subscraper anubis shodan uro dnsrecon arjun nuclei httpx dnsx subfinder naabu notify waybackurls unfurl httprobe anew meg qsreplace assetfinder subjack gauplus puredns gospider gowitness amass massdns padbuster dirsearch findomain aquatone ffuf linkfinder masscan dnsgen unew crlfuzz go-dork)
one_time_requirement
package_installer

