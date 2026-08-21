---
title: Table
meta:
  - name: description
    content: 封装表格组件实现通过配置动态生成列
---

# Table

对 [ElTable](https://element-plus.gitee.io/zh-CN/component/table.html) 的增强

::: warning 提示

1. 如果你不需要动态配置或者动态显示列，那么建议你定义一个普通数组 `columns` 而不是 `ref / recative`

2. `ElementPlus`表格事件`current-change`被转换成`select-row`。单击选中行事件请用`select-row`

:::

## 使用

### 多级表头

:::demo

```vue
<template>
  <n-table
    v-model:current-page="currentPage"
    v-model:page-size="pageSize"
    :data="data3"
    :columns="columns3"
    :total="total"
    @save="doSaveColumn"
  >
    <template #pagination>
      <el-button size="mini">分页槽位</el-button>
    </template>
  </n-table>
</template>

<script>
import { ref, h } from 'vue'

export default {
  setup() {
    const currentPage = ref(1)
    const pageSize = ref(10)
    const total = ref(50)
    const columns3 = ref([
        {
            label: '多级表头',
            children: [
                 {
                    label: '日期',
                    prop: 'date',
                    timeFormat: 'YYYY-MM-DD HH:mm:ss'
                  },
                  {
                    label: '姓名',
                    prop: 'name',
                    enumType: true
                  },
            ]
      },
      {
        label: '地址',
        prop: 'address'
      },
      {
        label: '年纪',
        prop: 'age',
        render: (row) => {
          return h('span', { class: 'el-tag' }, row.age)
        }
      },
      {
        label: '身高',
        prop: 'heigh',
        showCopy: true
      },
      {
        label: '学校',
        prop: 'school',
        showHelper: true,
        helperMessage: '这是一个提示'
      }
    ])
    const data3 = ref([
      {
        date: 1637313103654,
        name: { desc: 'Tom', tagType: 'cyan' },
        address: 'No. 189, Grove St, Los Angeles',
        age: '18 岁',
        heigh: '180 CM',
        school: 'XX大学'
      },
      {
        date: 1637313103654,
        name: { desc: 'Tom' },
        address: 'No. 189, Grove St, Los Angeles',
        age: '18 岁',
        heigh: '180 CM',
        school: 'XX大学'
      },
      {
        date: 1637313103654,
        name: { desc: 'Tom' },
        address: 'No. 189, Grove St, Los Angeles',
        age: '18 岁',
        heigh: '180 CM',
        school: 'XX大学'
      },
      {
        date: 1637313103654,
        name: { desc: 'Tom' },
        address: 'No. 189, Grove St, Los Angeles',
        age: '18 岁',
        heigh: '180 CM',
        school: 'XX大学'
      }
    ])

    const doSaveColumn = (columnList, done) => {
      console.log(columnList, ' < ==========')
      columns2.value = columnList
      done()
    }

    return {
      doSaveColumn,
      currentPage,
      pageSize,
      total,
      data3,
      columns3
    }
  }
}
</script>
```

:::

### 显示分页

当传入 `total` 数据时，将自动显示分页。可以通过 `v-model:current-page` 绑定当前页数、通过 `v-model:page-size` 绑定每页显示条目个数

:::demo

```vue
<template>
  <n-table
    v-model:current-page="currentPage"
    v-model:page-size="pageSize"
    :data="data2"
    :columns="columns2"
    :total="total"
  >
    <template #pagination>
      <el-button size="mini">分页槽位</el-button>
    </template>
  </n-table>
</template>

<script>
import { ref } from 'vue'

export default {
  setup() {
    const currentPage = ref(1)
    const pageSize = ref(10)
    const total = ref(50)
    const columns2 = ref([
      {
        label: '日期',
        prop: 'date'
      },
      {
        label: '姓名',
        prop: 'name'
      },
      {
        label: '地址',
        prop: 'address'
      }
    ])
    const data2 = [
      {
        date: '2016-05-03',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      },
      {
        date: '2016-05-02',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      },
      {
        date: '2016-05-04',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      },
      {
        date: '2016-05-01',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      }
    ]

    return {
      currentPage,
      pageSize,
      total,
      data2,
      columns2
    }
  }
}
</script>
```

:::

### 定义操作按钮

- 通过`actionProps` 对操作列进行配置，支持 [columns](#columns 的参数) 的属性
- 可以通过 `#action-column` 插槽定制显示操作按钮内容，或者通过 `actions` 数组来维护你的按钮。**推荐使用后者**
- 如果你是通过 `actions` 数组来维护操作按钮，那么它支持以下这些东西
  - 设置 `action-limit` 属性来控制显示的按钮，多余的按钮会收缩到`更多`里面。
  - 设置 `text` 来控制 `el-button` 的形态，它默认是 `text`
  - 设置 `type` 来控制你的按钮颜色，支持 `primary / warning / danger / success / info` 。注意它只在 `text=true` 的时候有效
  - 设置 `icon` 来设置你的按钮图标，使按钮更加形象
  - 设置 `show` 来控制你的按钮是否显示，或者 `ifShow` 函数动态控制，它的优先级高于 `show` 属性

:::demo

```vue
<template>
  <n-table
    style="margin-top:10px"
    :data="data"
    :columns="columns"
    :actionProps="menu"
    :actions="actions"
    :actionLimit="5"
  >
  </n-table>
</template>
<script>
import { ref, markRaw } from 'vue'
export default {
  setup() {
    const menu = {
      align: 'center'
    }
    const columns = ref([
      {
        label: '日期',
        prop: 'date'
      },
      {
        label: '姓名',
        prop: 'name'
      },
      {
        label: '地址',
        prop: 'address'
      }
    ])
    const data = ref([
      {
        date: '2016-05-03',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      },
      {
        date: '2016-05-02',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      },
      {
        date: '2016-05-04',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      },
      {
        date: '2016-05-01',
        name: 'Tom',
        address: 'No. 189, Grove St, Los Angeles'
      }
    ])

    const actions = [
      {
        label: '成功',
        type: 'success'
      },
      {
        label: '警告',
        type: 'warning'
      },
      {
        label: '主题',
        type: 'primary'
      },
      {
        label: '危险',
        type: 'danger'
      },
      {
        label: '默认'
      },
      {
        label: '默认2',
        click(scope) {
          console.log('click --------->', scope)
        }
      },
      {
        label: '危险',
        type: 'danger',
        show: false,
        ifShow(scope) {
          return true
        },
        click(scope) {
          console.log('click --------->', scope)
        }
      },
      {
        label: '成功2',
        type: 'success'
      },
      {
        label: '警告2',
        type: 'warning'
      },
      {
        label: '主色2',
        type: 'primary'
      }
    ]
    return {
      menu,
      data,
      actions,
      columns
    }
  }
}
</script>
```

:::

### 拓展示例

详细配置可展开代码，示例功能包含如下：

- 一个列显示多级数据，中间为空的时候会空行占位
- 显示 tag 标签， tagType 可以参考 NTag
- 自定义颜色和表头显示提示语
- 显示复制按钮
- 使用字符串函数渲染
- 图片列

:::demo

```vue
<template>
  <n-table
    v-model:current-page="currentPage"
    :data="data3"
    :show-config="true"
    :contextmenu="true"
    :columns="columns"
    :total="total"
    :actions="actions"
    :action-props="{ fixed: 'right', width: '290px' }"
    @column-change="doSaveColumn"
  >
    <template #pagination>
      <el-button> 分页槽位 </el-button>
    </template>
  </n-table>
</template>

<script>
import { ref, h } from 'vue'

export default {
  setup() {
    const currentPage = ref(1)
    const pageSize = ref(10)
    const total = ref(50)
    const columns = ref([])
    const actions = [
      {
        label: '删除2s还是说',
        type: 'warning',
        click: (d) => {
          console.log('d :>> ', d)
          console.log('d :>> ', d.row.heigh)
        }
      },
      {
        label: '删除1',
        show: false
      },

      {
        label: '删除3',
        ifShow({ row }) {
          const b = new Date().getTime() % 2 === 0
          console.log('b :>> ', b)
          return b
        }
      },

      {
        label: '删除5'
      },

      {
        label: '删除6'
      }
    ]
    const columns3 = ref([
      {
        // 一个列显示多级数据，中间为空的时候会空行占位
        label: ['日期', '身高', '年纪'],
        prop: [
          {
            prop: 'date',
            timeFormat: 'YYYY-MM-DD HH:mm:ss'
          },
          {
            prop: 'heigh2'
          },
          {
            prop: 'age'
          }
        ]
      },
      {
        // 显示枚举， tagType可以参考NTag
        label: '姓名',
        prop: 'name',
        enumType: true
      },
      // 自定义颜色和表头显示提示语
      {
        label: '地址',
        prop: 'address',
        color: '#f90',
        showHelper: true,
        helperMessage: '这是一个提示'
      },
      // 显示复制按钮
      {
        label: '年纪',
        prop: 'age',
        showCopy: true
      },
      {
        label: '图片',
        prop: 'image',
        image: true,
        imageStyle: { width: '32px' }
      },
      // 使用字符串函数渲染
      {
        label: '学校',
        prop: 'school',
        render:
          "{const  heigh  = row.heigh; if (heigh >= 180) { return h('span', { class: 'el-tag' }, heigh); } else if (heigh >= 170) { return h('span', { class: 'el-tag el-tag--warning' }, heigh); } else if (heigh >= 160) { return h('el-tag', {  class: 'el-tag el-tag--success' }, heigh); } }"
      }
    ])
    const data3 = [
      {
        date: 1677662712863,
        address: 'No. 189, Grove St, Los Angeles',
        age: '18 岁',
        heigh: 150,
        school: 'XX大学',
        image: 'http://docs.seedltd.cn/logo.svg',
        name: { value: 1, desc: '张三', tagType: 'success' }
      }
    ]

    columns.value = columns3

    const doSaveColumn = (columnList, done) => {
      setTimeout(() => {
        columns3.value = columnList
        done()
      }, 2000)
    }

    return {
      actions,
      doSaveColumn,
      currentPage,
      pageSize,
      total,
      data3,
      columns: columns.value
    }
  }
}
</script>
```

:::

### 行内编辑

开启 `editable` 后，配置了 `edit` 的列在编辑状态下会渲染编辑器。表格会自动注入 `编辑 / 保存 / 取消 / 删除` 行操作按钮以及底部 `新增` 按钮，并在保存 / 删除时通过事件回调交给你处理持久化。

- `edit: true` 使用默认输入框 `n-input`；传入对象可自定义编辑器组件、属性与校验规则。
- 校验依赖 `edit.rules`，只有配置了规则的列才会在保存前校验。
- `新增` 会向 `data` 追加一行并进入编辑；`取消` 未保存的新增行会自动移除。

编辑相关的动作都会通过事件发送给你处理：`row-add`（新增）、`row-save`（保存）、`row-cancel`（取消）、`row-delete`（删除）。其中 `row-save`、`row-delete` 带 `done` 回调，业务处理（如调接口）完成后调用 `done()` 完成、`done(false)` 中断。除了内置按钮，也可以通过 `ref` 调用 `addRow / editRow / saveRow / cancelRow / deleteRow` 主动操作。

::: warning 提示

`新增 / 删除` 会直接就地修改传入的 `data` 数组（`push / splice`），请确保 `data` 是响应式的（`ref / reactive`）。`row-save`、`row-delete` 的 `done` 回调传入 `false` 时不会退出编辑 / 不会移除行。

:::

:::demo

```vue
<template>
  <div>
    <div style="margin-bottom: 12px">
      <!-- 通过 ref 调用暴露的方法主动操作 -->
      <n-button type="primary" @click="onInsert">插入一行（addRow）</n-button>
      <n-button @click="onEditFirst">编辑第一行（editRow）</n-button>
    </div>
    <n-table
      ref="tableRef"
      :data="data"
      :columns="columns"
      editable
      :action-props="{ width: 220 }"
      @row-add="onAdd"
      @row-save="onSave"
      @row-cancel="onCancel"
      @row-delete="onDelete"
    />
  </div>
</template>

<script>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'

export default {
  setup() {
    const tableRef = ref()

    const columns = ref([
      {
        label: '姓名',
        prop: 'name',
        edit: true
      },
      {
        label: '年龄',
        prop: 'age',
        edit: {
          component: 'n-input',
          props: { type: 'number' },
          rules: { required: true, message: '请输入年龄', trigger: 'blur' }
        }
      },
      {
        label: '性别',
        prop: 'sex',
        enumType: true,
        enumDescName: 'label',
        edit: {
          component: 'n-select',
          props: {
            data: [
              { label: '男', value: 1 },
              { label: '女', value: 2 }
            ]
          }
        }
      }
    ])

    const data = ref([
      { name: '张三', age: 18, sex: { value: 1, label: '男' } },
      { name: '李四', age: 20, sex: { value: 2, label: '女' } }
    ])

    // 新增：点击底部"新增"按钮或调用 addRow 后触发
    const onAdd = (row) => {
      console.log('row-add', row)
    }

    // 保存：校验通过后触发。row 当前行，done 保存回调，isAdd 是否为新增行
    const onSave = (row, done, isAdd) => {
      // 模拟异步保存接口
      setTimeout(() => {
        if (!row.name) {
          ElMessage.error('姓名不能为空')
          done(false) // 保存失败，保持编辑态
          return
        }
        ElMessage.success(isAdd ? '新增成功' : '保存成功')
        done() // 完成，退出编辑
      }, 300)
    }

    // 取消：数据已还原（未保存的新增行已自动移除）
    const onCancel = (row) => {
      console.log('row-cancel', row)
    }

    // 删除：done() 从 data 移除该行，done(false) 不移除
    const onDelete = (row, done) => {
      setTimeout(() => {
        ElMessage.success('删除成功')
        done()
      }, 300)
    }

    // 通过 ref 主动新增一行并进入编辑
    const onInsert = () => {
      tableRef.value.addRow({ name: '新用户', age: 0 })
    }

    // 通过 ref 让第一行进入编辑
    const onEditFirst = () => {
      if (data.value[0]) {
        tableRef.value.editRow(data.value[0])
      }
    }

    return {
      tableRef,
      columns,
      data,
      onAdd,
      onSave,
      onCancel,
      onDelete,
      onInsert,
      onEditFirst
    }
  }
}
</script>
```

:::

## Props

| Name                  | Description                                                                                                                            | Type             | Options | Default          |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ---------------- | ------- | ---------------- |
| data                  | 显示的数据                                                                                                                             | array            | -       | -                |
| columns               | 自动生成表单的参数，参考下面 [columns](#columns-props)                                                                                 | array            | -       | -                |
| selection             | 显示多选框，支持 `columns` 的属性                                                                                                      | boolean / object | -       | false            |
| index                 | 显示索引，支持 `columns` 的属性                                                                                                        | boolean / object / function | - | true |
| expand                | 开启展开插槽，支持 `columns` 的属性                                                                                                    | boolean / object | -       | -                |
| action-props          | 操作列属性配置，参考：[el-table-column](https://element-plus.gitee.io/zh-CN/component/table.html#table-column-%E5%B1%9E%E6%80%A7) 属性 | object           | -       | -                |
| actions               | 操作列每一行业务按钮配置，参考下面 [actions](#actions-props) 的配置                                                                    | array            | -       | -                |
| action-limit          | 数据行操作按钮最多显示多少个按钮，多余的放到更多下拉按钮中。0 全部显示不放更多里面                                                     | number           | -       | 4                |
| show-config           | 是否显示自定义列                                                                                                                       | boolean          | -       | false            |
| loading               | 是否显示 loading                                                                                                                       | boolean          | -       | false            |
| total                 | 总条目数                                                                                                                               | number           | -       | -                |
| current-page          | 当前页数，可以通过 `v-model:current-page` 绑定值                                                                                       | number           | -       | -                |
| page-size             | 每页显示条目个数，可以通过 `v-model:page-size` 绑定值                                                                                  | number           | -       | -                |
| pagination            | pagination 的配置，同 el-pagination                                                                                                    | object           | -       | 从全局配置中获取 |
| show-overflow-tooltip | 当内容过长被隐藏时显示 tooltip                                                                                                         | boolean          | -       | true             |
| highlight-current-row | 是否要高亮当前行                                                                                                                       | boolean          | -       | true             |
| contextmenu           | 是否通过右键菜单显示操作按钮                                                                                                           | boolean          | -       | false            |
| editable              | 是否开启行内编辑，需配合列的 `edit` 配置使用，参考 [行内编辑](#行内编辑)                                                               | boolean          | -       | false            |
| border                | 是否显示表格边框                                                                                                                       | boolean          | -       | true             |
| highlight-current-row | 是否高亮当前行                                                                                                                         | boolean          | -       | true             |
| selectable            | 判断当前行是否可勾选的函数                                                                                                             | function         | -       | -                |

`NTable` 还透传 `ElTable` 的全部原生属性。上表列出的是组件增强属性及其覆盖的默认值。

**支持 `element-plus` [表格属性](https://element-plus.gitee.io/zh-CN/component/table.html#table-%E5%B1%9E%E6%80%A7)**

### Columns Props

| Name                  | Description                                                  | Type                            | Options | Default           |
| --------------------- | ------------------------------------------------------------ | ------------------------------- | ------- | ----------------- |
| prop                  | 对应 `data` 的字段名。支持获取`a.b`路径相应的值。支持多字段取值，通过换行形式显示 | `string/TableColumn[]`          | -       | -                 |
| label                 | 列头文本，传入数组换行显示                                   | `string/string[]`               | -       | -                 |
| render                | 自定义渲染内容。支持[字符串函数](../../web/faq/component.md#字符串函数)，参数：_row: 行数据，h：渲染函数需要返回这个对象，index：下标_ | Function(row,index):VNode       | -       | -                 |
| `show-helper`         | 是否显示提示图标，自定义头部插槽的时候无效                   | boolean                         | -       | false             |
| `helper-message`      | 提示内容，`show-helper`为真的时候有效                        | `string/string[]`               | -       | -                 |
| children              | 多级表头下的子项                                             | TableColumn[]                   | -       | -                 |
| `time-format`         | 日期格式化，如果为 true 按`YYYY-MM-DD HH:mm:ss`格式化时间。不为空的时候则根据其值格式化时间。参考：[dayjs 格式化](https://dayjs.fenxianglu.cn/category/display.html#%E6%A0%BC%E5%BC%8F%E5%8C%96) | `string/boolean`                | -       | -                 |
| `enum-type`           | 是否枚举类型。如果为`true`格式必须是`json`对象，并且必须包含`[enumDescName]`字段 | boolean                         | -       | false             |
| `enum-desc-name`      | 枚举 label 字段名称                                          | string                          | -       | desc              |
| `tag-type-name`       | 枚举状态类型字段名称。值内容参考`Tag`组件。如果`enumType=true`并且该字段不是空的时候显示`Ntag`组件，类型就是`tagTypeName`的值。适用于数据状态 | string                          | -       | tagType           |
| image                 | 是否显示图片组件                                             | boolean                         | -       | true              |
| `image-style`         | 图片样式                                                     | `Record<string, string>/string` | -       | `'width: "60px"'` |
| `image-src-list-prop` | 预览图片路径集合的属性                                       | string                          | -       | -                 |
| show                  | 是否显示列                                                   | boolean                         | -       | true              |
| color                 | 16 进制文本颜色                                              | string                          | -       | -                 |
| ifColor               | 动态返回 16 进制文本颜色                                     | `(row, index) => string`        | -       | -                 |
| showCopy              | 是否文本可以拷贝。需要注意：如果是用了render或者插槽渲染并且要拷贝文本，默认会拷贝列的所有文本，如果你只想拷贝指定内容，可以在根节点设置属性`data-copy`等于你要拷贝的值，或者要拷贝的值放在第一个元素，默认会取第一个元素的文本 | boolean                         | -       | false             |
| router                | 路由配置，会显示可点击蓝色字体。可以自定义点击事件           | `TableColumnRouter`             | -       | -                 |
| edit                  | 行内编辑配置，需配合表格 `editable` 使用。为 `true` 时使用默认输入框，或传入对象自定义，参考下面 [Edit Props](#edit-props) | `boolean/TableColumnEdit`       | -       | -                 |

**除 `formatter` 属性不支持之外，支持全部 `element-plus` [表格列属性](https://element-plus.gitee.io/zh-CN/component/table.html#table-column-%E5%B1%9E%E6%80%A7)**

### Edit Props

| Name         | Description                                                        | Type                          | Options | Default   |
| ------------ | ----------------------------------------------------------------- | ----------------------------- | ------- | --------- |
| component    | 编辑器组件，支持组件名（如 `n-input`、`n-select`）或组件对象       | `string/Component`            | -       | `n-input` |
| props        | 传给编辑器组件的属性                                              | object                        | -       | -         |
| slots        | 编辑器组件的插槽                                                  | object                        | -       | -         |
| rules        | 校验规则，同 `el-form-item` 的 `rules`                            | `FormItemRule/FormItemRule[]` | -       | -         |
| defaultValue | 新增行时该字段的默认值                                            | any                           | -       | -         |

### TableColumnRouter Props

| Name   | Description              | Type                                      | Options | Default |
| ------ | ------------------------ | ----------------------------------------- | ------- | ------- |
| show   | 是否显示可点连接         | boolean                                   | -       | false   |
| ifShow | 动态控制是否可以点击连接 | `(row: T, index: number) => boolean`      | -       | -       |
| click  | 点击回调                 | `click?: (row: T, index: number) => void` | -       | -       |

### Actions Props

| Name       | Description                                   | Type                  | Options                                        | Default |
| ---------- | --------------------------------------------- | --------------------- | ---------------------------------------------- | ------- |
| type       | 按钮类型                                      | string                | `primary / success / warning / danger / info ` | -       |
| show       | 是否显示按钮                                  | boolean               | -                                              | true    |
| if-show    | 动态控制是否显示按钮                          | function(row):boolean | -                                              | -       |
| text       | 是否为文字按钮                                | boolean               | -                                              | true    |
| bg         | 是否显示文字按钮背景颜色                      | boolean               | -                                              | false   |
| label      | 按钮文字                                      | string                | -                                              | -       |
| icon       | 按钮图标，需要`@element-puls/icons`支持的图标 | Component             | -                                              | -       |
| class-name | 按钮类样式                                    | string                | -                                              | -       |
| click      | 点击事件                                      | function(row):void    | -                                              | -       |

## Events

| Name           | Description                                                                                                                                                                                 | Parameters                |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| size-change    | pageSize 改变时会触发                                                                                                                                                                       | 每页条数                  |
| current-change | currentPage 改变时会触发                                                                                                                                                                    | 当前页                    |
| prev-click     | 用户点击上一页按钮改变当前页后触发                                                                                                                                                          | 当前页                    |
| next-click     | 用户点击下一页按钮改变当前页后触发                                                                                                                                                          | 当前页                    |
| column-change  | 用户点击保存自定义列的时候触发，其中 `done` 函数可以关闭 `loading` 状态和弹窗，如果传入 `false` 只关闭 `loading`，不关闭弹窗。拿到 `columns` 属性之后你需要重置旧的属性值以达到改变列的状态 | `function(columns, done)` |
| row-add        | 开启 `editable` 后点击底部新增按钮或调用 `addRow` 时触发                                                                                                                                    | `function(row)`           |
| row-save       | 点击行内编辑的保存按钮时触发（校验通过后）。`done()` 退出编辑，`done(false)` 保持编辑态；`isAdd` 表示是否为新增行                                                                             | `function(row, done, isAdd)` |
| row-cancel     | 点击行内编辑的取消按钮时触发，数据已还原（新增行已移除）                                                                                                                                    | `function(row)`           |
| row-delete     | 点击行内编辑的删除按钮或调用 `deleteRow` 时触发。`done()` 从 `data` 中移除该行，`done(false)` 不移除                                                                                         | `function(row, done)`     |

**[el-table 事件](https://element-plus.gitee.io/zh-CN/component/table.html#table-%E4%BA%8B%E4%BB%B6)**

## Methods

| Name               | Description                                                                                                     | Parameters                  |
| :----------------- | :-------------------------------------------------------------------------------------------------------------- | :-------------------------- |
| clearSelection     | 用于多选表格，清空用户的选择                                                                                    | —                           |
| toggleRowSelection | 用于多选表格，切换某一行的选中状态， 如果使用了第二个参数，则是设置这一行选中与否（selected 为 true 则选中）    | row, selected               |
| toggleAllSelection | 用于多选表格，切换全选和全不选                                                                                  | —                           |
| toggleRowExpansion | 用于可扩展的表格或树表格，如果某行被扩展，则切换。 使用第二个参数，您可以直接设置该行应该被扩展或折叠。         | row, expanded               |
| setCurrentRow      | 用于单选表格，设定某一行为选中行， 如果调用时不加参数，则会取消目前高亮行的选中状态。                           | row                         |
| clearSort          | 用于清空排序条件，数据会恢复成未排序的状态                                                                      | —                           |
| clearFilter        | 传入由`columnKey` 组成的数组以清除指定列的过滤条件。 不传入参数时用于清空所有过滤条件，数据会恢复成未过滤的状态 | columnKeys                  |
| doLayout           | 对 Table 进行重新布局。 当 Table 或其祖先元素由隐藏切换为显示时，可能需要调用此方法                             | —                           |
| sort               | 手动对 Table 进行排序。 参数 `prop` 属性指定排序列，`order` 指定排序顺序。                                      | prop: string, order: string |
| addRow             | 新增一行并进入编辑状态，可传入初始行数据，返回新增的行（需开启 `editable`）                                     | raw?: object                |
| editRow            | 让某一行进入编辑状态                                                                                            | row                         |
| saveRow            | 保存某一行的编辑（会先校验），触发 `row-save` 事件                                                              | row                         |
| cancelRow          | 取消某一行的编辑并还原数据，触发 `row-cancel` 事件                                                              | row                         |
| deleteRow          | 删除某一行，触发 `row-delete` 事件                                                                              | row                         |
| isEditing          | 判断某一行是否处于编辑状态                                                                                      | row                         |

**[el-table 方法](https://element-plus.gitee.io/zh-CN/component/table.html#table-%E6%96%B9%E6%B3%95)**

::: tip 提示

如果使用 `typescript` 可以从组件中导出 `TableExpose` 提供更好的类型推导

:::

```vue
<template>
  <n-table ref="tableRef" xxx />
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import type { TableExpose } from 'element-next'

const tableRef = ref<TableExpose>({} as TableExpose)
// ...
</script>
```

## Slots

| name          | Description                                                |
| ------------- | ---------------------------------------------------------- |
| action-column | 表格右侧自定义按钮，参数为 `{ size, row, column, $index }` |
| expand        | 当前这列展开显示的内容，参数为 `{ row, column, $index }`   |
| append        | 插入至表格最后一行之后的内容                               |
| pagination    | 分页栏左侧内容                                             |
| [prop]-column | 当前这列的内容，参数为 `{ size, row, column, $index }`     |
| [prop]-header | 当前这列表头的内容，参数为 `{ size, column, $index }`      |

::: tip 提示

[prop] 为 columns 中定义的 prop

:::

## TypeScript 定义

```ts
export declare const defineTableMethod: () => Ref<TableExpose>
export declare function defineTableColumns<T = ExternalParam>(
  columns: TableColumns<T>
): TableColumns<T>
export declare function defineTableActions<T = ExternalParam, C = ExternalParam>(
  actions: TableActions<T, C>
): TableActions<T, C>
```
