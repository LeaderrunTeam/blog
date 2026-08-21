---
title: 组件总览
meta:
  - name: description
    content: element-next 组件清单与注册方式
---

# 组件总览

当前 `element-next` 版本（`1.57.x`）的组件按功能分为以下几组。完整引入时使用 `app.use(ElementNext)`；按需引入时使用各页面文档中的 `N*` 导出并单独注册。

## 基础组件

| 组件 | 注册名 | 说明 | 文档 |
| --- | --- | --- | --- |
| `NButton` | `n-button` | 基于 `ElButton` 增加点击节流 | [Button](./button) |
| `NCard` | `n-card` | 标题、折叠、辅助提示和卡片模式 | [Card](./card) |
| `NIcon` | `n-icon` | Element Plus 与 SVG 图标统一封装 | [Icon](./icon) |
| `NLink` | `n-link` | 自动识别外部链接和路由链接 | [Link](./link) |
| `NLazy` | `n-lazy` | 延迟创建内容 | [Lazy](./lazy) |
| `NText` | `n-text` | 文本复制与 `ElText` 能力 | [Text](./text) |
| `NTag` | `n-tag` | 扩展标签颜色类型 | [Tag](./tag) |
| `NTip` | `n-tip` | 带图标的提示信息 | [Tip](./tip) |
| `NWrap` | `n-wrap` | 加载骨架与底部区域容器 | [Wrap](./wrap) |

## 表单组件

| 组件 | 注册名 | 说明 | 文档 |
| --- | --- | --- | --- |
| `NInput` | `n-input` | 输入格式化、空格清理和回车事件 | [Input](./input) |
| `NAutocomplete` | `n-autocomplete` | 本地/远程自动完成及字段回填 | [Autocomplete](./autocomplete) |
| `NSelect` | `n-select` | 配置化选项、远程数据和虚拟列表 | [Select](./select) |
| `NTreeSelect` | `n-tree-select` | 树形数据选择与远程加载 | [TreeSelect](./tree-select) |
| `NDatePicker` | `n-date-picker` | 快捷范围、最小/最大可选天数 | [DatePicker](./date-prick) |
| `NRadio` / `NRadioButton` | `n-radio` / `n-radio-button` | 配置化单选及按钮样式 | [Radio](./radio) |
| `NCheckbox` / `NCheckboxButton` | `n-checkbox` / `n-checkbox-button` | 配置化多选及按钮样式 | [Checkbox](./checkbox) |
| `NDropdownSelect` | `n-dropdown-select` | 下拉菜单与选择值组合 | [DropdownSelect](./dropdown-select) |
| `NForm` | `n-form` | 配置化表单、校验与动态布局 | [Form](./form) |
| `NLov` | `n-lov` | 弹窗查询选择并回填表单 | [Lov](./lov) |

## 数据展示与业务组件

| 组件 | 注册名 | 说明 | 文档 |
| --- | --- | --- | --- |
| `NTable` | `n-table` | 配置化列、编辑行和操作列 | [Table](./table) |
| `NTableForm` | `n-table-form` | 查询表单与表格组合 | [TableForm](./table-form) |
| `NVtable` | `n-vtable` | 支持虚拟滚动的大数据表格 | [Vtable](./vtable) |
| `NVtableForm` | `n-vtable-form` | 查询表单与虚拟表格组合 | [VTableForm](./vtable-form) |
| `NDescriptions` | `n-descriptions` | 配置化详情描述 | [Descriptions](./description) |
| `NDialog` / `NDialogForm` | `n-dialog` / `n-dialog-form` | 弹窗与弹窗表单 | [Dialog](./dialog) / [DialogForm](./dialog-form) |
| `NStatusFlow` | `n-status-flow` | 状态流程展示 | [StatusFlow](./status-flow) |
| `NRelativeTime` | `n-relative-time` | 相对时间、日期和时间戳 | [RelativeTime](./relative-time) |
| `NTour` | `n-tour` | 配置化页面引导 | [Tour](./tour) |
| `NTinymce` | `n-tinymce` | TinyMCE 富文本编辑器 | [Tinymce](./tinymce) |

## 导出与版本提示

- `CountTo`、`DragVerify` 目录仍保留在源码中，但当前 `components.ts` 未将它们加入默认安装列表，文档仅作为历史版本参考，不建议在新项目中使用。
- `NLink` 在源码中有独立插件实现；发布前请确认它已加入 `components.ts` 的默认安装列表。若当前版本未导出组件本身，请使用源码路径导入或等待下一版本修复。
- 所有增强组件都会透传对应 Element Plus 组件的原生属性、事件和插槽；本页只列出新增能力，完整原生 API 请以 Element Plus 官方文档为准。

## 自定义属性完整索引

下面列出源码 `props` 中由 `element-next` 新增或自行实现的全部属性。属性名按 Vue 模板中的 kebab-case 书写；`Element Plus` 原生属性仍由对应组件继续透传。

| 组件 | 自定义属性（默认值） |
| --- | --- |
| `NAutocomplete` | `form`、`binding-key`、`remote-search(false)`、`remote-search-field-key`、`display-key`、`search-key`、`limit(50)`、`seq`、`value-key(value)`；另有 `data`、`config`、`remote-config` |
| `NButton` | `debounce(300)` |
| `NCard` | `card(false)`、`border(false)`、`shadow(false)`、`folding(false)`、`title`、`show-helper(false)`、`placement(top-start)`、`helper-message`、`class-name` |
| `NCheckbox` / `NCheckboxButton` | `data([])`、`config`、`remote-config`、`min`、`max`，以及 Element Plus 复选框属性 |
| `NDatePicker` | `default-range(0)`、`show-fast(false)`、`max(0)`、`min(0)`、`seq` |
| `NDescriptions` | `card-border(false)`、`shadow(false)`、`folding(false)`、`is-card(true)`、`groups([])`、`data`、`class-name`、`label-class-name` |
| `NDialog` | `overflow(true)`、`align-center(true)`、`draggable(true)`、`show-full-screen(true)`、`cancel-close(true)`、`fixed-height(false)`、`confirm-props`、`cancel-props`、`loading(false)`、`helper-message`、`auto-width(true)`、`width-config` |
| `NDialogForm` | `visible(false)`、`form-props`、`dialog-props`、`submit-on-validate(true)`、`close-reset(true)` |
| `NDropdownSelect` | `data([])`、`config`、`multiple(true)`、`disabled(false)`、`truncated(true)`、`line-clamp`、`placement(left)`、`trigger(click)`、`placeholder(请选择)`、`label-style(max-width: 100px)` |
| `NForm` | `fields([])`、`action({ submit: true, reset: true })`、`gutter`、`justify`、`align`、`enter-on-submit(false)`、`first-auto-focus(true)`、`show-more(false)`、`loading(false)`、`remote-field(false)`、`limit`、`validate-on-submit(true)`、`fixed-action(false)`、`field-adaptive(false)`、`enter-next(true)`、`field-map-to-time([])`、`enter-method`、`fiexd-error-message(false)`、`readonly(false)`；同时覆盖 `label-width(90px)`、`scroll-to-error(true)` 等增强默认值 |
| `NIcon` | `prefix(icon)`、`name(必填)`、`size(14)`、`color`、`spin(false)` |
| `NInput` | `input-style`、`clearable(true)`、`format`、`trim-type(both)`、`seq` |
| `NLazy` | `time(0)`、`tag(div)` |
| `NLink` | `to` |
| `NLov` | `query-form`、`value-key`、`title`、`disabled`、`readonly`、`outside-height`、`db-click-show(true)`、`show-btn(true)`、`table-props({})`、`form-props({})`、`width(50%)` |
| `NRadio` / `NRadioButton` | `data([])`、`config`、`remote-config`、`size(small)`、`border(true)`、`disabled(false)`、`text-color`、`fill`、`to-str(false)` |
| `NSelect` | `data([])`、`config`、`remote-config`、`clearable(true)`、`filterable(true)`、`automatic-dropdown(true)`、`remote(true)`、`only-label(false)`、`display-key(['value','desc'])`、`search-key(['value','desc'])`、`virtual(false)`、`seq`、`to-str(false)`、`one-data-default(false)` |
| `NStatusFlow` | `data([])`、`current-code(必填)`、`tiled(true)`、`direction(horizontal)` |
| `NTable` | `columns([])`、`selection(false)`、`expand`、`index(true)`、`action-props`、`actions([])`、`total(0)`、`page-size`、`current-page(1)`、`pagination`、`action-limit(4)`、`show-config(false)`、`loading(false)`、`contextmenu(false)`、`editable(false)`、`selectable`，以及 `border(true)`、`highlight-current-row(true)`、`show-overflow-tooltip(true)` 等覆盖默认值 |
| `NTableForm` / `NVtableForm` | `form-props`、`table-props`、`add(true)`、`add-props({})`、`outside-height`、`loading(false)`、`enter-query(true)` |
| `NTag` | `type`（支持 `amber`、`black`、`cyan`、`green`、`grey`、`blue`、`lime`、`orange`、`pink`、`purple`、`indigo`、`teal`、`violet`、`yellow` 及 Element Plus 状态类型）、`text`、`size` |
| `NText` | `show-copy(false)` |
| `NTinymce` | `options({})`、`toolbar`、`plugins`、`lang(zh_CN)`、`height`、`min-height(600)`、`width(100%)`、`show-upload(true)`、`disabled(false)`、`toolbar-sticky(true)`、`file-max-size(0)`、`accept`、`upload` |
| `NTip` | `text`、`content`、`tag(span)`、`disabled(false)`、`raw-content(false)`、`click-enable(false)`、`size`、`model-value`、`icon`、`icon-placement(left)`、`color`、`placement` |
| `NTour` | `show-close(false)`、`close-on-press-escape(false)`、`tour-id(必填)`、`tour-once(true)`、`items([])` |
| `NTreeSelect` | `data([])`、`clearable(true)`、`filterable(true)`、`click-parent(true)`、`default-expand-all(true)`、`include-half-checked(false)`、`leaf-only(true)`、`check-strictly(true)`、`expand-on-click-node(false)`、`props`、`remote-config`、`fetch-data`、`line(true)` |
| `NVtable` | `column-hover-highlight(true)`、`suppress-column-virtualisation(true)`、`tooltip-interaction(true)`、`action-limit(4)`、`tooltip-show-delay(500)`、`tooltip-show-mode(whenTruncated)`、`show-disabled-checkboxes(false)`、`selection-mode(singleRow)`、`if-selection-disabled`、`selection-column-def`、`cell-renderer`、`border(false)`、`show-config(true)`、`show-download-csv(true)`、`column-fit(false)`、`height`、`row-data([])`、`column-defs([])`、`column-default`、`total`、`current-page`、`page-size`、`pagination`、`actions([])`、`action-max-weight(180)`、`action-position(right)`、`index(true)`、`get-row-style`、`get-row-class`、`has-permission` |
| `NWrap` | `loading(false)`、`loading-style(detail)` |
