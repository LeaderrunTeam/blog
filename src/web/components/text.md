---
title: Text 文本
meta:
  - name: description
    content: 对 ElText 的增强，支持一键复制文本
---

# Text

对 [ElText](https://element-plus.gitee.io/zh-CN/component/text.html) 的增强，在其基础上支持复制文本内容。

## 使用

:::demo

```vue
<template>
  <div class="text-demo">
    <n-text>默认文本</n-text>
    <n-text type="primary">primary</n-text>
    <n-text type="success">success</n-text>
    <n-text type="info">info</n-text>
    <n-text type="warning">warning</n-text>
    <n-text type="danger">danger</n-text>

    <n-text size="large">大号文本</n-text>
    <n-text size="small">小号文本</n-text>

    <div style="width: 200px">
      <n-text truncated>这是一段会被截断显示省略号的很长很长的文本内容</n-text>
    </div>

    <div style="width: 200px">
      <n-text :line-clamp="2">
        这是一段超过两行之后会被截断的很长很长很长很长很长很长很长很长的文本内容
      </n-text>
    </div>

    <n-text show-copy>点击左侧图标复制这段文本</n-text>
  </div>
</template>
<style>
  .text-demo .el-text {
    display: block;
    margin-bottom: 12px;
  }
</style>
```

:::

## Props

| Name       | Description                                  | Type            | Options                                        | Default |
| ---------- | -------------------------------------------- | --------------- | ---------------------------------------------- | ------- |
| type       | 类型                                         | string          | primary / success / info / warning / danger    | -       |
| size       | 尺寸                                         | string          | large / default / small                        | default |
| truncated  | 是否显示省略号，需要配合固定宽度使用         | boolean         | -                                              | false   |
| line-clamp | 最大显示行数，超出后截断                     | `string/number` | -                                              | -       |
| tag        | 自定义元素标签                               | string          | -                                              | span    |
| show-copy  | 是否显示复制图标，点击图标复制默认插槽的文本 | boolean         | -                                              | false   |

**支持 `element-plus` [Text 属性](https://element-plus.gitee.io/zh-CN/component/text.html#attributes)**

## Slots

| Name    | Description |
| ------- | ----------- |
| default | 默认内容    |
