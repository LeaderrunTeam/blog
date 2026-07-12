---
title: VTableForm 虚拟表格表单
meta:
  - name: description
    content: 查询表单与虚拟表格的组合，适用于大数据量查询列表
---

# VTableForm

将查询 [Form](./form.md) 表单与 [Vtable](./vtable.md) 虚拟表格组合而成的查询列表。用法与 [TableForm](./table-form.md) 一致，区别在于表格部分使用支持虚拟滚动的 `Vtable`，适合大数据量场景。组件会自动计算并撑满表格高度。

## 使用

通过 `form-props` 配置查询表单（参考 [NForm](./form.md#props)），通过 `table-props` 配置虚拟表格（参考 [Vtable](./vtable.md#props)）。

:::demo

```vue
<template>
  <n-vtable-form
    v-model="queryForm"
    :outside-height="240"
    :form-props="{ fields }"
    :table-props="{ rowData: data, columnDefs: columns, total }"
    @query="doQuery"
  >
    <template #column-address="{ data }">
      <strong>{{ data.address }}</strong>
    </template>
  </n-vtable-form>
</template>
<script>
import { ref } from 'vue'

export default {
  setup() {
    const queryForm = ref({})
    const total = ref(1000)

    const fields = [
      { md: 8, xl: 6, label: '地址', prop: 'address', component: 'el-input' },
      { md: 8, xl: 6, label: '姓名', prop: 'name', component: 'el-input' }
    ]

    const columns = ref([
      { field: 'date', headerName: '日期', width: 200 },
      { field: 'name', headerName: '姓名' },
      { field: 'address', headerName: '地址', slot: true }
    ])

    const data = ref(
      Array.from({ length: 1000 }).map((_, i) => ({
        date: '2016-05-03',
        name: `姓名 ${i + 1}`,
        address: 'No. 189, Grove St, Los Angeles'
      }))
    )

    const doQuery = (done) => {
      setTimeout(() => {
        done()
      }, 1000)
    }

    return { queryForm, fields, columns, data, total, doQuery }
  }
}
</script>
```

:::

## Props

| Name           | Description                                                                       | Type    | Options | Default |
| :------------- | :-------------------------------------------------------------------------------- | :------ | :------ | :------ |
| v-model        | 表单值                                                                            | object  | -       | -       |
| form-props     | 查询表单配置，参考 [NForm](./form.md#props) 属性                                  | object  | -       | -       |
| table-props    | 虚拟表格配置，参考 [Vtable](./vtable.md#props) 属性                               | object  | -       | -       |
| add            | 是否显示新增按钮                                                                  | boolean | -       | true    |
| add-props      | 新增按钮属性                                                                       | object  | -       | -       |
| outside-height | 用于计算表格高度，除表格外其它元素占用的高度。设置为 0 或未设置表格高度时自动计算 | number  | -       | -       |
| enter-query    | 输入框回车是否触发查询事件                                                        | boolean | -       | true    |
| loading        | 是否显示 loading                                                                  | boolean | -       | false   |

**支持 [Form 属性](./form.md#props)**

## Events

| Name               | Description                                                | Parameters                   |
| ------------------ | --------------------------------------------------------- | ---------------------------- |
| query              | 查询按钮被点击后触发，使用 `done()` 函数关闭 `loading` 状态 | done, isValid, invalidFields |
| reset              | 重置按钮被点击后触发                                       | -                            |
| add                | 新增按钮被点击后触发                                       | -                            |
| size-change        | pageSize 改变时触发                                        | 每页条数                     |
| current-change     | currentPage 改变时触发                                     | 当前页                       |
| column-defs-change | 表格列宽、固定、显隐等改变时触发，可用于持久化列配置       | `ColumnDefsChangeEvent[]`    |
| update:model-value | 表单值改变时触发，用于 v-model                            | 表单值                       |

::: tip 提示

`table-props` 中支持 `Vtable` 的全部属性与事件，表格相关事件（如 `column-defs-change`、`selection-changed` 等）可直接监听在 `n-vtable-form` 上。

:::

## Methods

| Name                 | Description                          | Parameters | Returns    |
| -------------------- | ------------------------------------ | ---------- | ---------- |
| doQuery              | 手动触发 `query` 事件                | -          | -          |
| resetFields          | 重置整个查询表单                     | -          | -          |
| calculateTableHeight | 重新计算表格高度                     | -          | -          |
| getSelectionRows     | 获取表格所有选中行数据               | -          | 选中行数组 |
| isChange             | 判断表单值是否发生变化               | -          | boolean    |
| resetChange          | 重置表单的变化状态                   | -          | -          |

## Slots

| Name          | Description                                                       |
| ------------- | ---------------------------------------------------------------- |
| form-before   | 表单字段开始之前的内容                                           |
| form-after    | 按钮节点之后的内容                                               |
| action-before | 在按钮之前的内容                                                 |
| action-after  | 在新增按钮之后的内容                                             |
| [prop]        | 当前表单项的内容，参数为 `{ item, value, setValue }`             |
| [prop]-label  | 当前表单项的标签文本内容，参数为 `{ item }`                      |
| index         | 表格自定义序号列内容，参数为 `{ params, index }`                 |
| column-[field] | 表格中配置 `slot: true` 列的内容，参数为 `{ data, index }`      |
| pagination    | 表格分页栏左侧内容                                               |

::: tip 提示

`[prop]` 为 `form-props.fields` 中定义的 `prop`，`[field]` 为 `table-props.columnDefs` 中定义的 `field`

:::

## TypeScript 定义

使用 `typescript` 时可从组件中导出 `VtableFormExpose` 类型以获得更好的类型推导。

```ts
import type { VtableFormExpose } from 'element-pro'
```
