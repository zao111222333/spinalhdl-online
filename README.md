# SpinalHDL-Online 
---

Github: <a href="https://github.com/zao111222333/spinalhdl-online" target="_blank">https://github.com/zao111222333/spinalhdl-online</a>

Dockhub: <a href="https://hub.docker.com/r/zao111222333/spinalhdl-online" target="_blank">https://hub.docker.com/r/zao111222333/spinalhdl-online</a>

## Demo
<a href="https://spinalhdl-online.junzhuo.me" target="_blank">https://spinalhdl-online.junzhuo.me</a> with `PASSWORD=123456`.

<img width="1076" alt="SpinalHDL-Online-Demo" src="https://junzhuo.me/images/Blogs/SpinalHDL-Online/SpinalHDL-Online-Demo.png">

Run these two lines in TERMINAL: 
```shell
cd /SpinalHDL/SpinalTemplateSbt/
sbt "runMain mylib.MyTopLevelSim"
```
And the output files (RTL, Waveform) will located at `SpinalTemplateSbt/simWorkspace/MyTopLevel`.

***

## Version Info.

| Pakages | Version  | Repositories |
|  ----  | ----  |  ----  |
| [Debian](https://hub.docker.com/layers/debian/library/debian/10-slim/images/sha256-9f6e6f1f5a4665a552f46028808b28ab19788d28db470de6822febf710f47914?context=explore)  | 10-slim | [mirrors.163.com/debian](http://mirrors.163.com/debian/) |
| [SpinalHDL](https://github.com/SpinalHDL/SpinalHDL) | 1.6.0 |
| [Java](https://www.oracle.com/java/technologies/downloads/#license-lightbox)   | jdk8u311 |
| [Scala](https://www.scala-lang.org/download/2.11.12.html) | 2.11.12 |
| [Sbt](https://www.scala-sbt.org/download.html) | 1.4.7 | [maven.aliyun.com](https://developer.aliyun.com/mvn/guide) |
| [Verilator](https://www.veripool.org/verilator/) | 4.010 |
| [OpenSSH](https://www.openssh.com/) | 7.9p1 |
| [Code Server](https://github.com/cdr/code-server) | 3.12.0 |


***



## Usage
### Pull Imgae
```shell
docker pull zao111222333/spinalhdl-online
```
### Run Container
```shell
docker run -itd \
  --restart=always \
  -p 8848:8080 \
  -p 2222:22 \
  -e USER=username \
  -e PASSWORD=123456 \
  -e WORKDIR=/SpinalHDL/ \
  -v ~/SpinalHDL-Share:/SpinalHDL/ \
  -v ~/KEY:/KEY \
  zao111222333/spinalhdl-online
```
### Use It
SpinalHDL-Online websit will be accessible on 8848 port of host, access `http://localhost:8848` with `PASSWORD=123456`.

You can also use ssh for further functions (remote control, files transmisson), via `ssh -p 2222 username@localhost` with `PASSWORD=123456`.

You can also change `PORT`/`USER`/`PASSWORD`/`etc`, [see here](#Definitions-of-Configures).


***


## Further Info.
### Definitions of Configures

| Configure | Describe |
|  ----  | ----  | 
| -p `8848`:8080 | spinalhdl-online will be accessible on 8848 port of Host, `http://localhost:8848` |
| -p `2222`:22 | ssh-server will be accessible on 2222 port of Host,   `ssh -p 2222 username@localhost` |
| -e USER=`username` | The USER's name in Docker (debian10) |
| -e PASSWORD=`123456` | The PASSWORD for both spinalhdl-online's Login and USER |
| -e WORKDIR=`/SpinalHDL/` | The spinalhdl-online's defualt launch directory |
| -v `~/SpinalHDL-Share/`:`/SpinalHDL/` | Share directory between Host and Docker. `~/SpinalHDL-Share/` (in Host) will share the contents within `/SpinalHDL/` (in Docker) |

Modify the `Highlight-Configures` according to your situation.

### VS Code Extension

| Extension | Version  | Describe |
|  ----  | ----  | ----  | 
| [Scala Syntax (official)](https://marketplace.visualstudio.com/items?itemName=scala-lang.scala) | 0.5.4 | Visual Studio Code extension providing syntax highlighting for Scala 2 and Scala 3 source files. |
| [Scala (Metals)](https://marketplace.visualstudio.com/items?itemName=scalameta.metals)| 1.10.10 | Metals extension for Visual Studio Code. |
| [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer) | 0.2.1 | A customizable extension for colorizing matching brackets. |
| [Verilog-HDL](https://marketplace.visualstudio.com/items?itemName=mshr-h.VerilogHDL) | 1.5.0 | Verilog-HDL, SystemVerilog and Bluespec SystemVerilog support for VS Code with Syntax Highlighting, Snippets, Linting and much more! |


***


## dev: Bulid It Youself

### Clone Source
**[IMPORTANT] Install [Git-LFS](https://git-lfs.github.com/) to clone large files.**
```shell
git lfs clone https://github.com/zao111222333/spinalhdl-online.git
```
### Bulid Imgae
```shell
# The next operation need to execute at root-path/
#  root-path/---src/
#           |---docker-entrypoint.sh
#           |---Dockerfile
#           |---README.md
#           |---.gitattributes

docker build --network=host -t spinalhdl-online .
```
### Run Container
```shell
docker run -itd \
  --restart=always \
  -p 8848:8080 \
  -p 2222:22 \
  -e USER=username \
  -e PASSWORD=123456 \
  -e WORKDIR=/SpinalHDL/ \
  -v ~/SpinalHDL-Share:/SpinalHDL/ \
  -v ~/KEY:/KEY \
  spinalhdl-online
```
