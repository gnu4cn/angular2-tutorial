# 教程：英雄之旅

此英雄之旅教程，将引导你走过以TypeScript, 建立一个Angular应用的各个步骤。

此教程的大目标，就是构建一个应用，来帮助人力资源机构，管理其签约英雄。就算英雄也需要找到工作呀。

在本教程中，当然只会取得一点点进步。但这里所构建的应用，将包含在一个成熟的、数据驱动的应用中，所期望能找到的众多特性：英雄列表的获取及现实、编辑所选定英雄的信息，以及在英雄数据的不同视图之间的导航。

英雄之旅涵盖了Angular的一些核心基础知识点。
- 这里将用到一些内建的指令（built-in directives），来显示或隐藏页面元素，以及英雄数据清单的显示。
- 将建立一个组件来现实英雄详细信息，并建立另一个组件，来显示一个英雄的数组（an array of heroes）。
- 对于那些只读数据（read-only data）, 这里将使用单项数据绑定（one-way data binding）。
- 将加入可编辑字段，来对带有双向数据绑定的某个模型加以更新（add editable fields to update a model with two-way data binding）。
- 这里将把一些组件方法，绑定到注入按键及鼠标点击这样的用户事件（bind component methods to user events like key strokes and clicks）。
- 将学习从某个主清单中选择一个英雄，并在详情视图中加以编辑（learn to select a hero from a master list and edit that hero in the details view）。
- 将使用管道对数据进行格式化操作（format data with pipes）。将建立一个共享服务，来对这些英雄加以集合（create a shared service to assemble our heroes）。
- 还将使用路由在不同视图及其组件之间进行导航（use routing to navigate among different views and their components）。

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

显示一个名字是不错的，但我们希望看到所有英雄的属性。那么就要加入一个用于英雄`id`的`<div>`标记，及另一个用于英雄名字`name`属性的`<div>`标记。

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

- 英雄之旅应用使用了双花括符的插值（一种单向数据绑定的方式，*译者注：那么还有其它类型的插值了*，the double curly braces of interpolation, a kind of one-way data binding），来现实应用的标题及`Hero`对象的属性。
- 这里使用ES2015的模板字符串，编写了一个多行模板，来令到这里的模板具有更高的可读性。
- 在使用内建的`ngModel`指令，加入了双向数据绑定到`<input>`元素后，就可以同时显示并修改英雄的名字了。
- 该`ngModel`指令还可以将修改传播到所有其它的`hero.name`的绑定（the `ngModel` directive also propagates changes to every binding of the `hero.name`）。


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

现在，在`<li>`标记之间插入一些使用`hero`模板变量来显示英雄属性的内容。

```html
<md-list-item *ngFor="let hero of heroes">
    <span class="badge">{{hero.id}}</span>{{hero.name}}
</md-list-item>
```            

### 给我们的英雄加上样式

这里的英雄清单看起来相当乏味。那么就会想让这个清单让用户看起来更为明显，可以区别出鼠标悬浮的英雄与选定的英雄有所不同。

这里就要通过在`@Component`装饰器上设置`styles`属性为下面这些CSS类，来将一些样式加入到组件。

```typescript
styles: [`
        .selected {
            background-color: #CFD8DC !important;
            color: white;
        }
        .heroes {
            margin: 0 0 2em 0;
            list-style-type: none;
            padding: 0;
            width: 15em;
        }
        .heroes md-list-item {
            cursor: pointer;
            position: relative;
            left: 0;
            background-color: #EEE;
            margin: .5em;
            padding: .3em 0;
            height: 1.6em;
            border-radius: 4px;
        }
        .heroes md-list-item.selected:hover {
            background-color: #BBD8DC !important;
            color: white;
        }
        .heroes md-list-item:hover {
            color: #607D8B;
            background-color: #DDD;
            left: .1em;
        }
        .heroes .text {
            position: relative;
            top: -3px;
        }
        .heroes .badge {
            display: inline-block;
            font-size: small;
            color: white;
            padding: 0.8em 0.7em 0 0.7em;
            background-color: #607D8B;
            line-height: 1em;
            position: relative;
            left: -1px;
            top: -4px;
            height: 1.8em;
            margin-right: .8em;
            border-radius: 4px 0 0 4px;
        }
    `
```

**注：**因为这里使用了Angular2 Material, 所以较原文有所改变。

请注意这里有很多的样式！我们可以想这里所展示的那样把它们放在行内，或者可将这些样式移除到其自身文件，那样就可以令到对组件的编码编写更为容易。后面的章节就将这么做。现在只需继续前进。

在将一些样式指派到某个组件时，这些样式将局限在那个特定组件。上面的这些样式只将应用到这里的`AppComponent`，而不会“泄露（leak）”到外部HTML。

现在用于显示这些英雄的模板，应看起来像下面这样。

```html
        <h2>My Heroes</h2>
        <md-list class="heroes">
            <md-list-item *ngFor="let hero of heroes">
                <span class="badge">{{hero.id}}</span>{{hero.name}}
            </md-list-item>
        </md-list>
```

### 选择一名英雄

现在我们的应用有了一个英雄清单，同时还有显示了单独一名英雄的详细信息。清单与单独的英雄并没有以某种形式联系起来。而想要的是用户可以从清单中选择一名英雄，并将选择的英雄呈现在详细信息视图中。此种UI模式，就是广为人知的“主清单-详细信息”模式（this UI pattern is widely known as "master-detail"）。在这个案例中，主清单就是英雄清单，同时详细信息则是所选的英雄了。

这里要通过一个绑定到点击事件的组件属性`selectedHero`，来将主清单和详细信息联系起来（let's connect the master to the detail through a `selectedHero` component property bound to a click event）。

#### 关于点击事件（Click event）

通过将一个绑定到`<li>`的Angular事件绑定插入到`<li>`标记中，对其进行修改。

```html
<md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)">
    <span class="badge">{{hero.id}}</span>{{hero.name}}
</md-list-item>
```

请关注这里的时间绑定：

```html
(click)="onSelect(hero)"
```

这里的双括号，将`<li>`元素的`click`事件，标识为目标（the parenthesis identify the `<li>` element's `click` event as the target）。而等号右边的表达式则是对`AppComponent`的`onSelect()`方法进行调用，将模板输入变量`hero`作为一个参数加以传入。该参数就是先前在`ngFor`中所定义的`hero`变量。

> 在[用户输入](https://angular.io/docs/ts/latest/guide/user-input.html)与[模板语法](https://angular.io/docs/ts/latest/guide/template-syntax.html#event-binding)章节，可了解有关事件绑定（Event Binding）方面更多的知识。

#### 加入点击处理器（Add the click handler）

这里的时间绑定，引用了一个尚不存在的`onSelect`方法。那么现在就要将那个方法加入到组件。

那个方法要做些什么呢？它应将组件选定的英雄，设置为用户所点击的英雄。

这里的组件还没有一个“选定的英雄（selected hero）”。那么我们就从这里开始。

#### 将选定英雄暴露出来（Expose the selected hero）

现在就不再需要`AppComponent`的静态`hero`属性了。将其**替换**为这个简单的`selectedHero`属性：

```typescript
selectedHero: Hero;
```

这里确定下在用户选择某个英雄之前，不会有一个选定的英雄，一次不会如同前面`hero`那样，对`selectedHero`进行初始化。

现在就要**加入一个`onSelect`方法**，将`selectedHero`属性，设置为用户所点击的`hero`。

```typescript
onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }
```   

后面将在模板中现实所选英雄的详细信息。而此时模板仍然引用的是旧的`hero`属性。那么就让我们将模板修正为绑定到新的`selectedHero`属性吧。

```
<h2>{{selectedHero.name}} details!</h2>
<div><label>id: </label>{{selectedHero.id}}</div>
<md-input-container>
    <input md-input id="name" [(ngModel)]="selectedHero.name" placeholder="名 字" />
</md-input-container>
```

#### 使用`ngIf`来隐藏空详细信息（Hide the empty detail with `ngIf`）

当应用装入时，我们将看到一个英雄的清单，但没有英雄被选定。因此`selectedHero`就处于未定义`undefined`状态。那就是将在浏览器控制台中看到以下错误的原因：

```console
EXCEPTION: TypeError: Cannot read property 'name' of undefined in [null]
```

请记住在模板中一直显示着`selectedHero.name`呢。而因为`selectedHero`本身就是未定义的，所以这个`name`属性并不存在。

通过在某个英雄被选定之前，将英雄详细信息排除在DOM之外（keeping the hero detail out of the DOM）这么做，就能解决这个问题。

这里将模板的这个HTML的英雄详细信息内容，用一个`<div>`标记加以封装。随后在加入内建的`ngIf`指令，并将其设置为组件的`selectedHero`属性。

```typescript
<div *ngIf="selectedHero">
    <h2>{{selectedHero.name}} details!</h2>
    <div><label>id: </label>{{selectedHero.id}}</div>
    <md-input-container>
        <input md-input id="name" [(ngModel)]="selectedHero.name" placeholder="名 字" />
    </md-input-container>
</div>
```

> 请记住这里`ngIf`前面的前导星号，是该语法的重要组成部分。

在没有`selectedHero`时，`ngIf`指令将从DOM移除这些英雄详细信息的HTML。就不会有那些英雄详细信息的元素了，同时也就无需担心那些绑定了。

在用户拾取某名英雄时，`selectedHero`将变为“真（truthy）”，同时`ngIf`就把这些英雄详细信息内容，放入到DOM，并执行所嵌套的那些绑定。

> `ngIf`与`ngFor`两个内建指令，叫做“结构性指令（structural directives）”，因为它们可以改变DOM组成部分的结构。也就是说，正是它们赋予结构以Angular在DOM中显示内容方式（they can change the structure of portions of the DOM. In other words, they give structure to the way Angular displays content in the DOM）。
> 可在[结构性指令](https://angular.io/docs/ts/latest/guide/structural-directives.html)及[模板语法](https://angular.io/docs/ts/latest/guide/template-syntax.html#directives)章节，了解更多有关`ngIf`、`ngFor`及其它结构性指令的知识。

浏览器将刷新，我们将看到英雄清单，而不是所选的英雄详细信息。这是以为`selectedHero`处于未定义状态，所以`ngIf`将英雄详细信息排除在了DOM之外。而当我们点击清单中的某名英雄时，所选的英雄将显示在英雄详细信息中。我们所期望的功能就都实现了。

#### 为所选添加样式（Styling the selection）

现在可以在下面的详细信息区域看到所选的英雄了，但在上面的清单中却无法快速找到那名英雄。通过将`selected`CSS类应用到主清单中适当`<li>`上，就可以修正这个问题。比如，在选择了英雄清单中的Magneta时，可通过赋予其一个如下所示的些许不同的背景色，而令其从视觉上冒出来。

![已选择的英雄清单](images/heros-list-selected.png)

这里将把一个的绑定在`class`上的到CSS类`selected`的属性，加入到模板（we'll add a property binding on `class` for the `selected` class）。将把此绑定设置为一个将当前的`selectedHero`与模板输入变量`hero`进行比较的表达式。

此处的关键，就是该CSS类的名称（也就是`selected`）。在两个英雄匹配时，表达式的值就为真`true`，否则就为假`false`。就是说“在比较的两名英雄匹配是，就应用`selected`类，如不匹配，则移除之”（we're saying *"apply the `selected` class if the heroes match, remove it if they don't"*）。


```html
[class.selected]="hero === selectedHero"
```

请注意模板中的`class.selected`是被方括号（square brackets(`[]`)）括起来的。这正是**属性绑定（property binding）**的语法，属性绑定中数据从数据流单向流动，到`class`的某个属性（property binding, a binding in which data flows one way from the data source(the expression `hero === selectedHero`) to a property of `class`）。

```html
<md-list class="heroes">
    <md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)"
        [class.selected]="hero === selectedHero">
        <span class="badge">{{hero.id}}</span>{{hero.name}}
    </md-list-item>
</md-list>
```

> 在模板语法章节，可了解到更多有关[属性绑定](https://angular.io/docs/ts/latest/guide/template-syntax.html#property-binding)的知识。

浏览器将重新装入应用。在选择了英雄Magneta后，通过背景颜色，选定项就被清楚地标识出来了。

![英雄清单](images/heroes-list-1.png)

在选择了不同英雄后，这种标识颜色将转换到那名英雄上（the tell-tale color switches to that hero）。

下面是目前完整的`app.component.ts`：

```typescript
import { Component } from '@angular/core';

export class Hero {
    id: number;
    name: string;
}

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
]

@Component({
    selector: 'my-app',
    styles: [`
        .selected {
            background-color: #CFD8DC !important;
            color: white;
        }
        .heroes {
            margin: 0 0 2em 0;
            list-style-type: none;
            padding: 0;
            width: 15em;
        }
        .heroes md-list-item {
            cursor: pointer;
            position: relative;
            left: 0;
            background-color: #EEE;
            margin: .5em;
            padding: .3em 0;
            height: 1.6em;
            border-radius: 4px;
        }
        .heroes md-list-item.selected:hover {
            background-color: #BBD8DC !important;
            color: white;
        }
        .heroes md-list-item:hover {
            color: #607D8B;
            background-color: #DDD;
            left: .1em;
        }
        .heroes .text {
            position: relative;
            top: -3px;
        }
        .heroes .badge {
            display: inline-block;
            font-size: small;
            color: white;
            padding: 0.8em 0.7em 0 0.7em;
            background-color: #607D8B;
            line-height: 1em;
            position: relative;
            left: -1px;
            top: -4px;
            height: 1.8em;
            margin-right: .8em;
            border-radius: 4px 0 0 4px;
        }
    `
    ],

    template: `
        <h1>{{title}}</h1>
        <h2>My Heroes</h2>
        <md-list class="heroes">
            <md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)"
                [class.selected]="hero === selectedHero">
                <span class="badge">{{hero.id}}</span>{{hero.name}}
            </md-list-item>
        </md-list>
        
        <div *ngIf="selectedHero != undefined">
            <h2>{{selectedHero.name}} details!</h2>
            <div><label>id: </label>{{selectedHero.id}}</div>
            <md-input-container>
                <input md-input id="name" [(ngModel)]="selectedHero.name" placeholder="名 字" />
            </md-input-container>
        </div>
    `,
})
export class AppComponent {
    title = 'Tour of Heroes';
    selectedHero: Hero;
    heroes = HEROES;

    onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }
}
```

### 历程回顾（The Road We've Travelled）

下面是本章所达成的一些目标：

- 现在我们的英雄之旅应用显示了一个可选择的英雄清单。
- 加入了选择某名英雄并展示其详细信息的能力。
- 学习了在组件模板中怎样来使用内建的`ngIf`与`ngFor`指令

请在[现场示例](https://angular.io/resources/live-examples/toh-2/ts/eplnkr.html)来运行这一部分。


### 后面的路

现在这个英雄之旅应用已经有所成长，但离完成还很远。将完整的应用放入到单个的组件中，是不可行的。所以需要将单个的组件，拆分成一些子组件，并教会它们一起运作，这就是下一章要学的内容。

## 多个组件（Multiple Components）

本章要将主清单/详细信息视图，重构为一些单独组件（refactor the master/detail view into separate components）。

这个app在不断变大。一些用例正以组件重用、往组件传入数据，以及创建出更多可重用资源的方式涌现出来（use cases are flowing in for reusing components, passing data to components, and creating more reusable assets）。那么就让我们将英雄清单从英雄详细信息中分离出来，并令到详细信息组件成为可重用的组件吧。

请在[现场示例](https://angular.io/resources/live-examples/toh-3/ts/eplnkr.html)运行这部分。

### 上次留下的内容

在继续英雄之旅前，先来检查一下下面的文件结构。如不是那样，就需要回到上一章，加以补充。

![第二部分的文件结构](images/file-structure-part-II.png)

### 让应用保持transpiling及运行

我们想要启动TypeScript编译器，让其监视文件变化，并启动服务器。通过敲入下面的命令来完成这个操作：

```bash
npm start
```

该命令将在我们持续构建英雄之旅应用是，保持应用的运行。

### 制作一个英雄详细信息组件（Making a Hero Detail Component）

这里的英雄清单及英雄详细信息，位于同一文件的同一个组件中。它们现在还比较小，但都可能会增大。可以确定的是，对于其中一个是需要一些新的需求、另一个则没有什么新的需求的。因此所有变化都将把两个组件置于风险之中，同时在测试上也是事半功倍的。如我们不得不在应用中的其它地方重用到英雄详细信息，那么英雄清单就将一路随行（they're small now but each could grow. We are sure to receive new requiements for one and not the other. Yet every change puts both components at risk and doubles the testing burden without benefit. If we had to reuse the hero details elsewhere in our app, the heroes list would tag along for the ride）。

当前的组件，违反了[单一功能原则](https://zh.wikipedia.org/wiki/%E5%8D%95%E4%B8%80%E5%8A%9F%E8%83%BD%E5%8E%9F%E5%88%99)（[the Single Responsibility Principle](https://8thlight.com/blog/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html)）。尽管这是一个教程，但我们还是可以把事情做对 -- 尤其是这又没有什么困难的，同时我们在这个过程中还能学到如何来构建Angular应用。

先来将英雄详细信息，分解到其自己的组件中。

#### 分离出英雄详细信息组件（Separating the Hero Detail Component）

请加入一个名为`hero-detail.component.ts`的文件，到`app`文件夹，并像下面这样创建出`HeroDetailComponent`。

```typescript
import { Component, Input } from '@angular/core'

@Component({
    selector: 'my-hero-detail',
})

export class HeroDetailComponent {}
```

> **命名约定（Naming conventions）**
> 我们希望能一眼就看出哪些类是组件，以及哪些文件包含了组件。
> 请注意这里的一个名为`app.component.ts`文件中，有着一个`AppComponent`，而新的`HeroDetailComponent`则是在一个名为`hero-detail.component.ts`文件中。
> 所有的组件名称，都是以"Component"结尾的。而所有组件文件名称，都是以".component"结尾的。
> 这里所有文件名都是以小写的中线命名法（dash case, 又名烤串命名法，kebab-case）拼写的，因此无需担心服务器上或代码控制中的大小写敏感问题（we spell our file names in lower dash case(AKA kebab-case) so we don't worry about case sensitivity on the server or in source control）。

这里以从Angular导入`Component`及`Input`装饰器开始，因为很快将要使用到它们。

使用`Component`装饰器，来创建出元数据，在装饰器中制定了将这个组件的元素表示出来的选择器名称（we create metadata with the `Component` decorator where we specify the selector name that identifies this component's element）。随后就将该类加以导出，并令其对其它组件可用了。

在完成了这里后，就会将该`HeroDetailComponent`导入到`AppComponent`, 并建立相应的`<my-hero-detail>`元素。

### 英雄详细信息模板（Hero Detail Template）

此时，*多个英雄及英雄详细信息*的那些视图，还是结合在`AppComponent`的同一模板中的。那么就让我们从`AppComponent`中将*英雄详细信息*，**剪切（cut）**下来，并**粘贴（paste）**到新的`HeroDetailComponent`的模板属性中去吧。

前面我们对`AppComponent`的`selectedHero.name`进行了绑定。而`HeroDetailComponent`将有一个`hero`属性，而不是`selectedHero`属性。因此在新的模板中，要将`selectedHero`用`hero`加以替换。那是仅有的修改了。结果看起来像下面这样：

```typescript
template: `
    <div *ngIf="hero != undefined">
        <h2>{{hero.name}} details!</h2>
        <div><label>id: </label>{{hero.id}}</div>
        <md-input-container>
            <input md-input id="name" [(ngModel)]="hero.name" placeholder="名 字" />
        </md-input-container>
    </div>
`
```

现在英雄详细信息的布局，就仅存在与新的`HeroDetailComponent`中了。

### 加入*HERO*属性（ADD THE *HERO* PROPERTY）

现在加入上面所讲到的组件类中的`hero`属性。

```typescript
hero: Hero;
```

呜哦。这里将`hero`属性，声名为类型`Hero`，但`Hero`类却是在`app.component.ts`文件中的。现在有着两个组件，分别在各自的文件中，都需要对`Hero`类进行引用。

这里通过将`Hero`类，从`app.component.ts`文件，重新放到其自己的`hero.ts`文件中。

```typescript
export class Hero {
    id: number;
    name: string;
}
```

这里将`hero.ts`中的`Hero`类加以到处，是因为我们在两个组件文件都需要对其进行引用。请在`app.component.ts`及`hero-detail.component.ts`两个文件的顶部，同时加入下面的导入语句。

```typescript
import { Hero } from './hero';
```

### 这里的*HERO*属性，是一个*INPUT*（THE *HERO* PROPERTY IS AN INPUT）

必须告诉`HeroDetailComponent`要显示哪名英雄。那么由谁来告诉它呢？就是父组件`AppComponent`了。

`AppComponent`知道要显示哪名英雄：就是用户从清单中选择的那名英雄。而用户的选择，是在`AppComponent`的`selectedHero`属性中的。

马上就要对`AppComponent`的模板进行更新，以令到`AppComponent`将其`selectedHero`属性，绑定到`HeroDetailComponent`的`hero`属性。该绑定看起来*可能*像这样：

```html
<my-hero-detail [hero]="selectedHero"></my-hero-detail>
```

请注意这里的`hero`属性，是属性绑定的**目标（target）** -- 其处于等号左边的方括号中。

Angular强调在声明某个**目标**属性时，应作为一个**输入**属性（Angular insists that we declare a **target** property to be an ***input*** property）。如没有这样做，Angular将拒绝此绑定并抛出一个错误。

> 在[这里](https://angular.io/docs/ts/latest/guide/attribute-directives.html#why-input)我们对输入属性有更详细的说明，同时还解释了目标属性需要此种特殊对待、而源属性不受约束的原因。

将那个`hero`属性声明为一个*输入*的的方式有两三种。这里将使用我们首选的方式，也就是使用早先所导入的`@Input`装饰器，来对这个`hero`属性加以注释。

```typescript
@Input()
hero: Hero;
```

> 在[属性指令（Attribute Directives）](https://angular.io/docs/ts/latest/guide/attribute-directives.html#input)章节，可了解到更多有关这个`@Input`装饰器的知识。


### 对AppModule加以刷新（Refresh the AppModule）

现在回到`AppModule`, 也就是该应用的根模块（root module），并教会它使用新的`HeroDetailComponent`.

以导入`HeroDetailComponent`开始，之后就可以对其进行引用了。

```typescript
import { HeroDetailComponent } from './hero-detail.component';
```

随后将`HeroDetailComponent`加入到`NgModule`装饰器的`declarations`数组中。该数组包含了我们所创建的、并属于这个应用模块的所有组件的清单、管道，与指令（the `NgModule` decorator's `declarations` array, this array contains the list of all components, pipes, and directives that we created and that belong in our application's module）。

### 刷新AppComponent（Refresh the AppComponent）

现在既然应用已经获悉有着`HeroDetailComponent`了，就要在`AppComponent`模板中找到先前移除掉的*英雄详细信息*内容的地方，并在那里加入表示`HeroDetailComponent`的一个元素标记。

```html
<my-hero-detail></my-hero-detail>
```

> *my-hero-detail*就是我们在`HeroDetailComponent`元数据中作为`selector`设置的名称。

除非我们像下面这样，将`AppComponent`的`selectedHero`属性绑定到`HeroDetailComponent`元素的`hero`属性，这两个组件是不会协调起来的。

```html
<my-hero-detail [hero]="selectedHero"></my-hero-detail>  
```

现在`AppComponent`的模板看起来想下面这样了：

```typescript
    template: `
        <h1>{{title}}</h1>
        <h2>My Heroes</h2>
        <md-list class="heroes">
            <md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)"
                [class.selected]="hero === selectedHero">
                <span class="badge">{{hero.id}}</span>{{hero.name}}
            </md-list-item>
        </md-list>
        <my-hero-detail [hero]="selectedHero"></my-hero-detail>  
    `
```

正是由于有了这个绑定，`HeroDetailComponent`将接收到来自`AppComponent`的英雄，并将那名英雄的详细信息显示在清单之下。该详细信息会在每次用户点选一名新的英雄时，加以更新。

### 运行起来了（It works!）

当我们在浏览器中查看应用时，将看到一个英雄的清单。在选择了某位英雄后，就可以看到所选英雄的详细信息。

从根本上讲，这里新引入的就是可以在应用的任何地方，使用这个`HeroDetailComponent`来显示英雄的详细信息了。

我们已经建立出了第一个可重用的组件！

### 审视一下应用结构（Reviewing the App Structure）

在本章中所完成的良好重构之后，让我们来检查一下有着的下面的文件结构。

![第四部分的文件结构](images/file-structure-part-IV.png)

下面是本章所讨论到的一些代码文件。

先是`app.component.ts`:

```typescript
import { Component } from '@angular/core';

import { Hero } from './hero';

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
]

@Component({
    selector: 'my-app',
    styles: [`
        .selected {
            background-color: #CFD8DC !important;
            color: white;
        }
        .heroes {
            margin: 0 0 2em 0;
            list-style-type: none;
            padding: 0;
            width: 15em;
        }
        .heroes md-list-item {
            cursor: pointer;
            position: relative;
            left: 0;
            background-color: #EEE;
            margin: .5em;
            padding: .3em 0;
            height: 1.6em;
            border-radius: 4px;
        }
        .heroes md-list-item.selected:hover {
            background-color: #BBD8DC !important;
            color: white;
        }
        .heroes md-list-item:hover {
            color: #607D8B;
            background-color: #DDD;
            left: .1em;
        }
        .heroes .text {
            position: relative;
            top: -3px;
        }
        .heroes .badge {
            display: inline-block;
            font-size: small;
            color: white;
            padding: 0.8em 0.7em 0 0.7em;
            background-color: #607D8B;
            line-height: 1em;
            position: relative;
            left: -1px;
            top: -4px;
            height: 1.8em;
            margin-right: .8em;
            border-radius: 4px 0 0 4px;
        }
    `
    ],

    template: `
        <h1>{{title}}</h1>
        <h2>My Heroes</h2>
        <md-list class="heroes">
            <md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)"
                [class.selected]="hero === selectedHero">
                <span class="badge">{{hero.id}}</span>{{hero.name}}
            </md-list-item>
        </md-list>
        <my-hero-detail [hero]="selectedHero"></my-hero-detail>  
    `,
})
export class AppComponent {
    title = 'Tour of Heroes';
    selectedHero: Hero;
    heroes = HEROES;

    onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }
}
```

`hero-detail.component.ts`:

```typescript
import { Component, Input } from '@angular/core'

import { Hero } from './hero';

@Component({
    selector: 'my-hero-detail',
    template: `
        <div *ngIf="hero != undefined">
            <h2>{{hero.name}} details!</h2>
            <div><label>id: </label>{{hero.id}}</div>
            <md-input-container>
                <input md-input id="name" [(ngModel)]="hero.name" placeholder="名 字" />
            </md-input-container>
        </div>
    `
})

export class HeroDetailComponent {
    @Input()
    hero: Hero;
}
```

`hero.ts`
export class Hero {
    id: number;
    name: string;
}
```

最后是`app.module.ts`:

```typescript
import 'hammerjs';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'
import { MaterialModule } from '@angular/material'

import { AppComponent } from './app.component';
import { HeroDetailComponent } from './hero-detail.component'


@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        MaterialModule.forRoot()
    ],
    declarations: [
        AppComponent,
        HeroDetailComponent
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
```

*译者注：* 这里第一行的`import 'hammerjs';`是因为Angular2 Material的使用而导入的（加入触摸支持）。同时还需要对项目中的`systemjs.config.js`做加入`'hammerjs': 'npm:hammerjs/hammer.min.js'`。

### 走过的路（The Road We've Travelled）

让我们来对已经构建的部分做一个盘点：

- 建立了一个可重用的组件
- 学习了怎样令到某个组件接受输入
- 学习了在某个Angular模块中声明所需要的一些应用的指令。我们将这些指令在`NgModule`装饰器的`declarations`数组中列出（we learned to declare the application directives we need in an Angular module. We list the directives in the `NgModule` decorator's `declarations` array）。
- 学习了将某个父组件绑定到某个子组件。

请允许此部分的[现场示例](https://angular.io/resources/live-examples/toh-3/ts/eplnkr.html)。

### 前面的路（the Road Ahead）

在有了共享组件后，现在我们的英雄之旅应用已变得更具可重用了。

但现在仍是在`AppComponent`中，获取模拟数据。那样做并不是可持续的。后面应将数据访问重构为一个单独的服务，并在需要数据的组件之间，共享该服务。

下一个教程章节，我们将学习服务的建立。

## 服务（Services）

本章将建立一个可重用的服务，来管理我们的英雄数据调用。

英雄之旅应在一直进化，同时我们也期望在不久的将来，加入到更多的组件进来。

现在有多个组件将需要对英雄数据进行访问，而我们不打算一次次地拷贝和粘贴同样的代码。相反，我们要建立一个可重用的数据服务，并学会将其注入到需要该服务的组件中。

把数据访问重构为一个单独的服务，可以保持组件的精益，从而将组件的作用，集中在对视图的支持上（keeps the component lean and focused on supporting the view）。此种重构，还令到使用一个模拟服务来对组件进行单元测试更为容易。

而由于数据服务总是异步的，因此本章将以一个**基于承诺**版本的数据服务结束（because data services are invariably asynchronous, we'll finish the chapter with a **Promise**-based version of the data service）。

请运行此部分的[现场示例](https://angular.io/resources/live-examples/toh-4/ts/eplnkr.html)。

### 上次完成的（Where We Left Off）

在继续英雄之旅前，我们先来核对一下下面文件结构。如不是下面这样，就要回到前一部分，找出那些遗失掉的文件。

![第四部分的文件结构](images/file-structure-part-IV.png)

### 让应用保持transpiling及运行

我们想要启动TypeScript编译器，让其监视文件变化，并启动服务器。通过敲入下面的命令来完成这个操作：

```bash
npm start
```

该命令将在我们持续构建英雄之旅应用是，保持应用的运行。

### 建立Hero服务（Creating a Hero Service）

现在，应用中的一些利益攸关方已经共享了其更广大愿景（Our stakeholders have shared their larger vision for our app）。这些利益攸关方想要在不同页面上以各种方式显示我们的这些英雄。现在已经能够从清单中选择一名英雄。立马我们就要加入一个带有那些顶级表现英雄的dashboard，并为编辑英雄详细信息而创建出一个单独视图。所有三个视图（清单、dashboard和详细信息），都需要英雄数据。

目前，是`AppComponent`组件定义了用于显示的模拟英雄集。这样做至少有着两个问题。首先，定义这些英雄，并不是该组件的工作；其次，不能轻易地在其它组件与视图之间，共享那个英雄清单。

可将这个英雄数据获取业务（data acquisition business），重构为一个提供英雄数据的单一服务，并由那些需要英雄数据的组件，来共享那个服务。

### 建立`HeroService`（Create the `HeroService`）

请在`app`文件夹中建立一个叫做`hero.service.ts`的文件。

> 这里我们已经采用了一种命名约定，在该约定中，我们将服务名称拼写为后面带有`.service`的小写形式。在服务名称有多个单词时，将把基本文件名（the base filename）写着小写的中线命名法形式。比如`SpecialSuperHeroService`就将定义在`special-super-hero.service.ts`文件中。

这里将该类命名为`HeroService`并加以导出，以便后面其它组件等的导入。

```typescript
import { Injectable } from '@angular/core'

@Injectable()
export class HeroService {}
```

### 关于可注入服务（Injectable Services）

请注意这里导入了Angular的`Injectable`函数，将将那个函数作为一个`@Injectable()`装饰器加以使用。

> **不要忘掉了括号！** 忽略了它们将导致一个难于诊断的错误。

TypeScript将观察到该`@Injectable()`装饰器，并生成有关该服务的元数据，Angular会需要这些元数据，来将其它依赖注入到此服务。

*目前的*`HeroService`尚无任何的依赖。不过还是要加入该装饰器。*从一开始*就应用这个`@Injectable()`装饰器，从一致性和经历时间考验上讲，都是一种“最佳实践”（It is a "best practice" to apply the `@Injectable()` decorator *from the start* both for consistency and for future-proofing）。

### 获取到这些英雄（Getting Heroes）

这里要加入一个`getHeroes()`方法的存根（stub）。

```typescript
@Injectable()
export class HeroService {
    getHeroes(): void{} // stub
}
```

在做出一个重要节点上，在部署上会遇到一点障碍一会儿（we're holding back on the the implementation for a moment to make an important point）。

这个服务的消费者（the consumer of our service）并不知道该服务是如何获取到数据的。服务`HeroService`可从任意地方取得`Hero`数据。其可从某项web服务或者本地存储，抑或某个模拟数据源，获取数据。

那就是将数据访问从组件中移除的优美之处。以后在采用何种部署方式时，就可以随心所欲地、不管何种理由地改变主意，而无需触碰到那些需要英雄数据的组件。

### 模拟英雄（Mock Heroes）

在`AppComponent`中，实际上已经有了模拟的`Hero`数据。但模拟数据其实并不属于那里，也不属于这里。所以就要将模拟数据移动到其自身文件中。

请将`HEROES`数组从`app.component.ts`文件中剪切出来，将其粘贴到`app`文件夹中一个名为`mock-hero.ts`的新文件中。同样还要将`import { Hero } ...`语句进行拷贝，因为这个英雄数组使用到了`Hero`类。

```typescript
import { Hero } from './hero'

export const HEROES: Hero[] = [
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
]
```

这里将`HEROES`常量进行了导出，因此后面就可以其它地方将其导入了--就跟我们的`HeroService`一样。

与此同时，回到`app.component.ts`，那里因为将`HEROES`数组剪切了出去，就留下了一个未初始化的`heroes`属性：

```typescript
heroes: Hero[];
```

### 返回模拟的英雄（Return Mocked Heroes）

回到`HeroService`，将模拟的`HEROES`导入，并将其从`getHeroes`方法加以返回。我们的`HeroService`看起来像这样：

```typescript
import { Injectable } from '@angular/core'

import { Hero } from './hero'
import { HEROES } from './mock-heroes'

@Injectable()
export class HeroService {
    getHeroes(): Hero[] {
        return HEROES;
    }
}
```

### 对该英雄服务进行使用（Use the Hero Service）

现在已经准备好在以`AppComponent`开始的其它组件中使用该`HeroService`了。

与通常一样，这里以导入打算使用的东西，也就是这个`HeroService`开始。

```typescript
import { HeroService } from './hero.service'
```

该服务的导入，就允许在代码中对其加以*引用*了。那么`AppComponent`又该怎样来获取到一个运行时的具体`HeroService`示例呢（how should the `AppComponent` acquire a runtime concrete `HeroService` instance）？

### 我们要新建出该*HeroService*吗？这样做没门！
**Do we new the *HeroService*? No Way!**

这里可以使用`new`关键字，像这样来创建出一个新的`HeroService`的实例：

```typescript
heroService = new HeroService() //千万不要这样做
```

但由于包括以下这些等的诸多原因，这是一个不好的想法：

- 这样做组件就必须知道怎样来建立一个`HeroService`。如对`HeroService`构建器有所改变，就必须找到这样的建立了该服务的所有地方，并一一加以修正才行。四处给代码打补丁会造成错误，且增加测试负担。
- 在每次使用到`new`关键字时，就创建出一个服务。而加入该服务将对英雄进行缓存并与其它一些服务共享该缓存时，会怎样呢？我们不能那样做。
- 这样做就将`AppComponent`锁定到该`HeroService`的某种特定部署之中。对于不同场景要变换不同部署就将变得困难。还有就是可以离线运行吗？在测试时需要不同的模拟数据版本时会怎样呢？都不容易做到。

*如果这样...，如果那样...，就有大量的事情要做了！*

搞清楚了，肯定搞清楚了吧。但要避免这些问题却又简单得可笑，所以就没有理由犯下这个错误了。

### 注入*HeroService*

要用两行，来替换使用`new`关键字的一行语句：

1. 加入一个构建器，该构建器同时还定义出一个私有属性（we add a constructor that also defines a private property）。
2. 将`HeroService`加入到`AppComponent`组件的`providers`元数据。

下面就是这个构建器：

```typescript
constructor(private heroService: HeroService){}
```

这个构建器本身并不干什么事情。构建器的参数立即定义出一个私有的`heroService`属性，并将其标识为一个`HeroService`的注入点（the parameters simultaneously defines a private `heroService` property and identifies it as a `HeroService` injection site）。

现在Angular将获悉在其创建出一个新的`AppComponent`时，要提供到一个`HeroService`的实例。

> 在[依赖注入](https://angular.io/docs/ts/latest/guide/dependency-injection.html)章节，可了解更多有关依赖注入的知识。

现在该*注入器（injector）*还不知道如何来创建出一个`HeroService`。如现在运行我们的代码，Angular将以一个下面的错误失败：

```
EXCEPTION: No provider for HeroService! (AppComponent -> HeroService)
```

这里就要通过注册一个`HeroService`的提供者，来教会该*注入器*怎样生成一个`HeroService`（we have to teach the *injector* how to make a `HeroService` by registering a `HeroService` **provider**）。这是通过在`@Component`调用的组件元数据底部，加入下面的`providers`数组属性来完成的。

```typescript
providers: [HeroService]
```

该`providers`数组告诉Angular，在其创建某个新的`AppComponent`时，建立一个`HeroService`的全新实例。于是`AppComponent`便可以使用那个服务，来获取到英雄，同时其组件树上的所有子组件（every child component of its component tree）都可以这样做了。

### *AppComponent*中的*getHeroes*

现在已经在`heroService`这个私有变量中得到了该服务。那么就要对其加以使用了。

这里不妨停下来思考一下。我们可在一行代码中对该服务加以调用，从而获取到数据。

```typescript
this.heroes = this.heroService.getHeroes()
```

尽管不需要某个指定方法来对一行的代码进行封装。不过还是把它写成这样：

```typescript
    getHeroes(): void {
        this.heroes = this.heroService.getHeroes()
    }
```

### 引入*ngOnInit*生命周期钩子（the *ngOnInit* Lifecycle Hook）

无疑现在`AppComponent`将获取并显示出这些英雄了。那么要在什么地方来调用`getHeroes`方法呢？是在某个构建器中吗？当然不会那样做！

多年经验和血泪教训教育我们要把那些复杂逻辑排除在构建器之外，特别是那些可能会调用到服务器来作为数据访问方式的逻辑，更是要这么做（years of experience and bitter tears have taught us to keep complex logic out of the constructor, especially anything that might call a server as a data access method is sure to do）。

构建器是用于一些诸如吧构建器参数连接到属性这样的简单初始化工作的。而不是用于繁重事务。应能够在某个测试中建立一个组件，而无需担心测试会带来真实影响--比如对服务器的调用！--除非我们告诉测试真的要造成实际影响（the constructor is for simple initializations like wiring constructor parameters to properties. It's not for heavy lifting. We should be able to create a component in a test and not worry that it might do real work -- like calling a server! -- before we tell it to do so）。

既然不是由构建器来调用`getHeroes`方法，那么就必须有某种其它方式来对其进行调用。

在应用了Angular的**ngOnInit***生命周期钩子*后，Angular就将对其进行调用。Angular提供了一些在组件生命周期中的重要时刻，比如在创建、每次变化及最终销毁时，加以切入的接口（Angular offers a number of interfaces for tapping into critical moments in the component lifecycle: at creation, after each chagne, and at its eventual destruction）。

每个接口都有单个的方法。在组件应用到那个方法时，Angular就在适当时机对其进行调用。

> 在[生命周期钩子](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html)章节，可了解有关生命周期钩子的更多信息。

下面是该`OnInit`接口的基本轮廓：

```typescript
import { OnInit } from '@angular/core'

export class AppComponent implements OnInit {
    ngOnInit(): void {}
}
```

这里编写了一个其中有着初始化逻辑的`ngOnInit`方法，并将其留给Angular在正确的时间进行调用。在这个案例中，是通过调用`getHeroes`方法来完成初始化的。

```typescript
ngOnInit(): void {
    this.getHeroes()
}
```

应用将如预期那样运行、展示一个英雄清单，及在当我们点击了某个英雄名字时的一个英雄详细信息视图。

现在已经接近完成，但有些事情还是有些问题。

### 异步服务与承诺（Async Services and Promises）

这里的`HeroService`立即返回了一个模拟英雄清单。其`getHeroes`签名是同步的：

```typescript
this.heroes = this.heroService.getHeroes()
```

请求了英雄数据后，他们就立即存在于返回的结果中。

日后我们将从某个远端服务器获取到这些英雄。这里尚未调用到`http`，但后续章节会期望那样做。

当我们要从服务器获取英雄数据时，就必将等待服务器的响应，同时又因为浏览器不会阻塞用户界面（UI），从而在等待时，就算我们想要对UI进行阻塞（实际上我们不会想要这么做），也是无法做到的（we won't be able to block the UI while we wait, even if we want to(which we shouldn't) because the browser won't block）。

那么就必须要使用某种异步技巧，那样就要对这里的`getHeroes`方法进行修改了。

我们将使用到*[承诺（Promises）](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise)*。

#### Hero服务做出一个承诺（the Hero Service makes a Promise）

**承诺（Promise）**就是......，哦，就是一个在有结果后，将我们叫后去的承诺（A **Promise** is ... well it's a promise to call us back later when the results are ready）。我们请求某个异步服务来完成一些工作，并给予其一个回调函数。异步服务将确切地完成那些工作（于某处），并以工作的结果或某个错误，来调用给它的函数（we ask an asynchronous service to do some work and give it a callback function. It does that work(somewhere) and eventually it calls our function with the results of the work or an error）。

> 这里做了简化。可在[这里](http://exploringjs.com/es6/ch_promises.html)或web上的其它地方，了解有关ES2015（ES6）的Promises的更多知识。

现在使用下面的具备承诺返回（Promise-returning）的`getHeroes`方法，来更新该`HeroService`：

```typescript
getHeroes(): Promise<Hero[]> {
    return Promise.resolve(HEROES)
}
```

这里仍使用的是模拟数据。通过返回一个以模拟英雄作为结果的**立即得到解决的承诺（immediately resolved Promise）**，模拟的是一台超快的、零延迟服务器的行为。

#### 在Promise上行动（Act on the Promise）

回到`AppComponent`及其`getHeroes`方法，看到其看起来仍像下面这样：

```typescript
    getHeroes(): void {
        this.heroes = this.heroService.getHeroes()
    }
```

因为上面对`HeroService`所做出的修改，现在就要将`this.heroes`设置为一个Promise, 而不是一个英雄的数组了。

所以这里就必须将我们的部署，修改为当该*Provise被达成（解决）时，在该Promise*上执行动作（we have to change our implementation to act on *the Promise when it resolves*）。从而在该Promise成功达成时，*就*将这些英雄显示出来。

这里将我们的回调函数，作为一个参数，传递给该Promise的**`then`**方法。

```typescript
    getHeroes(): void {
        this.heroService.getHeroes().then(heroes => this.heroes = heroes)
    }
```

> 这里回调函数中的[ES2015箭头函数](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)比起等价的函数表达式更为简洁，且优雅地处理好了`this`的问题。

这里的回调函数将组件的`heroes`属性，设置为有该服务所返回的英雄数组。这就是全部的了（that's all there is to it）！

应用仍在运行中，仍旧显示出一个英雄清单，并仍对选择某个名字而响应到一个详细信息视图。

> 请查看附录的[令其慢下来](https://angular.io/docs/ts/latest/tutorial/toh-pt4.html#slow)部分，来看看在较差连接时，应用将会怎样。

### 回顾一下现在应用的结构

在完成了本章中的全部良好重构后，现在检查现在应用如下的文件结构：

![第五章-服务-文件结构](images/file-structure-part-v.png)

下面是本章中所讨论到的那些文件。

首先是 `app/hero.service.ts`:

```typescript
import { Injectable } from '@angular/core'

import { Hero } from './hero'
import { HEROES } from './mock-heroes'

@Injectable()
export class HeroService {
    getHeroes(): Promise<Hero[]> {
        return Promise.resolve(HEROES);
    }
}
```

`app/app.component.ts`:

```typescript
import { Component } from '@angular/core';
import { OnInit } from '@angular/core'

import { Hero } from './hero';
import { HeroService } from './hero.service'
import { HEROES } from './mock-heroes'

@Component({
    selector: 'my-app',
    styles: [`
        .selected {
            background-color: #CFD8DC !important;
            color: white;
        }
        .heroes {
            margin: 0 0 2em 0;
            list-style-type: none;
            padding: 0;
            width: 15em;
        }
        .heroes md-list-item {
            cursor: pointer;
            position: relative;
            left: 0;
            background-color: #EEE;
            margin: .5em;
            padding: .3em 0;
            height: 1.6em;
            border-radius: 4px;
        }
        .heroes md-list-item.selected:hover {
            background-color: #BBD8DC !important;
            color: white;
        }
        .heroes md-list-item:hover {
            color: #607D8B;
            background-color: #DDD;
            left: .1em;
        }
        .heroes .text {
            position: relative;
            top: -3px;
        }
        .heroes .badge {
            display: inline-block;
            font-size: small;
            color: white;
            padding: 0.8em 0.7em 0 0.7em;
            background-color: #607D8B;
            line-height: 1em;
            position: relative;
            left: -1px;
            top: -4px;
            height: 1.8em;
            margin-right: .8em;
            border-radius: 4px 0 0 4px;
        }
    `
    ],

    template: `
        <h1>{{title}}</h1>
        <h2>My Heroes</h2>
        <md-list class="heroes">
            <md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)"
                [class.selected]="hero === selectedHero">
                <span class="badge">{{hero.id}}</span>{{hero.name}}
            </md-list-item>
        </md-list>
        <my-hero-detail [hero]="selectedHero"></my-hero-detail>  
    `,
    providers: [HeroService],
})
export class AppComponent implements OnInit {
    title = 'Tour of Heroes'
    selectedHero: Hero
    heroes: Hero[]

    constructor(private heroService: HeroService) { }

    getHeroes(): void {
        //var that = this

        //this.heroService.getHeroes().then(function(res) {
        //    that.heroes = res;
        //})
        
        // 上面的是不用ES2015的箭头函数时的写法，下面是使用箭头函数的写法，更为简洁与优雅
        // （无需额外的that变量, 来处理`this`的问题了）
        
        this.heroService.getHeroes().then(res => this.heroes = res)
    }

    ngOnInit(): void {
        this.getHeroes()
    }

    onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }
}
```

以及`app/mock-heroes.ts`

```typescript
import { Hero } from './hero'

export const HEROES: Hero[] = [
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
]
```

### 走过的路

现在盘点一下以及建立的东西：

- 创建了一个可被多个组件共享的服务类（a service class）
- 在`AppComponent`激活时，使用了`ngOnInit`生命周期钩子，来获取我们的那些英雄
- 将`HeroService`定义为了`AppComponent`的一个提供者
- 建立了模拟英雄数据，并将它们导入到了这里的服务中
- 这里将服务设计为返回一个承诺Promise，且组件是从该Promise获取到数据的

请运行本章的[现场示例](https://angular.io/resources/live-examples/toh-4/ts/eplnkr.html)。

#### 后面的路

使用共享组件与服务后，英雄之旅应用已变得更具可重用性了。现在打算创建一个看板（dashboard）、加入在不同视图之间路由的菜单链接，并在模板中进行数据的格式操作。随着应用的进化，我们将学习对其进行怎样的设计，以令其更加易于成长和维护。

### 附录：令其慢下来

这里可模拟一个慢速连接（a slow connection）。

导入`Hero`符号，并将下面的`getHeroesSlowly`方法，加入到`HeroService`（import the `Hero` symbol and add the following `getHeroesSlowly` method to the `HeroService`, *笔者注：* 现在还没明白为啥这里要说导入`Hero`符号）:

```typescript
    getHeroesSlowly(): Promise<Hero[]> {
        return new Promise(resolve => {
            // 模拟2秒的服务器延迟
            setTimeout(() => resolve(this.getHeroes()), 2000)
        })
    }
```

就如同`getHeroes`, 函数`getHeroesSlowly`同样返回一个承诺Promise。但该Promise在以模拟英雄来解决该Promise前，要等待2秒钟时间。

回到`AppComponent`，将`heroService.getHeroes`用`heroService.getHeroesSlowly`进行替换，在看看应用将表现为怎么。


## 路由（Routing）

加入Angular路由器（the Angular Router）并学习在视图之间进行导航。

我们已经收到英雄之旅应用的新需求了：

- 添加一个*看板（Dashboard）*的视图。
- 在*多英雄*与*看板*视图之间进行导航。
- 通过在两个视图的某位英雄上点击，来导航到所选英雄的详细信息视图。
- 通过点击某个email中的*深入（deep）*链接，来打开某位特定英雄的详细信息视图。

![导航图示](images/nav-diagram.png)

这里将加入Angular的*路由器（Router）*到应用，以满足上述需求。

> [路由与导航（routing and navigation）](https://angular.io/docs/ts/latest/guide/router.html)涵盖了比起本教程更具体的有关路由器的知识。

请运行本章的[现场示例](https://angular.io/resources/live-examples/toh-5/ts/eplnkr.html)

### 上一章留下的地方

在继续英雄之旅应用之前，让我们检查一下在加入了英雄服务及英雄详细信息组件后，是否有着以下的文件结构。如不是这样，那么就要回到上一章，重新完成。

![第五部分的文件结构](images/file-structure-part-vi.png)

### 保持应用的编译（transpiling）与运行

打开一个终端/控制台窗口，并输入下面的命令来启动TypeScript编译器、启动服务器，并监视代码变化：

```bash
npm start
```

应用便运行起来，并在我们持续构建该英雄之旅时，自动更新。

### 行动计划（Action plan）

下面是我们的计划：

- 将`AppComponent`转变为仅处理导航的应用壳（an application shell）。
- 将*多英雄*关注点从当前的`AppComponent`，迁移到一个单独的`HeroesComponent`（relocate the *Heroes* concerns within the current `AppComponent` to a separate `HeroesComponent`, *译者注：* 这实际上上一步的延续，且其中的关注点concerns，就是关注点分离Separation of concerns中所指的关注点）。
- 加入路由。
- 建立一个新的`DashboardComponent`
- 将*看板（Dashboard）*捆绑到导航结构（the navigation structure）中去。

> *路由*是*导航*的另一个名称。而*路由器*则是实现视图之间导航的机制（*Routing* is another name for *navigation*. The *Router* is the mechanism for navigating from view to view）。

### 对*AppComponent* 进行拆分

当前app是装入`Appcomponent`，并立即显示出英雄清单的。

完成本章中的这些修订后的app, 应显示一个有着对各种视图（*Dashboard*及*Heroes*视图）进行选择的壳（qiao3, shell），且会默认选中它们中的一个。

组件`AppComponent`应只处理导航操作。那么就让我们将*多英雄（Heroes）*的显示，从`AppComponent`中移出，并移入到其自己的`HeroesComponent`中去吧。

#### *HeroesComponent*

`AppComponent`已经是专用于*多英雄（Heroes）*的了。这里将其命名为`HeroesComponent`, 并单独建立一个新的`AppComponent`，而无需将任何东西从`AppComponent`中移出。

那么要重命名的步骤有下面这些：

- 将`app.component.ts`重命名为`heroes.component.ts`
- 将`AppComponent`类，重命名为`HeroesComponent`（在本地进行重命名，*仅*在这个文件中）
- 将选择器`my-app`重命名为`my-heroes`

`app/hero.component.ts`（仅显示重命名的项目）

```typescript
@Component({
  selector: 'my-heroes',
})
export class HeroesComponent implements OnInit {
}
```

### 创建*AppComponent*

新的`AppComponent`将作为应用的外壳（the application shell）。它将有一些位于顶部的导航链接，以及页面下方用于所要导航到页面的一个显示区域（it will have some navigation links at the top and a display area below for the pages we navigate to）。

下面是开头的几步：

- 建立`app/app.component.ts`文件。
- 定义一个导出的`AppComponent`类。
- 在该类上面加入一个带有`my-app`选择器的`@Component`装饰器。
+ 将下面这些内容，从`HeroesComponent`移到`AppComponent`中：
   - 类熟悉`title`
   - `@Component`模板的`<h1>`元素，该元素包含了一个到`title`的绑定

- 在紧接着大标题的下面，计入一个`<my-heroes>`元素，如此就将看到那些英雄。
- 将`HeroesComponent`加入到`AppModule`的`providers`数组，如此Angular便认识`<my-heroes>`标记了。
- 将`HeroService`加入到`AppModule`的`providers`数组, 因为在其它所有视图中，都将需要该服务。
- 从`HeroesComponent`的`providers`数组中移除`HeroService`，因为该服务已被提升到`AppModule`的`providers`数组中了。
- 加入`AppComponent`中的那些支持性的`import`语句。

先期草案如下面这样：

`app/app.component.ts(v1)`:

```typescript
import { Component } from '@angular/core'

@Component ({
    selector: 'my-app',
    template: `
        <h1>{{title}}</h1>
        <my-heroes></my-heroes>
    `
})

export class AppComponent {
    title = '英雄之旅'
}
```

`app/app.module.ts(v1)`:

```typescript
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'

// 下面两个是Angular 2 Materialize 有关的导入
import { MaterialModule } from '@angular/material'
import 'hammerjs';

import { AppComponent } from './app.component';
import { HeroesComponent } from './heroes.component'
import { HeroService } from './hero.service'
import { HeroDetailComponent } from './hero-detail.component'


@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        MaterialModule.forRoot()
    ],
    providers: [
        HeroService
    ],
    declarations: [
        AppComponent,
        HeroesComponent,
        HeroDetailComponent
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
```

应用仍将运行并显示出那些英雄。这里将`AppComponent`重构为一个`AppComponent`和`HeroesComponent`成功了！我们无害地完成了这个重构（we have done no harm）。

### 加入路由（Add Routing）

现在已准备好了进行下一步。我们想要在用户点击一个按钮*之后*，才显示出那些英雄，而不是自动地显示他们。换句话说，我们是想要导航到英雄清单（we would like to navigate to the list of heroes）。

这里就需要Angular的*路由器*特性了（the Angular *Router*）。

Angular路由器，是一个外部的、可选的名为`RouterModule`的Angular NgModule。路由器是多个所提供服务（`RouterModule`）、多个指令（`RouterOutlet`、`RouterLink`、`RouterLinkActive`）以及一个配置（`Routes`）的组合（an external, optional Angular NgModule called `RouterModule`, The Router is a combination of multiple provided services(`RouterModule`)， multiple directives(`RouterOutlet`, `RouterLink`, `RouterLinkActive`), and a configuration(`Routes`)）。下面将首先配置这些路由。

#### 加入基础标记（Add the base tag）

打开`index.html`文件，在`<head>`部分的顶部加入`<base href="/">`。

`index.html(base-ref)`:

```html
<head>
    <base href="/">
```

> 这里的基本HREF是必须的（BASE HREF IS ESSENTIAL）。请查阅[路由器]章节的*基本href*部分，以了解为何这很重要。

#### 配置那些路由（Configure routes）

我们的应用现在一条路由都还没有。所以就从给应用的那些路由，建立一个配置开始（we'll start by creating a configuration for the application routes）。

*路由（Routes）*告诉路由器在用户点击某个链接或将某个URL粘贴到浏览器的地址栏时，要显示出哪个视图。

下面就让我们定义这里的第一条路由，将其定义为一个到多英雄组件的路由：

`app/app.module.ts(多英雄的路由)`：

```typescript
import { RouterModule } from '@angular/router'

RouterModule.forRoot([
    {
        path: 'heroes',
        component: HeroesComponent
    }
])
```

`Routes`就是一个*路由定义（route definitions）*的数组。此时只有一条路由定义，但请放心，后面将加入更多的路由定义。

该*路由定义*有着以下部分：

- **路径（path）**：路由器将把该路由的路径，与浏览器地址栏中的URL进行匹配（`heroes`）。
- **组件（component）**: 在导航到该路由时，路由器将创建的组件（`HeroesComponent`）。

> 在[路由（Routing）]()章节，可了解到更多有关使用`Routes`进行路由定义的知识。

#### 令到路由器可用（Make the router available）

上面已经设置好了最初的路由配置了。现在将把该路由配置，加入到`AppModule`。我们将把这里配置好的`RouterModule`，加入到`AppModule`的导入数组。

`app/app.module.ts(app 路由)`：

```typescript
import { NgModule } from '@angular/core'
import { RouterModule } from '@angular/router'
import { BrowserModule } from '@angular/platform-browser'
import { FormsModule } from '@angular/forms'

// 下面两个是 Angular 2 Materialize有关的导入
import { MaterialModule } from '@angular/material'
import 'hammerjs'

import { AppComponent } from './app.component';
import { HeroesComponent } from './heroes.component'
import { HeroService } from './hero.service'
import { HeroDetailComponent } from './hero-detail.component'


@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        MaterialModule.forRoot(),
        RouterModule.forRoot([
            {
                path: 'heroes',
                component: HeroesComponent
            }
        ])
    ],
    providers: [
        HeroService
    ],
    declarations: [
        AppComponent,
        HeroesComponent,
        HeroDetailComponent
    ],
    bootstrap: [AppComponent]
})
export class AppModule {
}
```

> 这里使用了`forRoot`方法，这是因为这里是将一个配置好的路由器，在应用的*根*处加以提供的。该`forRoot`方法给出了路由所需的多条路由器服务提供者及指令，并完成给予当前浏览器URL的早期导航（we use the `forRoot` method because we're providing a configured router at the *root* of the application. The `forRoot` method gives us the Router service providers and directives needed for routing, and performs the initial navigation based on the current browser URL）。

#### 关于路由器出口（Router Outlet）

加入现在将该路径`/heroes`粘贴到浏览器的地址栏，那么该路由器将匹配其到这个`heroes`路由，并显示出`HeroesComponent`，但是要在哪里显示呢（if we paste the path, `/heroes`, inot the browser address bar, the router should match it to the `heroes` route and display the `HeroesComponent`. But where）？

因此就必须要通过在模板（the template, 指的是应用外壳的模板了）的底部，加入一个`<router-outlet>`元素，来***告诉路由器在哪里***显示`HeroesComponent`。`RouterOutlet`指令是由`RouterModule`所提供的指令之一。在我们贯穿整个应用进行导航时，路由器将在`<router-outlet>`之下，立即显示出各个组件。

#### 路由器链接（Router Links）

我们肯定不期望由用户来将某条路由URL粘贴到地址栏的。所以就要将一个锚点标记, 加入到模板（*译者注*：当然也是指应用外壳组件的模板），在点击该锚点标记时，就激发到`HeroesComponent`组件的导航。

请注意该锚点标记中的`routerLink`绑定。这里将该`RouterLink`指令（`RouterModule`诸多指令中的另一个）, 绑定到一个告诉路由器在用户点击该链接时，导航到某个地方的字符串（we bind the `RouterLink` directive(another of the `RouterModule` directives) to a string that tells the router where to navigate when the user clicks the link）。

因为这里的链接不是动态的，所以我们使用了一个**一次性绑定（one-time binding）**，将一个*路由指令（routing instruction）*，绑定到这里的路由**路径（path）**。再回头看看上面的路由定义，就可以确认那个`/heroes`就是到`HeroesComponent`的路由的路径。

> 在[路由]()章节，可了解更多有关动态路由器链接及*链接参数数组*有关的知识（dynamic router links and the *link parameters array*）。

请刷新浏览器。将仅看到该应用的标题和一个多英雄链接了。而再不会看到英雄清单。

> 此时浏览器地址栏显示的是`/`。到`HeroesComponent`的路由路径是`/heroes`， 而不是`/`。现在还没有匹配路径`/`的一条路由，因此没有显示的内容。那就是我们将要修复的问题了。

点击该*Heroes*导航链接，浏览器地址栏将被更新到`/heroes`，同时现在就看到了英雄清单。现在终于在导航了啊！

此阶段的`AppComponent`看起来像下面这样。

`app/app.component.ts(v2)`:

```typescript
import { Component } from '@angular/core'

@Component ({
    selector: 'my-app',
    template: `
        <h1>{{title}}</h1>
        <a routerLink="/heroes">Heroes</a>
        <router-outlet></router-outlet>
    `
})

export class AppComponent {
    title = '英雄之旅'
}
```

现在的*AppComponent*附加到了一条路由器上，且显示那些受路由的视图（The *AppComponent* is now attached to a router and displaying routed views）。因为这个原因，且为将其与其它类型的组件有所区别，我们将这类组件叫做*路由器组件（a Router Component）*。

### 加入一个*看板（Dashboard）*

只有在有着多个视图时，路由才有意义。所以我们需要另一个视图。

这里要建立一个给到我们所要导航至某处并从该处进行导航的`DashboardComponent`占位符（create a placeholder `DashboardComponent` that gives us something to navigate to and from）。

`app/dashboard.component.ts(v1)`:

```typescript
import { Component } from '@angular/core'

@Component ({
    selector: 'my-dashboard',
    template: `
        <h3>My Dashboard</h3>
    `
})

export class DashboardComponent {}
```

后面我们将回到这里并令其更为有用。

#### 配置该看板的路由（Configure the dashboard route）

回到`app.module.ts`并教会其导航到看板。

导入该看板组件，并将下面的路由定义添加到`Routes`的定义数组（the `Routes` array of definitions）。

`app/app.module.ts(看板路由部分)`：

```typescript
{
    path: 'dashboard',
    component: DashboardComponent
}
```

同时还要将`DashboardComponent`导入并添加到`AppModule`的`declarations`。

`app/app.module.ts(看板部分)`:

```typescript
declarations: [
    AppComponent,
    HeroesComponent,
    HeroDetailComponent,
    DashboardComponent
]
```

### 重定向到（REDIRECTTO）

这里打算在应用启动时显示出看板，且想要在浏览器的地址栏看到一个美观的URL为`/dashboard`。但请记住目前浏览器地址栏中现在还显示的是`/`。

这里可以使用一个重定向路由（a redirect route）来达到这个目的。将下面的代码，加入到路由定义数组中：

`app/app.module.ts(重定向)`：

```typescript
{
    path: '',
    redirectTo: '/dashboard',
    pathMatch: 'full'
}
```

> 在[路由](https://angular.io/docs/ts/latest/guide/router.html#redirect)章节，可了解到更多有关*重定向（redirects）*的知识。

#### 将导航添加到模板（ADD NAVIGATION TO THE TEMPLATE）

最后，将一个看板的导航链接添加到模板，就如同上面的*Heroes*链接一样。

`app/app.component.ts(模板-v3)`:

```typescript
import { Component } from '@angular/core'

@Component ({
    selector: 'my-app',
    template: `
        <md-toolbar layout="row" class="md-whiteframe-z3">
            <span class="fill-remaining-space">{{title}}</span>
            <span class="fill-remaining-space" routerLink="/dashboard">Dashboard</span>
            <span class="fill-remaining-space" routerLink="/heroes">Heroes</span>
        </md-toolbar>
        <router-outlet></router-outlet>
    `
})

export class AppComponent {
    title = '英雄之旅'
}
```

前往到应用的根处（`/`）并重新载入，就可以在浏览器中看到改变。应用将显示出看板，同时我们可以在看板和多英雄视图之间进行导航。

### 将顶级英雄放入看板（Dashboard Top Heroes）

这里将通过将四位顶级英雄醒目地显示出来的方式，令到看板更为有趣。

这里使用了一个指向到一个新的模板文件的`templateUrl`属性（a `templateUrl` property that points to a new template file），对`template`元数据进行替换。

同时为解决该`templateUrl`的模块有关的装入问题，而将`moduleId`属性设置为了`module.id`（set the `moduleId` property to `module.id` for module-relative of the `templateUrl`，*译者注：*这里的`module.id`会在NetBeans中报错，后续会解释其用途）。

`app/dashboard.component.ts(元数据部分)`：

```typescript
import { Component } from '@angular/core'

@Component ({
    moduleId: module.id,
    selector: 'my-dashboard',
    templateUrl: 'dashboard.component.html'
})

export class DashboardComponent {}
```

使用下面的内容来建立那个模板文件：

`app/dashboard.component.html`:

```typescript
<h3>Top Heroes</h3>
<md-grid-list cols="4">
    <md-grid-tile *ngFor="let hero of heroes">
        <div class="module hero">
            <h4>{{hero.name}}</h4>
        </div>
    </md-grid-tile>
</md-grid-list>
```

这里再度使用了`*ngFor`以对一个英雄清单进行遍历并显示他们的名字。还加入了一个额外的`<div>`元素，来帮助本章后面的样式添加。

#### 共享*HeroService*

我们偏向重用前面所建立的`HeroService`，来生成该组件的`heroes`数组。

请回忆一下早前将`HeroService`从`HeroesComponent`的`providers`数组移除，并将其加入到`AppModule`的`providers`的那一章。

该移动就建立两个一个单独的`HeroService`实例，该实例是对应用的*所有*组件可用的。Angular将注入`HeroService`，且我们将在这里的`DashboardComponent`中对其加以使用。

#### 获取到英雄

打开`dashboard.component.ts`文件，并加入一些必要的`import`语句。

`app/dashboard.component.ts(导入部分)`:

```typescript
import { Component, OnInit } from '@angular/core'

import { Hero } from './hero'
import { HeroService } from './hero.service'
```

现在像下面这样来实现`DashboardComponent`类：

`app/dashboard.component.ts(类的部分)`：

```typescript
export class DashboardComponent implements OnInit {
    heroes: Hero[]
    
    constructor(private heroService: HeroService){}
    
    ngOnInit(): void {
        this.heroService.getHeroes()
            .then(res => this.heroes = res.slice(1, 5))
    }
}
```

在之前的`HeroesComponent`中，我们已经看到过此种逻辑了：

- 定义一个`heroes`数组属性。
- 在那个构建器中注入`HeroService`并将其保留在一个私有的`heroService`字段中（a private `heroService` field）。
- 在Angular的`ngOnInit`生命周期钩子内部，调用该服务来获取到英雄

在这个看板中，我们使用`Array.slice`方法，择优挑选（cherry-pick）了4名英雄（第二、第三、第四和第五名）。

刷新浏览器就可以在新的看板中看到4名英雄。

### 导航到英雄详细信息

虽然我们在`HeroesComponent`的底部显示出了所选英雄的详细信息，但现在仍然没有以需求中的三种指定方式，来导航到`HeroDetailComponent`：

- 从*看板*导航到某名选定的英雄。
- 从*多英雄*清单导航到某名选定英雄。
- 从粘贴到浏览器地址栏的某个“深链接（deep link）”URL导航到某名英雄。

那么显而易见，加入一个英雄详细信息路由，就是现在要开始的地方了。

#### 路由到某个英雄详细信息

这里将在`app.module.ts`中，也就是其它路由所配置的地方，加入一条到`HeroDetailComponent`的路由。

比起前面的那些路由，这条新的路由有着些许不同，在该路由中，我们必须告诉`HeroDetailComponent`*要显示哪名英雄*。而在上面的`HeroesComponent`或`DashboardComponent`中，是不必告诉它们什么的。

此时，父组件`HeroesComponent`通过一个下面的绑定，将`HeroDetailComponent`的`hero`属性设置为一个英雄对象（a hero object）。

```html
<my-hero-detail [hero]="selectedHero"></my-hero-detail>
```

那种做法无疑在所有的路由场景都不会工作起来。在最后一种情况下当然也不行；原因在于我们是无法将整个的英雄对象嵌入到URL中的！同时我们也不会想要那样做（that clearly won't work in any of our routing scenarios. Certainly not the last one; we can't embed an entire hero object in the URL! Nor would we want to）。

#### 参数化的路由（Parameterized route）

这里可将英雄的`id`加入到URL。比如在路由至某名`id`为11的英雄时，就可以期望看到一个像下面这样的URL：

```javascript
/detail/11
```

那个URL中的`/detail/`部分，是一个常量。跟着的数字`id`部分就随英雄的不同而变化。这就需要使用一个代表英雄`id`的*参数或令牌（a parameter(or token)），来表示该路由的可变部分。

#### 配置有着一个参数的路由（Configure a Route with a Parameter）

下面就是将用到的*路由定义（route definition）*:

```typescript
{
    path: 'detail/:id',
    component: HeroDetailComponent
}
```

路径中的冒号（`:`），表明`:id`是一个在导航至`HeroDetailComponent`时，将用某个特定英雄`id`填充的占位符。

这里就完成了本应用的路由配置了（we're finished with the application routes）。

这里不会将一个`Hero Detail`链接，添加到应用外壳`app.component.ts`的模板，因为用户不会去点击导航*链接*来查看某名特定英雄。他们会点击现实在看板上或英雄清单中的某名*英雄*。

在本章后面，我们将获取到这些英雄的点击。在将`HeroDetailComponent`准备好被导航之前，都没有要对这些点击进行处理的切入点（we'll get to those *hero* clicks later in the chapter. There's no point in working on them until the `HeroDetailComponent` is ready to be navigated to）。

而要将`HeroDetailComponent`准备好被导航，就需要对其进行大的改动。

### 修订*HeroDetailComponent*（Revise the *HeroDetailComponent*）

在重新编写`HeroDetailComponent`之前，先来看看它现在的样子：

```typescript
import { Component, Input } from '@angular/core'

import { Hero } from './hero';

@Component({
    selector: 'my-hero-detail',
    template: `
        <div *ngIf="hero != undefined">
            <h2>{{hero.name}} details!</h2>
            <div><label>id: </label>{{hero.id}}</div>
            <md-input-container>
                <input md-input id="name" [(ngModel)]="hero.name" placeholder="名 字" />
            </md-input-container>
        </div>
    `
})

export class HeroDetailComponent {
    @Input()
    hero: Hero;
}
```

其模板不会改动。我们将以同样方式来显示某名英雄。大的变动在于我们以何种方式来获取到英雄。

这里将不再从某个父组件的属性绑定（property binding）中接收英雄。新的`HeroDetailComponent`应从于`ActivatedRoute`服务中可观察到的`params`中，取得`id`参数，并使用`HeroService`以该`id`来获取到对应英雄（the new `HeroDetailComponent` should take the `id` from the `params` observable in the `ActivatedRoute` service and use the `HeroService` to fetch the hero with that `id`）。

首先，加入必要的一些导入：

```typescript
import { Component, Input, OnInit } from '@angular/core'
import { ActivatedRoute, Params } from '@angular/router'
import { Location } from '@angular/common'

import { HeroService } from './hero.service'
```

接着将`ActivatedRoute`服务、`HeroService`与`Location`服务都注入到构建器中，将它们的值保存在一些私有字段中（let's have the `ActivatedRoute` service, the `HeroService` and the `Location` service injected into the constructor, saving their values in private fields）:

```typescript
    constructor(
        private heroService: HeroService,
        private route: ActivatedRoute,
        private location: Location
    ) {}
```

还要导入`switchMap`操作符，以便稍后与路由参数`Observable`一同使用（also import the `switchMap` operator to use later with the route parameter `Observable`）。

```typescript
import 'rxjs/add/operator/switchMap'
```

告诉该类我们打算应用`OnInit`接口。

```typescript
export class HeroDetailComponent implements OnInit {
}
```

在`ngOnInit`生命周期钩子内部，使用`params`这个可观测量（the `params` observable），从`ActivatedRoute`服务提取出`id`这个参数值，并使用`HeroService`来获取到有着那个`id`的英雄。

```typescript
    ngOnInit(): void {
        this.route.params
            .switchMap((params: Params) => this.heroService.getHero(+params['id']))
            .subscribe(hero => this.hero = hero)
    }
```

请留意这里的`switchMap`操作符，是如何将可观察到的路由参数中的id映射到一个新的、`HeroService.getHero`方法的结果的`Observable`的（note that the `switchMap` operator maps the id in the observable route parameters to a new `Observable`, the result of the `HeroService.getHero` method）。

假如在某个`getHero`请求仍在进行时，用户再度导航到此组件，那么`switchMap`就在重新调用`HeroService.getHero`之前，取消原来的请求（if the user re-navigates to this component while a `getHero` request is still inflight, `switchMap` cancels that old request before calling `HeroService.getHero` again）。

英雄`id`是一个数字。路由参数却*始终是字符串*（the hero `id` is number. Route parameters are *always string*）。因此这里使用JavaScript的加号（`+`）运算符，将路由参数转换成数字。

> **这里需要取消订阅吗（do I need to unsubscribe）？**
> 路由器管理着其所提供的那些可观察量，并对那些订阅加以本地化。在组件销毁时，那些订阅也就被清理掉了，从而保护了不受内存泄露的威胁，因此我们是不需要从路由参数`Observable`进行取消订阅的（the `Router` manages the `observables` it provides and localizes the subscriptions. The subscriptions are cleaned up when the component is destroyed, protecting against memory leaks, so we don't need to *unsubscribe* from the route params `Observable`）。

### 加入*HeroService.getHero*

现在这些代码的问题在于，`HeroService`还没有那个`getHero`方法！在有人注意到我们破坏了应用之前，最好赶快修复这个问题。

打开`HeroService`并加入这个使用`id`，来对来自`getHeroes`的英雄清单加以过滤的`getHero`方法：

```typescript
    getHero(id: Number): Promise<Hero> {
        return this.getHeroes()
            .then(heroes => heroes.find(hero => hero.id === id))
    }
```

然后回到`HeroDetailComponent`去清理掉一些尾巴（let's return to the `HeroDetailComponent` clean up loose ends）。

#### 找出一条回去的路（Find our way back）

可以多种方式导航到`HeroDetailComponent`。而在已导航到`HeroDetailComponent`时，又该怎样导航到其它地方呢？

用户可以点击`AppComponent`中两个链接之一。或是点击浏览器的后退按钮。我们将加入第三选项，一个使用到先前注入的`Location`服务、依据浏览器的历史堆栈，来完成后退一步导航的`goBack`方法。

```typescript
    goBack(): void {
        this.location.back()
    }
```

> 退回太远，可能会将我们带出该应用。那样做在应用的演示中可以接受。在真是应用中，就要避免这类问题的发生，一种办法就是使用[`CanDeactivate`接口防护](https://angular.io/docs/ts/latest/api/router/index/CanDeactivate-interface.html)。

随后用一个事件绑定，将该方法与一个添加在组件模板底部的*后退*按钮连接起来。

```html
<button (click)="goBack()">Back</button>
```

对模板进行修改以加入该按钮，这就激励我们要采取另一项更进一步的改进，并将模板移到其自己的文件，名为`hero-detail.component.html`：

`app/hero-detail.component.html`:

```html
        <div *ngIf="hero != undefined">
            <h2>{{hero.name}} details!</h2>
            <div><label>id: </label>{{hero.id}}</div>
            <md-input-container>
                <input md-input id="name" [(ngModel)]="hero.name" placeholder="名 字" />
            </md-input-container>
            <md-button (click)="goBack()">Back</md-button>
        </div>
```

这里以一个`moduleId`及一个指向刚刚建立的模板文件的`templateUrl`，对组件的元数据加以更新。

`app/hero-detail.component.ts(元数据部分)`：

```typescript
@Component({
    moduleId: module.id,
    selector: 'my-hero-detail',
    templateUrl: 'app/hero-detail.component.html'
})
```

请刷新浏览器并查看结果。

### 选择一名*看板*英雄

在用户选择了一名看板中的英雄时，应用应导航到`HeroDetailComponent`，以查看并对所选加以编辑。

尽管这些看板英雄是以类似于按钮块的方式呈现的，他们却与锚点标记表现类似。在鼠标通过某个英雄块时，目标URL应现实在浏览器状态栏中，同时用户应能够将其链接进行拷贝，或是在新的标签页中打开英雄详细信息视图。

为达到这种效果，请重新打开`dashboard.component.html`，将重复的`<div *ngFor...>`标记，用`<a>`标记进行替换。该开放的`<a>`看起来像下面这样：

`app/dashboard.component.html(重复的<a>标记)`：

```html
<a *ngFor="let hero of heroes" [routerLink]="['./detail', hero.id]">
```

请注意这里的`[routerLink]`绑定（the `[routerLink]` binding）。

`AppComponent`的模板中的顶级导航，有着一个被设置为目的路由的固定路径的路由器链接，`/dashboard`与`/heroes`。

这次，我们绑定到一个包含了**链接参数数组**的表达式（an expression containing **link parameters array**）。该数组有两个元素，分别是目的路由的***路径（path）***, 以及被一个设置为当前英雄`id`值的***路由参数（route parameter）***。

这两个数组条目在本章早先加入到`app.module.ts`的参数化`HeroDetailComponent`路由定义中，是以***path***及***:id****对准的。

`app/app.module.ts(英雄详细信息路由定义)`：

```typescript
            {
                path: 'detail/:id',
                component: HeroDetailComponent
            }
```

刷新浏览器并从看板中选择一名英雄；应用应直接导航到该名英雄的详细信息。

### 将这些路由重构为一个*路由模块*（Refactor routes to a *Routing Module*）

`AppModule`的将近20行，用于了4条路由的配置。大多数应用都有着多得多的路由，且它们还[加入了防护服务](https://angular.io/docs/ts/latest/guide/router.html#guards)来保护应用不受不想要的或是未授权的导航的影响。路由方面的事项，将很快主导这个模块，从而混淆了其主要目的，`app.module.ts`模块的主要目的是为Angular编译器，建立有关整个应用的一些关键信息（most applications have many more routes and they add guard services to protect against unwanted or unauthorized navigations. Routing considerations could quickly dominate this module and obscure its primary purpose which is to establish key facts about the entire app for the Angular compiler）。

所以应将路由配置，重构到其自己的类中。那么要哪种类呢？当前的`RouterModule.forRoot()`生成了一个Angular的`ModuleWithProviders`，其表明一个专属于路由的类应是某种类型的模块。那应是一个[*路由模块（Routing Module）*](https://angular.io/docs/ts/latest/guide/router.html#routing-module)（what kind of class? The current `RouterModule.forRoot()` produces an Angular `ModuleWithProviders` which suggests that a class dedicated to routing should be some kind of module. It should be a *Routing Module*）。

依命名规则，那么某个*路由模块*的名称，就包含了一个“Routing”，同时与声明所要导航到的组件的该模块的名称放在一起（by convention the name of a *Routing Module* contains the word "Routing" and aligns with the name of the module that declares the component navigated to）。

现在建立一个`app-routing.module.ts`，作为`app.module.ts`的表亲。给予其从`AppModule`类提取出的以下内容：

```typescript
import { NgModule } from '@angular/core'
import { RouterModule, Routes } from '@angular/router'

import { HeroesComponent } from './heroes.component'
import { HeroDetailComponent } from './hero-detail.component'
import { DashboardComponent } from './dashboard.component'

const routes: Routes = [
    { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
    { path: 'dashboard', component: DashboardComponent },
    { path: 'detail/:id', component: HeroDetailComponent },
    { path: 'heroes', component: HeroesComponent }
]

@NgModule({
    imports: [ RouterModule.forRoot(routes) ],
    exports: [ RouterModule ]
})

export class AppRoutingModule {}
```

*路由模块（Rooting Modules）*的一些典型的值得注意的地方，有下面这些：

- 将那些路由拉入到一个变量中。后期可能会将该变量进行导出，同时其鉴别出某个*路由模块*的模式（pulls the routes into a variable. You might export it in future and it clarifies the *Routing Module* pattern）。
- 将`RouterModule.forRoot(routes)`添加到`imports`。
- 将`RouterModule`添加到`exports`，从而其同伴模块中的那些组件，就能访问到诸如`RouterLink`及`RouterOutlet`这样的路由器声明了（adds `RouterModule` to `exports` so that the components in the companion module have access to Router declarables such as `RouterLink` and `RouterOutlet`）。
- 路由模块中是没有`declarations`的！声明是同伴模块的责任（no `declarations`! Declarations are the responsibility of the companion module）。
- 在使用到一些防护服务时，要加入那些防护服务的模块提供者`providers`；在本示例中没有用到防护服务。

#### 更新*AppModule*

现在要从`AppModule`中删除路由配置，并导入`AppRoutingModule`（要同时使用ES的`import`语句，*以及*将其加入到`NgModule.imports`清单）。

`app/app.module.ts(更新之后)`：

```typescript
import { NgModule } from '@angular/core'
import { BrowserModule } from '@angular/platform-browser'
import { FormsModule } from '@angular/forms'

// 下面两个是 Angular 2 Materialize有关的导入
import { MaterialModule } from '@angular/material'
import 'hammerjs'

import { AppComponent } from './app.component'
import { DashboardComponent } from './dashboard.component'
import { HeroDetailComponent } from './hero-detail.component'
import { HeroesComponent } from './heroes.component'
import { HeroService } from './hero.service'

import { AppRoutingModule } from './app-routing.module'

@NgModule({
    imports: [
        BrowserModule,
        FormsModule,
        MaterialModule.forRoot(),
        AppRoutingModule
    ],
    providers: [
        HeroService
    ],
    declarations: [
        AppComponent,
        HeroesComponent,
        HeroDetailComponent,
        DashboardComponent
    ],
    bootstrap: [AppComponent]
})
export class AppModule {}
```

`app/app.module.ts(之前)`：

```typescript
import { NgModule }       from '@angular/core';
import { BrowserModule }  from '@angular/platform-browser';
import { FormsModule }    from '@angular/forms';
import { RouterModule }   from '@angular/router';
import { AppComponent }        from './app.component';
import { HeroDetailComponent } from './hero-detail.component';
import { DashboardComponent }  from './dashboard.component';
import { HeroesComponent }     from './heroes.component';
import { HeroService }         from './hero.service';
@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    RouterModule.forRoot([
      {
        path: '',
        redirectTo: '/dashboard',
        pathMatch: 'full'
      },
      {
        path: 'dashboard',
        component: DashboardComponent
      },
      {
        path: 'detail/:id',
        component: HeroDetailComponent
      },
      {
        path: 'heroes',
        component: HeroesComponent
      }
    ])
  ],
  declarations: [
    AppComponent,
    DashboardComponent,
    HeroDetailComponent,
    HeroesComponent
  ],
  providers: [
    HeroService
  ],
  bootstrap: [ AppComponent ]
})
export class AppModule {}
```

现在的`app.module.ts`更简单了，且着重于标识应用的关键部分。

### 选择*HeroesComponent*中英雄

前面我们加入了从看板选择英雄的能力。我们将对`HeroesComponent`做一些类似的改动。

`HeroesComponent`的模板展示一个在顶部有着英雄清单、底部有着所选英雄的详细信息的`master/detail`样式。

`app/heroes.component.ts(当前模板)`：

```typescript
template: `
        <h2>My Heroes</h2>
        <md-list class="heroes">
            <md-list-item *ngFor="let hero of heroes" (click)="onSelect(hero)"
                [class.selected]="hero === selectedHero">
                <span class="badge">{{hero.id}}</span>{{hero.name}}
            </md-list-item>
        </md-list>
        <my-hero-detail [hero]="selectedHero"></my-hero-detail>  
    `
```

这里的目标是将详细信息移到其自己的视图，并在用户决定编辑所选英雄时，导航到详细信息视图。

先删除顶部的`<h1>`（在`AppComponent`到`HeroesComponent`的转换过程中忘记了的）。

删除有着`<my-hero-detail>`标签的模板最后一行。

这里将不再现实完整的`HeroDetailComponent`了。如同在看板中那样，我们将要在其自己的页面现实英雄的详细信息，并路由至该页面。

这里将为变化而抛出一个小的变种。我们将保留"master/detail"样式，但会将详细信息收缩为一个“mini”样式、只读版本（we'll throw in a small twist for variety. We are keeping the "master/detail" style but shrinking the detail to a "mini", read-only version）。在用户从清单选择了一名英雄时，将*不*前往详细信息页。而是在*该*页上显示一个*mini-detail*, 并让用户点击一个按钮来前往到*完整详细信息(full detail)*页面。

#### 加入*mini-detail*

在`HeroesComponent`的模板底部，原来`<my-hero-detail>`所在的地方，加入下面的HTML片段：

```html
        <div *ngIf="selectedHero != undefined">
            <h2>
                {{selectedHero.name | uppercase}} is my hero
            </h2>
            <button md-button (click)="gotoDetail()">View Details</button>
        </div>
```

在点击了某名英雄后，用户应看到在英雄清单下有着下面的显示：

![mini hero detail](images/mini-hero-detail.png)

### 使用*uppercase*管道进行格式化（Format with the *uppercase* pipe）

请留意英雄名字是以大写字母（CAPITAL LETTERS）显示的。那是放入那个插值绑定中的`uppercase`管道的效果。在管道操作符（`|`）的右边可以找到它。

```typescript
{{selectedHero.name | uppercase}} is my hero
```

用于对字符串、货币数量、日期及其它显示数据进行格式化，管道是一种不错的方法。Angular本身就带有多种管道，同时我们也可以编写自己的管道。

> 在[管道](https://angular.io/docs/ts/latest/guide/pipes.html)章节，可以了解更多有关管道的知识。

#### 将内容从组件文件移除（Move content out of the component file）

现在还没完工。还必须更新组件类，来支持在用户点击*查看详细信息*按钮时，到`HeroDetailComponent`的导航。

该组件文件已经相当大了。占其绝大部分的，不是模板就是CSS样式了。在HTML和CSS的干扰下，难于找到组件的逻辑。

那么在做出更多改变之前，就让我们将模板和样式迁移到它们自己的文件中吧：

1. 将模板内容，*剪切-并-粘贴（cut-and-paste）*到一个新的`heroes.component.html`文件中。
2. 将样式内容，*剪切-并-粘贴（cut-and-paste）*到一个新的`heroes.component.css`文件中。
3. 将组件元数据的`templateUrl`与`styleUrls`属性，分别设置为到这两个文件的引用。
4. 将组件元数据的`moduleId`属性，设置为`module.id`，如此`templateUrl`与`styleUrls`便是相对于该组件的了（*Set* the `moduleId` property to `module.id` so that `templateUrl` and `styleUrls` are relative to the component， *译者注：*这里谈到了组件元数据中`moduleId`的意义，但仍未能解决NetBeans中`module.id`报错的问题）。

> 属性`styleUrls`是一个样式文件名的数组（带有路径）。在需要多个样式文件时，可将这些多个不同地方的样式文件，在该数组中列出。

`app/heroes.component.ts(修订后的元数据部分)`：

```typescript
@Component({
    moduleId: module.id,
    selector: 'my-heroes',
    styleUrls: ['heroes.component.css'],
    templateUrl: 'heroes.component.html'
})
```

#### 更新*HeroesComponent*类

`HeroesComponent`以导航到`HeroDetailComponent`来响应按钮的点击。该按钮的*点击（click）*事件被绑定到`gotoDetail`方法，该方法通过告诉路由器要去往那里，而*命令式地*进行导航（the button's *click* event is bound to a `gotoDetail` method that navigates *imperatively* by telling the router where to go）。

这样做需要对该组件类进行一些改变：

1. 从Angular的路由器库（the Angular router library）导入`router`
2. 在构建器中注入该`router`（与`HeroService`一起）
3. 通过调用`router.navigate`方法，实现`gotoDetail`

`app/heroes.component.ts(gotoDetail方法)`：

```typescript
    gotoDetail(): void {
        this.router.navigate(['/detail', this.selectedHero.id])
    }
```

请注意这里传递了一个两元素的**链接参数数组**--分别为一个路径及路由参数--到`router.navigate`方法，这与我们前面在`DashboardComponent`中，在`[routerLink`绑定中所作的一样（note that we're passing a two-element **link parms array** -- a path and the route parameter -- to the `router.navigate` method just as we did in the `[routerLink]` binding back in the `DashboardComponent`）。下面是完整的修订后的`HeroesComponent`类：

`app/heroes.component.ts(类的部分)`：

```typescript
export class HeroesComponent implements OnInit {
    selectedHero: Hero
    heroes: Hero[]

    constructor(
        private router: Router,
        private heroService: HeroService
    ) { }
    
    gotoDetail(): void {
        this.router.navigate(['/detail', this.selectedHero.id])
    }

    getHeroes(): void {
        //var that = this

        //this.heroService.getHeroes().then(function(res) {
        //    that.heroes = res;
        //})

        // 上面的是不用ES2015的箭头函数时的写法，下面是使用箭头函数的写法，更为简洁与优雅
        // （无需额外的that变量, 来处理`this`的问题了）

        this.heroService.getHeroes().then(res => this.heroes = res)
    }

    ngOnInit(): void {
        this.getHeroes()
    }

    onSelect(hero: Hero): void {
        this.selectedHero = hero;
    }
}
```

刷新浏览器并开始点击。我们现在可在app中四处导航了，可以从看板到英雄详细信息并返回，从英雄清单到mini的相信信息到英雄详细信息，并再度返回到多英雄试图。还可以通过浏览器的前进后退按钮，在看板和多英雄试图之间跳转。

现在已经满足了推动本章的那些导航方面的需求了。

### 给应用加上样式（Styling the App）

该app已具备了相应功能，但看起来相当的难看（the app is functional but pretty ugly）。我们的创意设计师团队（creative designer team）提供了一些将令其有更好观感的CSS文件。

#### 有着样式的看板（a Dashboard with Style）

设计师们认为，应以一行的矩形来显示看板。为此，他们已经给了我们大约60行的、包含了一些简单用于响应式设计的媒体查询的CSS（~60 lines of CSS for this purpose including some simple media queries for responsive design）。

加入我们直接把这60行CSS代码粘贴到组件的`styles`元数据，这些代码将完全掩盖掉组件逻辑。所以我们不会那样做。在单独的`*.css`文件中编辑CSS也更为容易一些。

将一个`dashboard.component.css`文件加入到`app`文件夹，并在组件元数据的`styleUrls`数组熟悉中像下面这样，对那个文件进行引用：

`app/dashboard.component.ts(styleUrls部分)`：

```typescript
styleUrls: ['dashboard.component.css']
```

### 给英雄相信信息加上样式（Stylish Hero Details）

设计师还给了我们特别用于`HeroDetailComponent`的CSS样式集。

跟对`DashboardComponent`所做的一样，将一个`hero-detail.component.css`文件添加到`app`文件夹，并在`styleUrls`数组中对那个文件加以引用。同时还要将`hero`属性的`@Input`装饰器和其导入移除。

`app/hero-detail.component.css`:

```css
label {
  display: inline-block;
  width: 3em;
  margin: .5em 0;
  color: #607D8B;
  font-weight: bold;
}
input {
  height: 2em;
  font-size: 1em;
  padding-left: .4em;
}
button {
  margin-top: 20px;
  font-family: Arial;
  background-color: #eee;
  border: none;
  padding: 5px 10px;
  border-radius: 4px;
  cursor: pointer; cursor: hand;
}
button:hover {
  background-color: #cfd8dc;
}
button:disabled {
  background-color: #eee;
  color: #ccc; 
  cursor: auto;
}
```

`app/dashboard.component.css`:

```typescript
[class*='col-'] {
  float: left;
  padding-right: 20px;
  padding-bottom: 20px;
}
[class*='col-']:last-of-type {
  padding-right: 0;
}
a {
  text-decoration: none;
}
*, *:after, *:before {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
h3 {
  text-align: center; margin-bottom: 0;
}
h4 {
  position: relative;
}
.grid {
  margin: 0;
}
.col-1-4 {
  width: 25%;
}
.module {
  padding: 20px;
  text-align: center;
  color: #eee;
  max-height: 120px;
  min-width: 120px;
  background-color: #607D8B;
  border-radius: 2px;
}
.module:hover {
  background-color: #EEE;
  cursor: pointer;
  color: #607d8b;
}
.grid-pad {
  padding: 10px 0;
}
.grid-pad > [class*='col-']:last-of-type {
  padding-right: 20px;
}
@media (max-width: 600px) {
  .module {
    font-size: 10px;
    max-height: 75px; }
}
@media (max-width: 1024px) {
  .grid {
    margin: 0;
  }
  .module {
    min-width: 60px;
  }
}
```

### 给导航链接加上样式

设计师们给了我们将那些`AppComponent`导航链接，变得更像是可选择的按钮。我们与设计师们是通过将这些链接包含在`<nav>`标记中，进行合作的。

加入一个有着下面内容的`app.component.css`文件到`app`文件夹中。

`app/app.component.css(导航样式)`：

```css
h1 {
  font-size: 1.2em;
  color: #999;
  margin-bottom: 0;
}
h2 {
  font-size: 2em;
  margin-top: 0;
  padding-top: 0;
}
nav a {
  padding: 5px 10px;
  text-decoration: none;
  margin-top: 10px;
  display: inline-block;
  background-color: #eee;
  border-radius: 4px;
}
nav a:visited, a:link {
  color: #607D8B;
}
nav a:hover {
  color: #039be5;
  background-color: #CFD8DC;
}
nav a.active {
  color: #039be5;
}
```

> **关于*RouterLinkActive*指令**
> Angular路由器提供了一个`RouterLinkActive`指令，我们可使用该指令将某个类，添加给其路由与当前活动的路由匹配的HTML导航元素。那么我们必须做的就只有为其定义样式就行了。相当不错的指令（the Angular Router provides a `RouterLinkActive` directive we can use to add a class to the HTML navigation element whose route matches the active route. All we have to do is define the style for it. Sweet)!

`app/app.component.ts(关于活动路由器链接)`：

```typescript
template: `
  <h1>{{title}}</h1>
  <nav>
    <a routerLink="/dashboard" routerLinkActive="active">Dashboard</a>
    <a routerLink="/heroes" routerLinkActive="active">Heroes</a>
  </nav>
  <router-outlet></router-outlet>
`,
```

首先将`moduleId: module.id`加入到`AppComponent`的元数据，以启用*模块相关的（module-relative）*文件URLs（*译者注：*这里再度提到了`moduleId: module.id`，所以有必要搞清楚其到底是个什么东西, 可参考[这里](http://stackoverflow.com/questions/37178192/angular2-what-is-the-meanings-of-module-id-in-component)）。随后像下面这样，加入指向到该CSS文件的`styleUrls`属性。

`app/app.component.ts(styleUrls部分)`：

```typescript
styleUrls: ['app.component.css'],
```

