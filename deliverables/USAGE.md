# Slimefun Base64Coder 补丁：情况与使用说明

## 1. 适用情况

在以下情况使用本补丁：

- Slimefun 运行时报错：`NoClassDefFoundError: org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder`
- 背包关闭后不保存，重启后物品丢失
- 机器库存不保存，重启后物品丢失
- 已确认插件内 `DataUtils` 调用了 `Base64Coder.encodeLines/decodeLines`

不适用情况：

- 你的 Slimefun 版本已包含该类
- 报错不是 `Base64Coder` 缺失（需要先定位真实异常）

## 2. 使用说明

### 2.1 准备文件

确保以下文件已上传到远端服务器同一目录：

- `org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder.class`
- `inject-base64coder.ps1`

### 2.2 执行注入

在 PowerShell 执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\inject-base64coder.ps1 -JarPath "D:\plugins\Slimefun-2025.04-release.jar"
```

### 2.3 验证注入

执行后应看到 `Done. Injection successful.`。

也可手动验证：

```powershell
jar tf D:\plugins\Slimefun-2025.04-release.jar | findstr /i "org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder.class"
```

## 3. 常见情况处理

### 情况 A：提示 Jar not found

- 检查 `-JarPath` 是否填写完整绝对路径
- 检查文件名大小写与版本号是否一致

### 情况 B：提示 class file not found

- 当前目录不对，先 `cd` 到补丁目录再执行脚本
- 确认相对路径存在：`org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder.class`

### 情况 C：注入成功但仍不保存

- 确认服务器已完全重启（不是仅热重载）
- 检查控制台是否还有其他异常（数据库、序列化、兼容性）
- 用最小复现测试：放入背包/机器物品 -> 关闭 -> 重启 -> 再次检查

## 4. 风险说明

- 本补丁只解决 `Base64Coder` 缺失问题，不覆盖其他存储逻辑问题
- 建议后续在源码层将 `DataUtils` 迁移到 `java.util.Base64`，避免依赖 SnakeYAML internal API
