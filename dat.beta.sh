#!/usr/bin/env bash
#---------------
warning="[- \033[31mWARNING\033[0m -]"
info="[- \033[1;33minfo\033[0m -]"
failure="[- \033[31mFAILED\033[0m -]"
success="[- \033[1;32mSUCCESS\033[0m -]"
downloading="\033[32m[\033[0m Downloading    \033[32m]\033[0m\r"&&
extracting="\033[32m[\033[0m Extracting     \033[32m]\033[0m\r"
mv_bin='\033[32m[\033[0m moving to /bin  \033[32m]\033[0m\r'
apt="\033[32m[\033[0m Installing using APT \033[32m]\033[0m\r"
don="\033[32m[\033[0m Done! \033[32m]\033[0m\r"
mak="\033[32m[\033[0m Building \033[32m]\033[0m\r"
ark=$(arch)
os=$(awk -F= '$1=="NAME" { print $2 ;}' /etc/os-release | sed 's/"//' | sed 's/"//')
#---------------
function banner(){
    echo -e """
\033[31m
▀█ █▀▀ █▀█ █▀█ ▄▄ █ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░
█▄ ██▄ █▀▄ █▄█ ░░ █ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄
\033[0m
    """
}
function installer(){
    pkg=$1
    proc=$2
    if command -v $pkg >/dev/null 2>&1; then
        echo -e "$info  \033[31m*\033[0m[ $pkg is Already Installed ]\033[31m*\033[0m"
    else
        echo -ne "$warning  \033[31m*\033[0m[ $pkg is Not Installed (Installing..) ]\033[31m*\033[0m\n"
        $proc
        echo -ne "$success  \033[31m*\033[0m[ $pkg is Installed Successfully ]\033[31m*\033[0m\n"
    fi

}
function tool_config(){
    echo -ne "[- \033[1;32mCommon Software Properties\033[0m -]\r"
    sudo apt install software-properties-common -y -qq &>/dev/null
    echo -ne "[- \033[1;32mAdding Latest Golang repo\033[0m -]\r"
    sudo add-apt-repository ppa:longsleep/golang-backports -y &>/dev/null
    echo -ne "[- \033[1;32mUpdating System\033[0m -]\r"
    sudo apt update -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling git\033[0m -]\r"
    sudo apt install git -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling 7zip\033[0m -]\r"
    sudo apt install --assume-yes p7zip-full &>/dev/null
    echo -ne "[- \033[1;32mInstalling curl\033[0m -]\r"
    sudo apt install curl -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling wget\033[0m -]\r"
    sudo apt install wget -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling python3\033[0m -]\r"
    sudo apt install python3 -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling pip3\033[0m -]\r"
    sudo apt install python3-pip -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling dig\033[0m -]\r"
    sudo apt install dig -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling host \033[0m -]\r"
    sudo apt install host -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling make\033[0m -]\r"
    sudo apt install make -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling git\033[0m -]\r"
    sudo apt install git -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling gcc -]\r"
    sudo apt install gcc -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling jq\033[0m -]\r"
    sudo apt install jq -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling libdns\033[0m -]\r"
    sudo apt-get install libldns-dev -y -qq &>/dev/null
    echo -ne "[- \033[1;32mInstalling NPM-NODEJS\033[0m -]\r"
    sudo apt-get install npm -y -qq &>/dev/null
    sudo apt-get install nodejs -y -qq &>/dev/null
}
function git_installation(){
    mkdir .tm;cd .tm
    mkdir .0install
    echo -ne $downloading
    wget -P .0install/ $(curl -sL https://api.github.com/repos/$1/releases/latest | jq -r '.assets[].browser_download_url' | grep "$2") &>/dev/null
    echo -ne $extracting
    ls .0install | grep "zip" && unzip .0install/*.zip &>/dev/null || tar -xvf ".0install/"$(ls .0install/ | grep "tar") &>/dev/null
    echo -ne $mv_bin
    sudo chmod +x $3
    sudo mv $3 /bin
    rm -rf *
    cd ../
    rm -rf .tm

}
function go_get(){
    echo -ne $downloading
    go get -u $1 &>/dev/null
    echo -ne $mv_bin
    sudo chmod +x $HOME/go/bin/*
    sudo mv $HOME/go/bin/* /bin
    echo -ne $don
}
go_get_install(){
    echo -ne $downloading
    go install $1 &>/dev/null
    echo -ne $mv_bin
    sudo chmod +x $HOME/go/bin/*
    sudo mv $HOME/go/bin/* /bin
}


function go_latest(){
    echo -ne $apt
    sudo apt install golang-go -y -qq &>/dev/null
    echo -ne $don
}

function dnsx_latest(){
  if [ $ark == "x86_64" ]
  then
  git_installation "projectdiscovery/dnsx" "linux_amd64" "dnsx"
  else
  git_installation "projectdiscovery/dnsx" "linux_386" "dnsx"
  fi
}
function assetsfinder_latest(){
   echo -ne $downloading
  go_get github.com/tomnomnom/assetfinder
}
function sublis3r_latest(){
    sudo pip3 install git+https://github.com/aboul3la/Sublist3r &>/dev/null
}
function amass_latest_linux(){
    if [ $ark == "x86_64" ]
    then 
    git_installation "OWASP/Amass" "linux_amd64" "amass_linux_amd64/amass"
    else
    git_installation "OWASP/Amass" "linux_386" "amass_linux_amd64/amass"
    fi
}
function amass_latest_kali(){
    echo -ne $apt
    sudo apt install amass -y -qq &>/dev/null
    echo -ne $don
}
function massdns_latest_linux(){
    mkdir .tmp;cd .tmp
    echo -ne $downloading
    git clone https://github.com/blechschmidt/massdns.git &>/dev/null
    cd massdns
    echo -ne $mak
    make &>/dev/null
    echo -ne $mv_bin
    chmod +x bin/massdns
    sudo mv bin/massdns /bin
    cd ../..
    rm -rf .tmp
}
function massdns_latest_kali(){
    echo -ne $apt
    sudo apt install massdns -y -qq &>/dev/null
    echo -ne $don
}
function puredns_latest(){
    go_get github.com/d3mondev/puredns/v2

}
function subfinder_latest_linux(){
    if [ $ark == "x86_64" ]
    then 
    git_installation "projectdiscovery/subfinder" "linux_amd64" "subfinder"
    else
    git_installation "projectdiscovery/subfinder" "linux_386" "subfinder"
    fi
}
function subfinder_latest_kali(){
    echo -ne $apt
    sudo apt install subfinder -y -qq &>/dev/null
    echo -ne $don
}
function knockpy_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/guelfoweb/knock &>/dev/null
    echo -ne $don
}
function masscan_latest_linux(){
    mkdir .tmp;cd .tmp
    echo -ne $downloading
    git clone https://github.com/robertdavidgraham/masscan &>/dev/null
    cd masscan
    echo -ne $mak
    make &>/dev/null
    echo -ne $mv_bin
    make install &>/dev/null
    cd ../..
    rm -rf .tmp
}
function masscan_latest_kali(){
    echo -ne $apt
    sudo apt install masscan -y -qq &>/dev/null
    echo -ne $don
}
function rustscan_latest(){
    if [ $ark == "x86_64" ]
    then 
    echo -ne $downloading
    wget -P .0install/ $(curl -sL https://api.github.com/repos/RustScan/RustScan/releases/latest | jq -r '.assets[].browser_download_url' | grep "amd64") &>/dev/null
    sudo dpkg -i .0install/*.deb
    sudo apt install -f
    rm -rf .0install
    echo -ne $don
    else
    echo -ne $downloading
    wget -P .0install/ $(curl -sL https://api.github.com/repos/RustScan/RustScan/releases/latest | jq -r '.assets[].browser_download_url' | grep "i386") &>/dev/null
    sudo dpkg -i .0install/*.deb
    sudo apt install -f
    rm -rf .0install
    echo -ne $don
    fi
}
function nmap_latest(){
    echo -ne $apt
    sudo apt install nmap -y -qq &>/dev/null
    echo -ne $don
}
function aquatone_latest(){
    if [ $ark == "x86_64" ]
    then 
    git_installation "michenriksen/aquatone" "linux_amd64" "aquatone"
    else
    echo -e "$failure [No Release Found (Not installed)]"
    fi
}
function subjack_latest(){
    go_get github.com/haccer/subjack 
}
function gowitness_latest(){
    if [ $ark == "x86_64" ]
    then
    echo -ne $downloading
    wget $(curl -sL https://api.github.com/repos/sensepost/gowitness/releases/latest | jq -r '.assets[].browser_download_url' | grep "linux-amd64") &>/dev/null
    echo -ne $mv_bin
    chmod +x gowitness-*-linux-amd64
    sudo mv gowitness-*-linux-amd64 /bin/gowitness
    echo -ne $don
    else
    echo -e "$failure [No Release Found (Not installed)]"
    fi
}
function wappalyzer_latest(){
    echo -ne $downloading
    sudo npm i -g wappalyzer &>/dev/null
    echo -ne $don
}
function whatweb_latest(){
    echo -ne $apt
    sudo apt-get install -y whatweb &>/dev/null
    echo -ne $don
}
function wad_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/CERN-CERT/WAD &>/dev/null
    echo -ne $don
}
function gobuster_latest_kali(){
    echo -ne $apt
    sudo apt install gobuster -y -qq &>/dev/null
    echo -ne $don
}
function gobuster_latest_linux(){
    if [ $ark == "x86_64" ]
    then
    echo -ne $downloading
    wget $(curl -sL https://api.github.com/repos/OJ/gobuster/releases/latest | jq -r '.assets[].browser_download_url' | grep "linux-amd64") &>/dev/null
    echo -ne $extracting
    7z e *.7z &>/dev/null
    echo -ne $mv_bin
    chmod +x gobuster
    sudo mv gobuster /bin
    rm -rf *.7z
    rm -rf gobuster-linux-amd64
    echo -ne $don
    else
    echo -ne $downloading
    wget $(curl -sL https://api.github.com/repos/OJ/gobuster/releases/latest | jq -r '.assets[].browser_download_url' | grep "linux-386") &>/dev/null
    echo -ne $extracting
    7z e *.7z
    echo -ne $mv_bin
    chmod +x gobuster
    sudo mv gobuster /bin
    rm -rf *.7z &>/dev/null
    rm -rf gobuster-linux-amd64
    echo -ne $don
    fi
    
}
function dirsearch_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/maurosoria/dirsearch &>/dev/null
    echo -ne $don
}
function recursebuster_latest(){
    go_get github.com/c-sto/recursebuster


}
function gospider_latest(){
    go_get -u github.com/jaeles-project/gospider

}
function hakrawler_latest(){
    echo -ne $downloading
    go install github.com/hakluke/hakrawler@latest &>/dev/null
    echo -ne $mv_bin
    sudo chmod +x $HOME/go/bin/*
    sudo mv $HOME/go/bin/* /bin
    echo -ne $don
}
function getjs_latest(){
    go_get github.com/003random/getJS
}
function gau_latest(){
    if [ $ark == "x86_64" ]
    then 
    git_installation "lc/gau" "linux_amd64" "gau"
    else
    git_installation "lc/gau" "linux_386" "gau"
    fi
}
function waybackurls_latest(){
    go_get github.com/tomnomnom/waybackurls
}
function urlgrab_latest(){
    echo -ne $downloading
    git clone https://github.com/IAmStoxe/urlgrab &>/dev/null
    cd urlgrab
    echo -ne $mak
    go build
    echo -ne $mv_bin
    sudo mv urlgrab /bin 
    cd ..
    rm -rf urlgrab
    echo -ne $don
}
function arjun_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/s0md3v/Arjun &>/dev/null 
    echo -ne $don
}
function wfuzz_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/xmendez/wfuzz &>/dev/null
    echo -ne $don

}
function ffuf_latest(){
    go_get github.com/ffuf/ffuf
}
function qsfuzz_latest(){
    go_get github.com/ameenmaali/qsfuzz
}
function corsy_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/s0md3v/Corsy /opt/corsy &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/corsy/corsy.py $@' >> corsy
    chmod +x corsy
    sudo mv corsy /bin
    echo -ne $don

}
function crlfuzz_latest(){
    curl -sSfL https://git.io/crlfuzz | sudo sh -s -- -b /usr/local/bin &>/dev/null
}
function crlf_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/MichaelStott/CRLF-Injection-Scanner &>/dev/null
    echo -ne $don
}
function xsrfprobe_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/0xInfection/XSRFProbe &>/dev/null
    echo -ne $don    
}
function fdsploit_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/chrispetrou/FDsploit /opt/fdsploit &>/dev/null
    sudo pip3 install -r /opt/fdsploit/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/fdsploit/fdsploit.py $@' >> fdsploit
    chmod +x fdsploit
    sudo mv fdsploit /bin
    echo -ne $don
}
function liffy_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/mzfr/liffy /opt/liffy &>/dev/null
    sudo pip3 install -r /opt/liffy/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/liffy/liffy.py $@' >> liffy
    chmod +x liffy
    sudo mv liffy /bin
    echo -ne $don
}
function inql_latest(){
    echo -ne $downloading
    sudo pip3 install git+https://github.com/doyensec/inql &>/dev/null
    echo -ne $don
}
function graphqlmap_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/swisskyrepo/GraphQLmap /opt/graphqlmap &>/dev/null
    sudo pip3 install -r /opt/graphqlmap/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/graphqlmap/graphqlmap.py $@' >> graphqlmap
    chmod +x graphqlmap
    sudo mv graphqlmap /bin
    echo -ne $don
}
function headi_latest(){
    echo -ne $downloading
    go_get github.com/mlcsec/headi
    echo -ne $don
}
function Oralyzer_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/r0075h3ll/Oralyzer /opt/oralyzer &>/dev/null
    sudo pip3 install -r /opt/oralyzer/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/oralyzer/oralyzer.py $@' >> oralyzer
    chmod +x oralyzer
    sudo mv oralyzer /bin
    echo -ne $don
}
function smuggle_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/anshumanpattnaik/http-request-smuggling /opt/smuggle &>/dev/null
    sudo pip3 install -r /opt/smuggle/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/smuggle/smuggle.py $@' >> smuggle
    chmod +x smuggle
    sudo mv smuggle /bin
    echo -ne $don
}
function smuggler_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/defparam/smuggler /opt/smuggler &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/smuggler/smuggler.py $@' >> smuggler
    chmod +x smuggler
    sudo mv smuggler /bin
    echo -ne $don
}
function h2csmuggler_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/BishopFox/h2csmuggler /opt/h2csmuggler &>/dev/null
    pip3 install h2 &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/h2csmuggler/h2csmuggler.py $@' >> h2csmuggler
    chmod +x h2csmuggler
    sudo mv h2csmuggler /bin
    echo -ne $don
    
}
function ssrfmap_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/swisskyrepo/SSRFmap /opt/ssrfmap &>/dev/null
    sudo pip3 install -r /opt/ssrfmap/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/ssrfmap/ssrfmap.py $@' >> ssrfmap
    chmod +x ssrfmap
    sudo mv ssrfmap /bin
    echo -ne $don
}
function gopherus_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/tarunkant/Gopherus /opt/gopherus &>/dev/null
    echo -ne $mv_bin
    echo 'python2 /opt/gopherus/gopherus.py $@' >> gopherus
    chmod +x gopherus
    sudo mv gopherus /bin
    echo -ne $don
}
function sqlmap_latest(){
    sudo pip3 install sqlmap &>/dev/null
}
function anew_latest(){
    go_get github.com/tomnomnom/anew
}
function githubsubdomains_latest(){
    go_get github.com/gwen001/github-subdomains
}
function secretFinder_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/m4ll0k/SecretFinder /opt/secretFinder &>/dev/null
    sudo pip3 install -r /opt/secretFinder/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/secretFinder/SecretFinder.py $@' >> secretfinder
    chmod +x secretfinder
    sudo mv secretfinder /bin
    echo -ne $don

}
function xsstrike_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/s0md3v/XSStrike /opt/xsstrike &>/dev/null
    sudo pip3 install -r /opt/xsstrike/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/xsstrike/xsstrike.py $@' >> xsstrike
    chmod +x xsstrike
    sudo mv xsstrike /bin
    echo -ne $don
}
function httpx_latest(){
    if [ $ark == "x86_64" ]
    then 
    git_installation "projectdiscovery/httpx" "linux_amd64" "httpx"
    else
    git_installation "projectdiscovery/httpx" "linux_386" "httpx"
    fi
}
function httprobe_latest(){
    go_get github.com/tomnomnom/httprobe
}
function dalfox_latest(){
    if [ $ark == "x86_64" ]
    then 
    git_installation "hahwul/dalfox" "linux_amd64" "dalfox"
    else
    git_installation "hahwul/dalfox" "linux_386" "dalfox"
    fi

}
function xss2png_latest(){
    echo -ne $downloading
    sudo git clone https://github.com/vavkamil/xss2png /opt/xss2png &>/dev/null
    sudo pip3 install -r /opt/xss2png/requirements.txt &>/dev/null
    echo -ne $mv_bin
    echo 'python3 /opt/xss2png/xss2png.py $@' >> xss2png
    chmod +x xss2png
    sudo mv xss2png /bin
    echo -ne $don
}
tool_config
installer go go_latest
installer dnsx dnsx_latest
installer assetfinder assetsfinder_latest
installer sublist3r sublis3r_latest
installer amass amass_latest_linux 
installer massdns massdns_latest_linux
installer puredns puredns_latest
installer subfinder subfinder_latest_linux
installer knockpy knockpy_latest
installer masscan masscan_latest_linux
installer rustscan rustscan_latest
installer nmap nmap_latest
installer aquatone aquatone_latest
installer subjack subjack_latest
installer gowitness gowitness_latest
installer wappalyzer wappalyzer_latest
installer whatweb whatweb_latest
installer wad wad_latest
installer gobuster gobuster_latest_linux
installer dirsearch dirsearch_latest
installer recursebuster recursebuster_latest
installer gospider gospider_latest
installer hakrawler hakrawler_latest
installer getJS getjs_latest
installer gau gau_latest
installer waybackurls waybackurls_latest
installer urlgrab urlgrab_latest
installer arjun arjun_latest
installer wfuzz wfuzz_latest
installer ffuf ffuf_latest
installer qsfuzz qsfuzz_latest
installer corsy corsy_latest
installer crlfuzz crlfuzz_latest
installer crlf crlf_latest
installer xsrfprobe xsrfprobe_latest
installer fdsploit fdsploit_latest
installer liffy liffy_latest
installer inql inql_latest
installer graphqlmap graphqlmap_latest
installer headi headi_latest
installer oralyzer Oralyzer_latest
installer smuggle smuggle_latest
installer smuggler smuggler_latest
installer h2csmuggler h2csmuggler_latest
installer ssrfmap ssrfmap_latest
installer gopherus gopherus_latest
installer sqlmap sqlmap_latest
installer anew anew_latest
installer github-subdomains githubsubdomains_latest
installer secretfinder secretFinder_latest
installer xsstrike xsstrike_latest
installer httpx httpx_latest
installer httprobe httprobe_latest
installer dalfox dalfox_latest
installer xss2png xss2png_latest
