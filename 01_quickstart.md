# 快速入门（QUICKSTART）
## TYPESCRIPT

## 有关Angular的一些基础知识的简介

Angular 应用都是由一系列组件（components）构成的。这里说的组件，指的是一个HTML模板与一个控制屏幕的某个部分的组件类的组合（the combinaiton of an HTML template and a component that controls a portion of the screen，*译者注*：这与Angular 1.x 中的指令有某种类似之处）。下面就是一个显示简单字符串的组件示例：

```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`
})

export class AppComponent { name = 'Angular'; }
```

> 在无需安装任何npm模块的情况下，可尝试[Plunker上的这个QuickStart示例](https://angular.io/resources/live-examples/quickstart/ts/eplnkr.html)。或是在本地尝试这个[QuickStart种子](https://angular.io/docs/ts/latest/guide/setup.html), 并以此来完成一个真实Angular应用的开发准备。

所有组件都以`@Component`装饰器函数开头，该函数将取得一个*元数据*对象（a *metadata* object）。该元数据对象描述了组件的HTML模板与组件类如何一起运作。

组件类的`selector`属性令到Angular将该组件显示在一个`index.html`中的定制`<my-app>`标记内部。

```html
<my-app>Loading AppComponent content here ...</my-app>
```

这里`template`属性，定义了在`<h1>`头部中的一条消息。消息以"Hello"开始，以一个Angular[差值绑定（interpolation binding）](https://angular.io/docs/ts/latest/guide/displaying-data.html)表达式`{{name}}`结束。在运行时，Angular以组件的`name`属性值，对`{{name}}`加以替换。差值绑定是你将在本文档中发现到的许多Angular特性之一。

请将示例中组件类的`name`属性从`Angular`修改为`World`，看看会发生什么。

> **TypeScript**简介
> 此示例是以[TypeScript](http://www.typescriptlang.org/)编写的，TypeScript是JavaScript的超集。Angular选择TypeScript是因为其类型特性，类型工具易于支持开发者的生产力。同样可以JavaScript方式编写Angular; [这个教程](https://angular.io/docs/ts/latest/cookbook/ts-to-js.html)对此有解说。

