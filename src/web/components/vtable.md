---
title: Vtable 虚拟表格
meta:
  - name: description
    content: 基于 ag-grid 的虚拟滚动表格，适用于大数据量展示
---

# Vtable

基于 [ag-grid](https://www.ag-grid.com/) 的虚拟滚动表格，通过配置动态生成列。适用于大数据量（成千上万行）的展示场景。

::: warning 提示

1. `Vtable` 采用虚拟滚动，**必须设置一个固定高度**：可通过 `height` 属性（单位 px）指定，或让父容器有明确的高度，否则表格无法正常渲染。

2. 列配置使用 ag-grid 的 `field`（对应数据字段名）和 `headerName`（列头文本），与普通 [Table](./table.md) 的 `prop` / `label` 不同。

3. 表格内置了右键单元格菜单（自适应列宽、固定列、隐藏列、排序等）、双击单元格自适应列宽、`Ctrl + C` 复制单元格内容以及导出 CSV 能力。

:::

## 使用

支持通过 `column-defs` 配置列、`row-data` 传入数据。下面的示例渲染了 1000 行数据以体现虚拟滚动能力，并演示了序号插槽、列插槽、操作列与多选。

:::demo

```vue
<template>
  <n-vtable
    :column-defs="columnDefs"
    :row-data="rowData"
    :height="320"
    :actions="actions"
    :action-limit="2"
    selection-mode="multiRow"
  >
    <template #index="{ index }">
      {{ index }}
    </template>
    <template #column-status="{ data }">
      <n-tag :type="data.status.tagType">{{ data.status.desc }}</n-tag>
    </template>
  </n-vtable>
</template>
<script>
import { ref } from 'vue'

export default {
  setup() {
    const columnDefs = ref([
      { field: 'name', headerName: '姓名', width: 150 },
      { field: 'address', headerName: '地址', width: 260 },
      { field: 'date', headerName: '日期', timeFormat: 'YYYY-MM-DD' },
      { field: 'status', headerName: '状态', slot: true }
    ])

    const rowData = ref(
      Array.from({ length: 1000 }).map((_, i) => ({
        name: `姓名 ${i + 1}`,
        address: 'No. 189, Grove St, Los Angeles',
        date: 1724233782053,
        status:
          i % 2 === 0
            ? { desc: '已支付', tagType: 'success' }
            : { desc: '未支付', tagType: 'danger' }
      }))
    )

    const actions = [
      {
        label: '编辑',
        type: 'primary',
        click: ({ row }) => console.log('编辑', row)
      },
      {
        label: '删除',
        type: 'danger',
        click: ({ row }) => console.log('删除', row)
      },
      {
        label: '详情',
        click: ({ row }) => console.log('详情', row)
      }
    ]

    return { columnDefs, rowData, actions }
  }
}
</script>
```

:::

## Props

| Name                        | Description                                                            | Type                | Options              | Default       |
| --------------------------- | --------------------------------------------------------------------- | ------------------- | -------------------- | ------------- |
| column-defs                 | 列配置，参考下面 [Column Props](#column-props)                        | Column[]            | -                    | []            |
| row-data                    | 显示的数据                                                            | array               | -                    | []            |
| height                      | 表格高度，单位 px。不传时高度为父容器的 100%                          | number              | -                    | -             |
| column-default              | 所有列的默认配置，同 ag-grid `defaultColDef`                          | object              | -                    | -             |
| border                      | 是否显示表格边框线                                                    | boolean             | -                    | false         |
| show-config                 | 是否显示自定义列配置（拖拽排序、显隐、固定）                          | boolean             | -                    | true          |
| column-fit                  | 列自动铺满宽度，适用于列少的情况                                      | boolean             | -                    | false         |
| column-hover-highlight      | 是否显示列 hover 高亮样式                                            | boolean             | -                    | true          |
| index                       | 是否显示序号列，可传入函数自定义序号内容                              | `boolean/Function`  | -                    | true          |
| actions                     | 操作列按钮配置，参考下面 [Actions Props](#actions-props)             | TableAction[]       | -                    | []            |
| action-limit                | 操作列最多显示的按钮个数，多余的收纳到更多下拉中，0 表示全部显示      | number              | -                    | 4             |
| action-position             | 操作列固定位置                                                        | string              | left / right         | right         |
| action-max-weight           | 操作列最大宽度                                                        | number              | -                    | 180           |
| selection-mode              | 行选择模式，不传则不显示选择框                                        | string              | singleRow / multiRow | -             |
| selection-column-def        | 多选/单选列的配置                                                     | object              | -                    | -             |
| if-selection-disabled       | 行选择禁用函数，返回 true 时该行不可选                                | `(node) => boolean` | -                    | -             |
| show-disabled-checkboxes    | 是否显示禁用的选择框                                                  | boolean             | -                    | false         |
| total                       | 总行数，不填或为 0 时不显示分页                                       | number              | -                    | -             |
| current-page                | 当前页数，可通过 `v-model:current-page` 绑定                          | number              | -                    | -             |
| page-size                   | 每页显示条目个数，可通过 `v-model:page-size` 绑定                     | number              | -                    | -             |
| pagination                  | 分页配置，同 el-pagination                                            | object              | -                    | 从全局配置获取 |
| tooltip-show-mode           | 内容超长提示模式                                                      | string              | standard / whenTruncated | whenTruncated |
| tooltip-show-delay          | 内容超长悬浮多久后显示提示，单位 ms                                   | number              | -                    | 500           |
| tooltip-interaction         | 提示弹窗内容获取鼠标焦点时是否不隐藏                                  | boolean             | -                    | true          |
| suppress-column-virtualisation | 是否关闭列虚拟化                                             | boolean             | -                    | true          |
| show-download-csv           | 是否显示 CSV 下载按钮                                             | boolean             | -                    | true          |
| get-row-style               | 行样式函数或字符串函数体                                           | function/string     | -                    | -             |
| get-row-class               | 行 class 函数或字符串函数体                                         | function/string     | -                    | -             |
| has-permission               | 操作按钮权限判断函数                                               | function            | -                    | -             |
| cell-renderer                | 默认单元格渲染器                                                   | object              | -                    | -             |

**支持 `ag-grid` 的 [GridOptions](https://www.ag-grid.com/vue-data-grid/grid-options/) 属性**

### Column Props

除下列自定义属性外，`column-defs` 中的每一列都支持 ag-grid 的 [ColDef](https://www.ag-grid.com/vue-data-grid/column-properties/) 属性（如 `field`、`headerName`、`width`、`pinned`、`sortable`、`filter`、`cellStyle`、`cellClass`、`tooltipField`、`cellRenderer` 等）。

| Name                    | Description                                                                       | Type                | Options | Default |
| ----------------------- | --------------------------------------------------------------------------------- | ------------------- | ------- | ------- |
| field                   | 对应 `row-data` 的字段名，支持 `a.b.c` 多级取值                                   | string              | -       | -       |
| headerName              | 列头文本，支持 HTML 标签                                                           | string              | -       | -       |
| slot                    | 是否使用插槽渲染该列，插槽名为 `column-[field]`，优先级最高                        | boolean             | -       | false   |
| wrap-header-text        | 表头文本是否自动换行                                                               | boolean             | -       | true    |
| wrap-text               | 是否显示完整内容并自动换行，默认超长显示省略号                                    | boolean             | -       | false   |
| enum-type               | 是否为枚举值，`tagType` 不为空时会包装成 `n-tag` 样式                             | boolean             | -       | -       |
| enum-type-field         | 枚举值字段名称，支持 `a.b.c` 多级                                                | string              | -       | desc    |
| time-format             | 是否格式化时间，为 `true` 时按默认格式，传字符串时按该格式格式化                  | `boolean/string`    | -       | -       |
| render                  | 字符串形式的渲染函数体，返回文本或 HTML 字符串，可用参数 `context` / `row` / `index` | string           | -       | -       |
| render-header           | 字符串形式的表头渲染函数体，用法同 `render`                                       | string              | -       | -       |
| jump                    | 是否显示为可点击的跳转链接                                                         | boolean             | -       | -       |
| jump-router-params      | 跳转路由参数，支持 `${}` 占位符从行数据取值                                       | RouteLocationRaw    | -       | -       |
| jump-auth               | 跳转路由权限，多个用英文逗号隔开                                                   | string              | -       | -       |
| if-disabled-jump        | 禁用跳转的函数，返回 true 时禁用                                                   | `(value, data) => boolean` | -  | -       |
| if-disabled-jump-render | 字符串形式的禁用跳转函数，返回 true / false                                       | string              | -       | -       |

### Actions Props

| Name       | Description                            | Type                                              | Options                                        | Default |
| ---------- | -------------------------------------- | ------------------------------------------------- | ---------------------------------------------- | ------- |
| label      | 按钮文字                               | string                                            | -                                              | -       |
| type       | 按钮类型                               | string                                            | primary / success / warning / danger / info    | -       |
| show       | 是否显示按钮                           | boolean                                           | -                                              | true    |
| if-show    | 动态控制是否显示按钮                   | `(scope: { row, column, $index }) => boolean`     | -                                              | -       |
| text       | 是否为文字按钮                         | boolean                                           | -                                              | true    |
| bg         | 是否显示文字按钮背景色                 | boolean                                           | -                                              | -       |
| icon       | 按钮图标，需要 `@element-plus/icons` 支持 | Component                                       | -                                              | -       |
| class-name | 按钮类样式                             | string                                            | -                                              | -       |
| click      | 点击事件                               | `(scope: { row, column, $index }) => void`        | -                                              | -       |

## Events

| Name               | Description                                | Parameters                       |
| ------------------ | ------------------------------------------ | -------------------------------- |
| grid-ready         | 表格初始化完成时触发                       | GridReadyEvent                   |
| cell-double-clicked | 双击单元格时触发                          | CellDoubleClickedEvent           |
| selection-changed  | 选中行改变时触发                           | selectedRows, SelectionChangedEvent |
| column-moved       | 列移动位置时触发                           | ColumnMovedEvent                 |
| column-resized     | 拖拽改变列宽时触发                         | ColumnResizedEvent               |
| column-visible     | 列显隐改变时触发                           | ColumnVisibleEvent               |
| column-pinned      | 列固定左右侧改变时触发                     | ColumnPinnedEvent                |
| column-defs-change | 列宽、固定、显隐等改变时触发，可用于持久化列配置 | `ColumnDefsChangeEvent[]`     |
| size-change        | pageSize 改变时触发                        | 每页条数                         |
| current-change     | currentPage 改变时触发                     | 当前页                           |

## Methods

通过 `ref` 获取组件实例，或使用 `useVtable` 辅助函数拿到实例方法。

| Name            | Description              | Parameters | Returns          |
| --------------- | ------------------------ | ---------- | ---------------- |
| getIntance      | 获取 ag-grid 表格 API 实例 | -        | GridApi          |
| getSelectedRows | 获取所有选中行数据       | -          | 选中行数组       |

## Slots

| Name            | Description                                                     |
| --------------- | -------------------------------------------------------------- |
| index           | 自定义序号列内容，参数为 `{ params, index }`                    |
| column-[field]  | 当列配置 `slot: true` 时该列的内容，参数为 `{ data, index }`    |
| pagination      | 分页栏左侧内容                                                  |

::: tip 提示

`[field]` 为列配置中定义的 `field`

:::

## TypeScript 定义

```ts
export declare function defineVtableColumns<T>(columns: Column<T>[]): Column<T>[]
export declare function defineVtableActions<T>(actions: TableAction<T>[]): TableAction<T>[]
export declare function defineVtableProps<T>(props: VTableProps<T>): VTableProps<T>
export declare function useVtable<T = any>(): {
  tableRef: ShallowRef<VtableExport<T>>
  getSelectedRows: () => T[]
  getIntance: () => VtableApi
}
```
