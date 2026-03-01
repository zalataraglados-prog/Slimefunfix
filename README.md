# Slimefun Base64Coder Fix

用于修复镜像版 Slimefun 因缺失 `Base64Coder` 导致的背包/机器库存不保存问题。

## 问题特征

- 报错链路：`BackpackListener.onClose -> saveBackpackInventory -> DataUtils.itemStack2String`
- 缺失类：`org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder`
- 或出现版本报错：`UnsupportedClassVersionError`（class file version 不兼容）

本仓库提供的 `Base64Coder.class` 已按 Java 23 目标编译：

- `major version: 67`（兼容 Java 23）

## 交付内容

- `deliverables/org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder.class`
- `deliverables/inject-base64coder.ps1`
- `deliverables/SHA256SUMS.txt`
- `deliverables/USAGE.md`
- `deliverables_v9.zip`

## 使用方法

1. 上传 `deliverables_v9.zip` 到服务器并解压。
2. 在解压目录执行注入：

```powershell
powershell -ExecutionPolicy Bypass -File .\inject-base64coder.ps1 -JarPath "D:\plugins\Slimefun-2025.04-release.jar"
```

3. 重启服务器（不要只热重载）。
4. 验证类已注入：

```powershell
jar tf D:\plugins\Slimefun-2025.04-release.jar | findstr /i "org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder.class"
```

5. 进行功能验证：
- 背包放物品 -> 关闭 -> 重启 -> 物品仍存在
- 机器放物品 -> 关闭 -> 重启 -> 物品仍存在

详细说明见 `deliverables/USAGE.md`。
