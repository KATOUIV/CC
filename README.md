# CC - CloudCLI + CC Switch 便携包

**当前版本：1.0.1**

## 使用协议

详见 [LICENSE](./LICENSE)。简要说明：

- **允许**：个人非商业使用；魔改**仅限自用**；分享官方原版下载链接  
- **禁止**：盈利/商用、出售、付费分发；公开发布或传播魔改版；冒充官方  
- 包内第三方软件仍遵守各自原协议  

本仓库提供两种安装方式：

| 方式 | 适合谁 | 包含什么 |
|------|--------|----------|
| **官方 npm** | 本机已有 Node.js | 仅 CloudCLI |
| **便携包** | 不想装环境 / 要 CC Switch + Skills | CloudCLI + CC Switch + Skills + 内置运行时 |

---

## 方式一：官方 npm 安装（推荐有 Node 的用户）

**要求：** 已安装 [Node.js](https://nodejs.org/)（建议 v18 或更高）

```powershell
npm install -g @cloudcli-ai/cloudcli
cloudcli
```

自定义数据目录（可选）：

```powershell
$env:CLOUDCLI_HOME='D:\my-cloudcli-data'
cloudcli
```

安装后一般会在浏览器打开本地界面：http://127.0.0.1:3001  
API Token 等配置按 CloudCLI / Claude Code 官方说明填写。

卸载：

```powershell
npm uninstall -g @cloudcli-ai/cloudcli
```

> 此方式**不包含**本仓库便携包里的 CC Switch、内置 Skills 同步等。需要那些能力请用下面的便携包。

---

## 方式二：便携包一行安装（零环境，推荐小白）

在 PowerShell 中执行：

```powershell
irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

默认会安装到你的用户目录下的 `CC` 文件夹，例如：

`C:\Users\你的用户名\CC`

（「你的用户名」就是 Windows 登录名，一般是 `C:\Users\` 后面那一段。）

想装到别的盘，可以这样：

```powershell
$env:CC_INSTALL_DIR='D:\CC'; irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

### 安装完成后怎么用

1. 打开安装目录里的 `START-CC-Switch.bat`，配置 API Token  
2. 再运行 `START-CloudCLI.bat`  
3. 用浏览器打开：http://127.0.0.1:3001  

### 手动下载安装

1. 打开 [Releases（发布页）](https://github.com/KATOUIV/CC/releases)  
2. 下载最新的 `CC-portable.zip`  
3. 解压到任意文件夹  
4. **第一次**双击 `SETUP.bat`（必做）  
5. 再按上面「安装完成后怎么用」操作  

### 便携包里主要文件

| 文件 | 作用 |
|------|------|
| SETUP.bat | 首次安装 / 自检（新电脑解压后必跑一次） |
| START-CloudCLI.bat | 启动 CloudCLI 网页界面 |
| START-CC-Switch.bat | 启动 CC Switch（管理 API 账号） |
| README.txt | 包内完整中文说明书 |

---

## 维护者发布新版本

1. 更新 `VERSION` 和 `CHANGELOG.md`  
2. 在桌面重新打包 `CC-portable.zip`  
3. 首次发布先运行 `login-github.bat`  
4. 运行 `publish.ps1`  

说明：

- `install.ps1`：一行安装脚本（在 git 仓库里）  
- `CC-portable.zip`：完整便携包（只放在 GitHub Release，不进 git）  
