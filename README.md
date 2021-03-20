<h1 align="center">
  <br>
  <a href="https://github.com/JoyGhoshs/0install"><img src="https://i.ibb.co/sb1chvb/Screenshot-from-2021-03-18-02-41-09.png" alt="0installer"></a>
  <br>
    Zero-Install
  <br>
</h1>

<h4 align="center">Automated Recon Tool Installer</h4>
    <p align="center">
  <a href="https://github.com/joyghoshs/0install">
    <img src="https://img.shields.io/static/v1?label=Project&message=ZeroInstall&color=green">
  </a>
  <a href="https://twitter.com/0xjoyghosh">
      <img src="https://img.shields.io/twitter/follow/0xjoyghosh?style=social">
  </a>
</p>
<h1 align="center">
  <br>
  <a href="https://github.com/JoyGhoshs/0install"><img src="https://i.ibb.co/R7GyxxD/Screenshot-from-2021-03-18-03-07-47.png" alt="0installer"></a>
  <br>
  <br>
</h1>

### Why 0install ??

- Its Fast
- It Can detect os architecture and download package compitable with it
- It detects if package is installed or not if installed it skips
- It usage github api to track the package update so it doesnt download outdated package
- It Download all the package from real source
- It doesnt use apt to install tools so tools can be downloaded and installed in any distro

### Tools it can install
- [x] dnsx
- [x] subfinder
- [x] nuclei
- [x] assetfinder
- [x] wayback
- [x] meg
- [x] gf
- [x] gron
- [x] amass
- [x] webscreenshot
- [x] waybackunifier
- [x] shodan
- [x] censys
- [x] goaltdns
- [x] subjack
- [x] ffuf
- [x] hakrawler
- [x] knockpy
- [x] kxss
- [x] dalfox
- [x] otxurls [NEW] 
- [x] subjs [NEW] 
- [x] Gau [NEW]
- [x] Dirsearch [NEW]  
- [x] corsy [NEW]  

### Usage without cloning this repo
```
curl -s https://raw.githubusercontent.com/JoyGhoshs/0install/main/0install | bash
```
### CREATE OWN 0install Module
```bash
# Module Template

function install_yourpackagename(){
  if command -v your_package_name &>/dev/null;
  then
  echo -e "$pl2 your_package_name $k1"
  else
  echo -e "$pl1 your_package_name $k2"
    package_installation_process #author_name:your_name
fi
}

#Shortcut
# apt package_name  --- to use apt to download and package
# mv_bin ----- to move your package compiled binary to /bin
# go_get github.com/user/repo ----- short form of go get -u 
# get_latest github_user/repo ----- get package from any github repo relase page
# wget --- short form of wget -q

```
After creating module just create a issue and submit your module there we will add it soon

