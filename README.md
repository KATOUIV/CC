# CC

CloudCLI + CC Switch 的 Windows 便携包。解压（或一行命令）装好后，用 CC Switch 填 Token，再开 CloudCLI 网页就能用。

当前版本：1.0.1  

协议见 [LICENSE](./LICENSE)：个人自用可以，魔改只能自己用；不许拿去卖、收费分发或公开传魔改版。

---

## 安装（二选一）

### 一行命令

PowerShell 里执行：

```powershell
irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

装好后目录一般是：`C:\Users\你的用户名\CC`

换盘举例：

```powershell
$env:CC_INSTALL_DIR='D:\CC'; irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

### 手动下载

1. 到 [Releases](https://github.com/KATOUIV/CC/releases) 下载 `CC-portable.zip`
2. 解压
3. 第一次先双击 `SETUP.bat`，等它跑完

---

## 怎么用

1. 双击 `START-CC-Switch.bat`，填好 API Token 并切换到要用的账号  
2. 双击 `START-CloudCLI.bat`  
3. 浏览器打开 http://127.0.0.1:3001  

包里还有 `README.txt`，步骤写得更细。

常见文件：

| 文件 | 干嘛的 |
|------|--------|
| SETUP.bat | 第一次安装用，换电脑也要再跑一次 |
| START-CC-Switch.bat | 管 API 账号 |
| START-CloudCLI.bat | 开网页界面 |
| README.txt | 说明书 |

---

## 只有 CloudCLI、本机已有 Node 时

也可以直接装官方包（没有本仓库里的 CC Switch / Skills 那一套）：

```powershell
npm install -g @cloudcli-ai/cloudcli
cloudcli
```
