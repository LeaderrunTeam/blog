---
title: Link
meta:
  - name: description
    content: 链接组件
---

# Link

`NLink` 根据 `to` 的值自动选择渲染方式：外部地址渲染为带安全属性的 `<a>`，应用内路径渲染为 Vue Router 的 `<router-link>`，未提供 `to` 时渲染为普通内容容器。

## 使用

:::demo

```vue
<template>
  <div class="link-demo">
    <n-link to="https://element-plus.org">外部链接</n-link>
    <n-link to="/web/components/started">站内路由</n-link>
    <n-link>无链接内容</n-link>
  </div>
</template>

<style>
.link-demo {
  display: flex;
  gap: 16px;
  align-items: center;
}
</style>
```

:::

## Props

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| to | 外部 URL 或 Vue Router 路径。`http://`、`https://` 等地址会在新窗口打开；其它值交给 `router-link` | string | - |

## Slots

| Name | Description |
| --- | --- |
| default | 链接文本或自定义内容 |

外部链接会自动添加 `target="_blank"` 和 `rel="noopener noreferrer"`。如果项目没有安装 Vue Router，使用站内路径时请改用外部 URL 或自行提供路由环境。
