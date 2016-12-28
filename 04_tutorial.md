# 教程：英雄之旅

此英雄之旅教程，将引导你走过以TypeScript, 建立一个Angular应用的各个步骤。

此教程的大目标，就是构建一个应用，来帮助人力资源机构，管理其签约英雄。就算英雄也需要找到工作呀。

在本教程中，当然只会取得一点点进步。但这里所构建的应用，将包含在一个成熟的、数据驱动的应用中，所期望能找到的众多特性：英雄列表的获取及现实、编辑所选定英雄的信息，以及在英雄数据的不同视图之间的导航。

英雄之旅涵盖了Angular的一些核心基础知识点。
+ 这里将用到一些内建的指令（built-in directives），来显示或隐藏页面元素，以及英雄数据清单的显示。
+ 将建立一个组件来现实英雄详细信息，并建立另一个组件，来显示一个英雄的数组（an array of heroes）。
+ 对于那些只读数据（read-only data）, 这里将使用单项数据绑定（one-way data binding）。
+ 将加入可编辑字段，来对带有双向数据绑定的某个模型加以更新（add editable fields to update a model with two-way data binding）。
+ 这里将把一些组件方法，绑定到注入按键及鼠标点击这样的用户事件（bind component methods to user events like key strokes and clicks）。
+ 将学习从某个主清单中选择一个英雄，并在详情视图中加以编辑（learn to select a hero from a master list and edit that hero in the details view）。
+ 将使用管道对数据进行格式化操作（format data with pipes）。将建立一个共享服务，来对这些英雄加以集合（create a shared service to assemble our heroes）。
+ 还将使用路由在不同视图及其组件之间进行导航（use routing to navigate among different views and their components）。

这里将学习到足够的Angular核心知识，以开始Angular应用的编写，并获取到可令Angular实现我们想要的功能的信心。这里将涵盖到很多入门级别的基础知识，涉及到这些知识的时候，文档会提供足够多到其它章节的链接，以便深入了解这些知识点。

请运行[现场示例](https://angular.io/resources/live-examples/toh-6/ts/eplnkr.html)。

## 最终效果

这里有一个本教程中我们将要经历的视觉概念，以"Dashboard"视图及最为英勇的英雄开始：

![英雄dashboard](images/heroes-dashboard-1.png)

在看板的上面部分，是两个链接（"Dashboard"及"Heroes"）。可通过对它们进行点击，来在看板与多英雄视图之间导航。

此外，在点击名为“Magneta”的看板英雄之后，路由器（the router）将带着我们前往到该英雄的“Hero Details”的视图，那里可修改英雄的名字。

![英雄详细信息](images/hero-details-1.png)

此时点击“Back”按钮，将会把我们带回到“Dashboard”。顶部的链接则可分别将我们带至两个主要视图（the main views）。在点击“Heroes”时，该应用将前往“Heroes”主清单视图（the "Heroes" master list view）。

![英雄清单](images/heroes-list-2.png)

在点击不同英雄时，主清单下的那个只读的小型详情（the readonly mini-detail），将反应所选条目。

在点击只读的小型详情中的“View Details”按钮时，就会进入到所选英雄的可编辑详情组件。

![导航图示](images/nav-diagram.png)

下面是运作中的应用：

![运作中的应用](images/toh-anim.gif)

## 紧接着的下一步

我们将一起来构建这个英雄之旅的应用，一步一步地。在每一步都将使用一项在无数应用中都要遇到的特性需求，以激发大家的学习。万事万物都有其存在的因果。

在路途中，我们也将遇到许多Angular的核心基础知识点。

## 英雄编辑器

将要建立一个简单的英雄编辑器。

### 建立本地开发环境

真实的应用开发，是在自己机器上一个本地开发环境中进行的。

请依循[建立环境](https://angular.io/docs/ts/latest/guide/setup.html)的操作说明，来建立一个名为`angular-tour-of-heroes`的新项目，在建立之后，文件结构看起来应像下面这样：

![hero editor file structure](images/files-tree-hero-editor.png)

在完成这个第一小节后，应用会像这个[现场示例](https://angular.io/resources/live-examples/toh-1/ts/eplnkr.html)一样运行。

### 让app保持转换（transpiling）及运行

> *译者注：* 这里的transpiling指的是从TypeScript到JavaScript的转换，TypeScript的编译器（TypeScript Compiler, tsc）将TypeScript代码转换成JavaScript代码，过程中会对其进行优化。transpiling与compiling（编译）有所不同，编译是将源代码编译链接为二进制形式，transpiling则不同。

这里要启动TypeScript编译器，让其监视TypeScript代码变化，并启动服务器。通过在终端窗口输入下面的命令，来完成这些操作：

```bash
npm start
```

此命令将以监视模式（in watch mode）运行编译器、启动服务器、在浏览器中启动该应用，并在持续构建英雄之旅时，保持该app一直运行。

### 英雄的展示

在这个app中，要显示英雄的数据。

更新`AppComponent`组件，令其有着两个属性：一个用于应用名称的`title`属性，以及一个用于名为“Windstorm”的英雄的`hero`属性。

```typescript
export class AppComponent {
    title = 'Tour of Heroes';
    hero = 'Windstorm';
}
```

现在要使用到这些属性的数据绑定（data bindings to these new properties），对`@Component`装饰器的模板加以更新。

```typescript
template: `<h1>{{title}}</h1><h2>{{hero}} details!</h2>`
```

在对`app.component.ts`文件进行保存后，浏览器将刷新并显示出标题与英雄。

这里的双花括符（the double curly braces），告诉app从组件读取`title`与`hero`属性，并将其渲染出来。这就是单向数据绑定的“插值”形式（the "interpolation" form of one-way data binding）。

> 在[显示数据（Displaying Data）](https://angular.io/docs/ts/latest/guide/displaying-data.html)章节，可了解更多有关插值的内容。

### 英雄对象（Hero object）

此时的英雄只是一个名字。我们的英雄需要更多的属性。那么让我们将`hero`从一个文字的字符串，转换到一个类吧。

下面就建立一个带有`id`与`name`属性的`Hero`类。现在可将这个类放在`app.component.ts`文件的顶部，就在导入语句下面。

```typescript
export class Hero {
    id: number;
    name: string;
}
```

既然我们有了一个`Hero`类，就可以将组件中的`hero`属性，重构为`Hero`类型了。并以`1`的id与名字“Windstorm”对其进行初始化。

```typescript
hero: Hero = {
        id: 1,
        name: 'Windstorm'
    };
```

这里因为将`hero`属性从字符串改变为了一个对象，所以就要对模板中的绑定加以更新，以对该英雄的`name`属性加以引用。

```typescript
template: `<h1>{{title}}</h1><h2>{{hero.name}} details!</h2>`
```

浏览器将进行刷新，并持续显示出英雄的名字。

#### 加入更多的HTML

显示一个名字是不错的，但我们希望看到所有英雄的属性。那么就要加入一个用于英雄`id`的`<div>`标签，及另一个用于英雄名字`name`属性的`<div>`标签。

```typescript
template: '<h1>{{title}}</h1><h2>{{hero.name}} details!</h2><div><label>id: </label>{{hero.id}}</div><div><label>name: </label>{{hero.name}}</div>'
```

呜哦，现在模板字符串就变长了。那么最好对此加以留意，以避免模板中的拼写错误了。

#### 多行的模板字符串（multi-line template strings）

这里可通过字符串连接（string concatenation）操作，可以制作一个更具可读性的模板，但那样做将很快变得丑陋不堪，难于阅读，且很容易造成拼写错误。相反，可以采用ES2015与typescript中的模板字符串特性，来保持理智（maintain our sanity）。

将包围模板的引号，修改为反钩号（back-ticks），并将`<h1>`、`<h2>`及`<div>`元素，分别放在各自的行上，就行了。

```typescript
    template: `
        <h1>{{title}}</h1>
        <h2>{{hero.name}} details!</h2>
        <div><label>id: </label>{{hero.id}}</div>
        <div><label>name: </label>{{hero.name}}</div>
    `
```

### 对英雄进行编辑

这里要能在一个文本框（textbox）中，对英雄名字进行编辑。

将上面的英雄名字`<label>`元素，重构为`<lable>`及`<input>`元素，如下所示：

```typescript
    template: `
        <h1>{{title}}</h1>
        <h2>{{hero.name}} details!</h2>
        <div><label>id: </label>{{hero.id}}</div>
        <div>
            <label>name: </label>
            <input value="{{hero.name}}" placeholder="name" />
        </div>
    `
```

在浏览器中，我们看到英雄名字确实出现在了`<input>`文本框中。但感觉有些东西不对！在修改名字是，注意到做出的改变，并没有在`<h2>`中有体现。在使用到`<input>`的单向绑定是，并不能获得期望的行为。

#### 双向绑定（Two-Way Binding）

这里原本打算在`<input>`中显示英雄的名字，对其进行改变，并要在绑定了英雄名字的任何地方，都能观看到这些改变。也就是说，这里需要双向的数据绑定（two-way data binding）。

在可使用到**表单输入（form inputs）**的双向绑定前，需要导入Angular模块中的`FormsModule`包（the `FormsModule` package in our Angular module）。随后将其加入到`NgModule`装饰器的`imports`数组中。该数组包含了为这个应用所用到的外部模块的清单（the list of external modules used by our application）。现在就已经包含了包含到`ngModel`的表单包（the forms package）。

```typescript
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'

import { AppComponent } from './app.component';

@NgModule({
    imports: [
        BrowserModule,
        FormsModule
    ],
    declarations: [
        AppComponent
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
```

> 在[Forms](https://angular.io/docs/ts/latest/guide/forms.html#ngModel)及[模板语法](https://angular.io/docs/ts/latest/guide/template-syntax.html#ngModel)章节，可了解更多有关`FormsModule`与`ngModel`有关的知识。

接着就要更新模板，以使用到用于双向绑定的内建`ngModel`指令（the `ngModel` built-in directive for two-way binding）。

将`<input>`用以下HTML进行替换：

```html
<input [(ngModel)]="hero.name" placeholder="name">
```

浏览器将刷新。我们将再度看到英雄。可以对英雄的名字加以修改，并在`<h2>`元素中立即观看到修改的反映。

### 历程（The Road We've Travelled）

这里要把已经建立的内容，进行盘点一下：

+ 英雄之旅应用使用了双花括符的插值（一种单向数据绑定的方式，*译者注：那么还有其它类型的插值了*，the double curly braces of interpolation, a kind of one-way data binding），来现实应用的标题及`Hero`对象的属性。
+ 这里使用ES2015的模板字符串，编写了一个多行模板，来令到这里的模板具有更高的可读性。
+ 在使用内建的`ngModel`指令，加入了双向数据绑定到`<input>`元素后，就可以同时显示并修改英雄的名字了。
+ 该`ngModel`指令还可以将修改传播到所有其它的`hero.name`的绑定（the `ngModel` directive also propagates changes to every binding of the `hero.name`）。


下面是现在完整的`app.component.ts`:

```typescript
import { Component } from '@angular/core';

export class Hero {
    id: number;
    name: string;
}

@Component({
    selector: 'my-app',
    template: `
        <h1>{{title}}</h1>
        <h2>{{hero.name}} details!</h2>
        <div><label>id: </label>{{hero.id}}</div>
        <md-input-container>
            <input md-input id="name" [(ngModel)]="hero.name" placeholder="名 字" />
        </md-input-container>
    `,
})
export class AppComponent {
    title = 'Tour of Heroes';
    hero: Hero = {
        id: 1,
        name: 'Windstorm'
    };
}
```

**注：** 这里使用了 Angular 2 的Material，所以与原来有所不同。

### 前面的路

现在的应用仅显示一个英雄，但我们实际上是要显示一个英雄清单。同时要允许用户从清单中选择一个英雄并显示其详细信息。因此就要学习更多的如何来获取清单、将其绑定到模板，并允许用户来选择一个英雄。

## 主清单/详细信息模式（Master/Detail）

这里将要使用一个英雄清单，来构建一个主清单/详细信息的页面（build a master/detail page with a list of heroes）。

故事需要更多英雄。这里将把英雄应用，扩展为显示一个英雄清单、允许用户选择一个英雄，并显示该英雄的详细信息。

可允许这部分的[现场示例](https://angular.io/resources/live-examples/toh-2/ts/eplnkr.html)。

先来看看我们需要些什么来显示一个英雄的清单。首先，需要一个英雄清单。我们打算在视图模板（the view's template）中显示出这些英雄，那么就需要某种完成完成的方法。

### 上次留下的（Where We Left Off）

在继续英雄之旅的第二部分之前，我们先来检查一下下面第一部分完成后的文件结构。如不是下面这样，就要回到第一部分，找出那些遗失掉的文件。

![文件机构-第一部分](images/file-structure-part-I.png)

### 让应用保持transpiling及运行

我们想要启动TypeScript编译器，让其监视文件变化，并启动服务器。通过敲入下面的命令来完成这个操作：

```bash
npm start
```

该命令将在我们持续构建英雄之旅应用是，保持应用的运行。

### 显示我们的英雄

#### 建立一些英雄

这里要建立一个有着10名英雄的数组。

```typescript
const HEROES: Hero[] = [
    { id: 11, name: 'Mr. Nice' },
    { id: 12, name: 'Narco' },
    { id: 13, name: 'Bombasto' },
    { id: 14, name: 'Celeritas' },
    { id: 15, name: 'Magneta' },
    { id: 16, name: 'RubberMan' },
    { id: 17, name: 'Dynama' },
    { id: 18, name: 'Dr IQ' },
    { id: 19, name: 'Magma' },
    { id: 20, name: 'Tornado' }
];
```

该`HEROES`数组的类型为在第一部分中定义的`Hero`类（the `HEROES` array if of type `Hero`， the class defined in part one），该类型用于建立建立一个多英雄的数组。我们原本是期望从某个web服务处获取此英雄列表的，但这里就先小步慢走，显示一下模拟的英雄吧。

#### 将英雄暴露出来（Exposing heroes）

让我们在`AppComponent`中建立一个将这些英雄暴露给数据绑定的公共属性（a public property in `AppComponent` that exposes the heroes for binding）。

```typescript
heroes = HEROES;
```

这里无需对`heroes`的类型进行定义。TypeScript可从`HEROES`数组推断出`heroes`的类型。

> 实际上我们可在这个组件类中对`heroes`清单的类型加以定义。但我们知道最终我们将从某个数据服务获取这些英雄。因为我们知道后面将前往何处，所以把英雄数据与一开始就应用的类分离，是有意义的（but we know that ultimately we'll get the heroes from a data service. Because we know where we are heading, it makes sense to separate the hero data from the class implementation from the start）。

#### 在模板中显示这些英雄

现在的组件已经有了`heroes`属性。那么就要在模板中建立一个无需列表（an unordered list），来将这些英雄显示出来。这里将把下面的HTML代码块放到标题下面, 在英雄详细信息的上面.

```html
        <md-list class="heroes">
            <md-list-item>
                <!-- each hero goes here -->
            </md-list-item>
        </md-list>
```

现在就有了一个可将我们的英雄放入进去的模板了。

#### 使用`ngFor`来将这些英雄列出

我们想要将组件中的`heroes`绑定到我们的模板、对其进行遍历，并单个地显示出来。这需要Angular的助力才能完成了。下面就让我们一步一步地来完成这个事情。

首先要通过加入内建的`*ngFor`指令，来对`<li>`加以改造。

```html
<md-list-item *ngFor="let hero of heroes">
```

> 这里`ngFor`前面的前导的星号（`*`），是该语法的重要部分（the leading asterisk(*) in front of `ngFor` is a critical part of this syntax）。

> `ngFor`的星号前缀，表明该`<li>`与其子元素，构成了一个主清单模板（the (*) prefix to `ngFor` indicates that the `<li>` and its children constitute a master template）。
> 该`ngFor`指令，将对由`AppComponent.heroes`属性所返回的`heroes`数组进行遍历，并在此模板中一个一个地显示出来（the `ngFor` directive iterates over the `heroes` array returned by the `AppComponent.heroes` property and stamps out instances of this template）。
> 上面赋予给`ngFor`的双引号括起来的文本，意思是“取得`heroes`数组中的每个英雄，将其保存在本地的`hero`变量，并令其对相应的模板实例可用（take each hero in the `heroes` array, store it in the local `hero` variable, and make it available to the corresponding template instance）”。
> 在“hero”前的`let`关键字，将`hero`标识为一个模板的输入变量（the `let` keyword before "hero" identifies `hero` as a template variable）。就可以在模板那边对该变量进行引用，以访问到某个英雄的属性了。
> 请在[显示数据（Displaying Data）](https://angular.io/docs/ts/latest/guide/displaying-data.html#ngFor)及[模板语法](https://angular.io/docs/ts/latest/guide/template-syntax.html#ngFor)章节，了解更多有关`ngFor`与模板输入变量有关的知识。
