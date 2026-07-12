---
title: Tour 引导
meta:
  - name: description
    content: 对 ElTour 的增强，支持配置化步骤、步骤配图以及只引导一次
---

# Tour

对 [ElTour](https://element-plus.gitee.io/zh-CN/component/tour.html) 的增强，通过 `items` 数组配置化生成引导步骤，并支持为每个步骤配置图片以及“只引导一次”的能力。

::: tip 提示

设置 `tour-once`（默认开启）后，引导完成时会以 `tour-id` 为标识写入本地存储，下次进入不再自动弹出，因此 `tour-id` 必须唯一。

:::

## 使用

:::demo

```vue
<template>
  <div class="tour-demo">
    <el-button ref="ref1" type="primary" @click="open = true">开始引导</el-button>
    <el-button ref="ref2">保存</el-button>
    <el-button ref="ref3">更多操作</el-button>

    <n-tour
      v-model="open"
      tour-id="demo-tour"
      :tour-once="false"
      :items="items"
    />
  </div>
</template>
<script>
import { ref } from 'vue'

export default {
  setup() {
    const open = ref(false)
    const ref1 = ref()
    const ref2 = ref()
    const ref3 = ref()

    const items = [
      {
        target: () => ref1.value?.$el,
        title: '开始',
        description: '点击这里开始你的操作'
      },
      {
        target: () => ref2.value?.$el,
        title: '保存',
        description: '在这里保存你的数据'
      },
      {
        target: () => ref3.value?.$el,
        title: '更多',
        description: '更多操作都收纳在这里'
      }
    ]

    return { open, ref1, ref2, ref3, items }
  }
}
</script>
```

:::

## Props

| Name                 | Description                                                          | Type          | Options | Default |
| -------------------- | ------------------------------------------------------------------- | ------------- | ------- | ------- |
| model-value / v-model | 是否显示引导                                                       | boolean       | -       | false   |
| tour-id              | 引导唯一标识，`tour-once` 为真时用于记录是否已引导过                 | string        | -       | -（必填）|
| tour-once            | 是否只引导一次，完成后写入本地存储，下次不再自动弹出                 | boolean       | -       | true    |
| items                | 引导步骤配置，参考下面 [items](#items-props)                        | NTourItem[]   | -       | []      |
| show-close           | 是否显示关闭按钮                                                     | boolean       | -       | false   |
| close-on-press-escape | 是否支持按下 ESC 关闭                                              | boolean       | -       | false   |

**支持 `element-plus` [Tour 属性](https://element-plus.gitee.io/zh-CN/component/tour.html#tour-attributes)**

### Items Props

| Name         | Description                              | Type                        | Options                | Default |
| ------------ | ---------------------------------------- | --------------------------- | ---------------------- | ------- |
| target       | 引导目标元素，支持选择器、元素或返回元素的函数 | `string/HTMLElement/Function` | -                    | -       |
| title        | 步骤标题                                 | string                      | -                      | -       |
| description  | 步骤内容描述                             | string                      | -                      | -       |
| image-url    | 步骤配图地址                             | string                      | -                      | -       |
| image-style  | 步骤配图样式                             | string                      | -                      | -       |
| placement    | 引导框位置                               | string                      | top / bottom / left / right 等 | bottom  |
| mask         | 是否显示遮罩，也可传入对象自定义遮罩样式 | `boolean/object`            | -                      | true    |
| type         | 类型，会改变遮罩和引导框的样式           | string                      | default / primary      | default |
| show-arrow   | 是否显示箭头                             | boolean                     | -                      | true    |
| content-style | 引导框内容区域样式                      | object                      | -                      | -       |
| next-button-props | 下一步按钮属性                      | object                      | -                      | -       |
| prev-button-props | 上一步按钮属性                      | object                      | -                      | -       |
| show-close   | 是否显示关闭按钮                         | boolean                     | -                      | -       |
| close-icon   | 自定义关闭图标                           | `string/Component`          | -                      | -       |
| scroll-into-view-options | 目标元素滚动到可视区域的配置    | `boolean/object`            | -                      | -       |

**每个步骤同时支持 `element-plus` [TourStep 属性](https://element-plus.gitee.io/zh-CN/component/tour.html#tourstep-attributes)**

## Events

| Name              | Description                        | Parameters   |
| ----------------- | ---------------------------------- | ------------ |
| change            | 当前步骤改变时触发                 | current 当前步骤下标 |
| close             | 引导关闭时触发                     | current 当前步骤下标 |
| finish            | 引导完成时触发                     | -            |
| update:model-value | 显示状态改变时触发，用于 v-model  | 是否显示     |
| update:current    | 当前步骤改变时触发，可用于双向绑定 | 当前步骤下标 |

## Slots

| Name       | Description        |
| ---------- | ------------------ |
| indicators | 自定义步骤指示器内容 |
