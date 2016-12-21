# 快速入门（QUICKSTART）
## TYPESCRIPT

## 有关Angular的一些基础知识的简介

Angular 应用都是由一系列组件（components）构成的。这里说的组件，指的是一个HTML模板与一个控制屏幕的某一块的组件类的组合（the combinaiton of an HTML template and a component that controls a portion of the screen，*译者注*：这与Angular 1.x 中的指令有某种类似之处）。下面就是一个显示简单字符串的组件示例：

```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`
})

export class AppComponent { name = 'Angular'; }
```
