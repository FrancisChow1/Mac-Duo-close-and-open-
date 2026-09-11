# Mac Duo · 双向开合版 / Bidirectional Close & Open Edition

中文 | [English](#english)

## 中文

### 项目说明

本项目基于 [Makito（sumimakito）](https://github.com/sumimakito) 的开源项目
[Mac-Duo](https://github.com/sumimakito/Mac-Duo)。原项目通过 MacBook 转轴角度传感器、ScreenCaptureKit 和 Metal，模拟 iPhone Duo 风格的合盖视觉效果。

本仓库是在原项目基础上的改进版本：保留原作者的合盖效果，并增加**开盖/唤醒时的反向展开效果**，让透视、模糊和变暗随转轴角度恢复。

它是覆盖层应用，不是对 macOS WindowServer 或 LoginWindow 的系统补丁；不修改系统文件，不关闭 SIP。

### 锁屏设置建议

要让短时间合盖后重新打开时直接看到展开效果，建议不要让 macOS 立即切到登录锁屏界面：

1. 打开“ → 系统设置 → 锁定屏幕”。
2. 找到“屏幕保护程序启动或显示器关闭后要求密码”。
3. 建议设置为 **1 小时**或更长，不建议永久设置为“永不”。

这样在设定时间内重新开盖，通常会回到当前用户会话，Mac Duo 才能显示开盖效果；超过设定时间仍会正常要求登录。需要更高安全性时，可恢复为“立即”。

即使启用锁屏，应用也不会跨睡眠保存清晰桌面：只保留内存中的强模糊、暗化种子帧，LoginWindow 仍由 macOS 控制。

### 环境要求

- macOS 14 或更高版本
- 带兼容转轴角度传感器的 MacBook
- Xcode 26 / Swift 6 或更高版本
- 在“隐私与安全性 → 屏幕与系统音频录制”中允许 Mac Duo

### 构建与运行

```sh
./build.sh
./build.sh --run
```

脚本会生成 `build/Mac Duo.app`。首次运行时，请在系统设置中允许屏幕录制权限。

### 已知限制

- 只处理内置显示器。
- 普通应用无法保证覆盖所有 macOS 登录/锁屏界面，因此锁屏开启时不承诺在密码界面上显示动画。
- 点击会穿透覆盖层，继续作用于下方应用。
- 本地开发签名适合个人 Mac 使用，不等同于公开发布所需的 Developer ID 公证包。

### 致谢与许可

原作者：**Makito（sumimakito）**。本版本保留原项目 Apache License 2.0 许可和 NOTICE 声明，并增加双向开合功能。

---

## English

### About

This repository is based on [Mac-Duo](https://github.com/sumimakito/Mac-Duo) by
[Makito (sumimakito)](https://github.com/sumimakito). The original project uses the MacBook lid-angle sensor, ScreenCaptureKit, and Metal to reproduce an iPhone Duo-style effect while closing the lid.

This repository keeps the original closing effect and adds a **reverse opening/wake effect**, so perspective, blur, and dimming unwind with the measured hinge angle.

It is an overlay application, not a patch to WindowServer or LoginWindow. It does not modify system files or disable SIP.

### Lock-screen recommendation

To see the opening effect after a short close-and-open cycle:

1. Open **Apple menu → System Settings → Lock Screen**.
2. Find **Require password after screen saver begins or display is turned off**.
3. Set it to **1 hour** (or longer). Avoid **Never** unless you accept the security trade-off.

Within that period, macOS normally returns to the active user session and Mac Duo can draw the opening effect. After the selected period, authentication is still required. Restore **Immediately** for the strongest protection.

The app never carries a clear desktop frame across sleep: only an in-memory, heavily blurred and darkened seed is retained. LoginWindow remains controlled by macOS.

### Requirements

- macOS 14 or later
- A MacBook with a compatible lid-angle sensor
- Xcode 26 / Swift 6 or later
- Mac Duo enabled under **Privacy & Security → Screen & System Audio Recording**

### Build and run

```sh
./build.sh
./build.sh --run
```

The script creates `build/Mac Duo.app`. On first launch, allow Mac Duo in System Settings when prompted.

### Known limitations

- The effect applies only to the built-in display.
- A regular app cannot guarantee an overlay above every macOS login/lock screen, so no animation is promised over a password prompt.
- Clicks pass through the overlay to the app underneath.
- The local development signature is intended for personal Mac use and is not a notarized Developer ID release package.

### Credits and license

Original author: **Makito (sumimakito)**. This repository retains the upstream Apache License 2.0 terms and NOTICE file, and adds bidirectional close/open behavior.
