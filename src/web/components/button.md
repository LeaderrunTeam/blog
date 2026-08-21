---
title: Button
meta:
  - name: description
    content: 按钮组件
---

# Button

对 ElButton 封装

## 使用

:::demo

```vue
<template>
  <div class="card-demo">
    <p>点击次数：{{ count }}</p>
    <n-button type="primary" :debounce="800" @click="doClick">快速连续点击</n-button>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  setup() {
    const count = ref(0)
    const doClick = () => {
      count.value = count.value + 1
    }

    return {
      doClick,
      count
    }
  }
}
</script>
<style>
.card-demo {
  background-color: var(--el-bg-color-page);
  padding: 15px;
}
</style>
```

:::

## Props

| Name     | Description                            | Type   | Options | Default |
| -------- | -------------------------------------- | ------ | ------- | ------- |
| debounce | 防抖动，多少毫秒内只能触发一次点击事件 | number | -       | 300     |

除 `debounce` 外，`NButton` 支持 `element-plus` `ElButton` 的全部属性、插槽和事件。
