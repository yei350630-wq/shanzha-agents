# 部署到 GitHub Pages · 一次性设置 + 日常更新

> 目的：把这个作品集网页挂到一个**固定公开网址**上，并且**任何一个账号/任何一台机器**都能更新它，
> 不再被某一个 WorkBuddy 账号锁死。核心思路：发布 = `git push`，权限来自仓库写入权，与 WorkBuddy 账号无关。

---

## 一、一次性设置（约 5 分钟）

### 1. 在 GitHub 建一个仓库
打开 https://github.com/new
- **Repository name**：建议 `shanzha-agents`（也可以直接用你的 `用户名.github.io`，这样网址更短、是根路径）
- 选 **Public**（GitHub 免费版 Pages 需要公开仓库）
- 不要勾选 "Add a README"（本地已有内容，避免冲突）
- 点 **Create repository**

### 2. 把本地仓库关联上去并首次推送
在本目录打开 Git Bash，执行（把 `你的用户名` 和 `仓库名` 换成实际值）：

```bash
git remote add origin https://github.com/你的用户名/仓库名.git
git branch -M main
git push -u origin main
```

> 首次推送可能弹出 GitHub 登录/授权，按提示完成即可（用你常用的 GitHub 账号）。

### 3. 开启 Pages（关键：来源选 GitHub Actions）
仓库页面 → **Settings** → 左侧 **Pages** → **Build and deployment → Source** 选 **`GitHub Actions`**
（不要选 "Deploy from a branch"）

### 4. 等约 1 分钟，拿网址
推送后自动触发部署：仓库 → **Actions** 标签能看到运行记录，绿勾即成功。
网址在 **Settings → Pages** 顶部显示，形如：
- 项目仓库：`https://你的用户名.github.io/仓库名/`
- 用户站点：`https://你的用户名.github.io/`

把这个网址发给别人即可打开（不依赖任何 WorkBuddy 账号）。

---

## 二、日常更新（以后每次都这样）

改完本地文件后，**双击 `publish.bat`**（或手动 `git add -A && git commit -m Update && git push`）。
推送后 GitHub Actions 自动重新部署，约 1 分钟生效。

**任何账号都能改**：只要那台机器/那个 WorkBuddy 会话配过一次 Git 推送权限（上面第 2 步），
之后谁登录都能跑 `publish.bat` 更新——因为卡的是"仓库写入权"，不是"哪个 WorkBuddy 账号"。

---

## 三、说明与边界
- **只公开 `index.html` + `pages/`**：工作流只打包这两样上线。`index-v2.html`、`serve.js`、
  本地启动 `.bat`、内部任务书、`t1.png` 已被 `.gitignore` 挡在仓库外，不会公开。
- **首页底部"合集 02 / 03 打开 ↗"**：这两个入口指向你本机的其他合集，公开网上点它们会弹提示而非报错——这是设计如此，不是坏了。
- **想绑自己的域名**（可选）：在仓库根放一个内容为你域名的 `CNAME` 文件，再去 GitHub Pages 设置里填域名并解析 DNS。需要我帮忙就说。

---

## 四、出问题对照
| 现象 | 原因 / 处理 |
|---|---|
| Actions 红叉、部署失败 | 点进 run 看日志；多半是第 3 步 Pages 来源没设成 `GitHub Actions` |
| 网页 404 | 仓库没开 Pages，或 Source 没选 Actions；或还没推成功 |
| 页面能开但子页面点不动 | 不会发生——全站都是相对路径；若真出现，检查是否误把链接改成了 `/` 开头的绝对路径 |
| `git push` 要求登录/被拒 | 用有该仓库写入权限的 GitHub 账号登录；换账号就换有权限的那个 |
