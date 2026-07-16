# CC - CloudCLI + CC Switch Portable

**Current version: 1.0.1**

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

**要求：** 已安装 [Node.js](https://nodejs.org/)（建议 v18+）

```powershell
npm install -g @cloudcli-ai/cloudcli
cloudcli
```

自定义数据目录（可选）：

```powershell
$env:CLOUDCLI_HOME='D:\my-cloudcli-data'
cloudcli
```

安装后默认在浏览器打开本地界面（常见为 `http://127.0.0.1:3001`）。  
API Token 等配置按 CloudCLI / Claude Code 官方说明填写。

卸载：

```powershell
npm uninstall -g @cloudcli-ai/cloudcli
```

> 此方式**不包含**本仓库便携包里的 CC Switch、内置 Skills 同步等。需要那些能力请用下面的便携包。

---

## 方式二：便携包一行安装（零环境）

```powershell
irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

自定义安装路径：

```powershell
$env:CC_INSTALL_DIR='D:\CC'; irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

### 安装后（便携包）

1. 打开 `%USERPROFILE%\CC\START-CC-Switch.bat`，配置 API Token  
2. 运行 `%USERPROFILE%\CC\START-CloudCLI.bat`  
3. 浏览器：http://127.0.0.1:3001  

### 手动下载

从 [Releases](https://github.com/KATOUIV/CC/releases) 下载 `CC-portable.zip`，解压后运行 `SETUP.bat`。

### 便携包文件说明

| File | Purpose |
|------|---------|
| SETUP.bat | First-time setup |
| START-CloudCLI.bat | Launch web UI |
| START-CC-Switch.bat | Launch CC Switch |
| README.txt | Full guide inside the package |

---

## Publish new version (maintainer)

1. Update `VERSION` and `CHANGELOG.md`
2. Rebuild `CC-portable.zip` on Desktop
3. Run `login-github.bat` (first time only)
4. Run `publish.ps1`

- `install.ps1` - remote one-line installer (small, in git)
- `CC-portable.zip` - full portable bundle (GitHub Release, not in git)
