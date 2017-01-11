# Angular概览
**Angular Overview**

有关构建Angular应用的基本块。

Angular是一个以HTML及JavaScript或像是TypeScript这样的编译到JavaScript的语言，来构建客户端应用的框架（Angular is a framework for building client applications in HTML and either JavaScript or a language like TypeScript that compiles to JavaScript）。

该框架是由多个的库组成，一些是核心库，一些是可选库。

通过编写带有Angular化标记的HTML*模板*, 及管理这些模板的*组件*类，和在*服务*中加入应用逻辑，并将这些组件与服务装箱到*模块*中，就可以编写出Angular应用了（you write Angular applications by composing HTML *templates* with Angularized markup, writing *component* classes to manage those templates, adding application logic in *services*, and boxing components and services in *modules*）。

随后通过*启动根模块*，来启动应用（then you launch the app by *bootstrapping* the *root module*）。此时Angular便接管过来，在浏览器中呈现出应用内容，并通过你所提供的指令，对用户交互进行响应。

当然，实际上比上面所说的要复杂得多。在随后的本页中，你将了解到那些细节。现在请着重于大的图景。

![概览2](images/overview2.png)

该架构图标识出了8个构建Angular应用的主要块（the eight main building blocks of an Angular application）:

- [模块（Modules）](#modules)
- [组件（Components）](#components)
- [模板（Templates）](#templates)
- [元数据（Metadata）](#metadata)
- [数据绑定（Data Binding）](#data_binding)
- [指令（Directives）](#directives)
- [服务（Services）](#services)
- [依赖注入（Dependency Injection）](#dependency_injection)

请对这些构建块进行学习，你是在学习之路上的。

> 本页上所引用到的代码，在[现场示例](https://angular.io/resources/live-examples/architecture/ts/eplnkr.html)可以获取到。

## <a name="modules"></a>模块

![模块图示](images/module.png)

Angular应用是模块化的，同时Angular有着自身的叫做*Angular modules*或*NgModules*的模块化系统（Angular apps are modular and Angular has its own modularity system called *Angular modules* or *NgModules*）。

*Angular modules* 是一个大的题目（a big deal）。本页对模块加以引入；而[Angular modules](https://angular.io/docs/ts/latest/guide/ngmodule.html)页面对Angular模块有深入介绍。

所有Angular应用都至少有着一个的Angular模块类，也就是[*根*模块（the *root* module）](https://angular.io/docs/ts/latest/guide/appmodule.html), 依惯例被命名为`AppModule`。

尽管在小型应用中*根模块*可能是唯一的模块，然而大多数应用都有着更多的*特性模块（feature modules）*，每个模块都是专注于某个应用方面、某个工作流程，或是密切相关的功能集的有着紧密联系的代码块（most apps have many *feature modules*, each a cohesive block of code dedicated to an application domain, a workflow, or a closely related set of capabilities, *译者注：* 这里有提到workflow，工作流程，那么我们就可以使用Angular构建客户端的工作流程应用了，这是非常重要的）。

某个Angular模块，不论其是*根的*或是*特性的*, 都是一个有着`@NgModule`装饰器的类（an Angular module, whether a *root* or *feature*, is a class with an `@NgModule` decorator）。

> 装饰器是一些对JavaScript类进行修改的函数。Angular有着许多的将元数据附加到类上的装饰器，这样做Angular就知道这些类的意义，以及这些类将如何运作（decorators are functions that modify JavaScript classes. Angular has many decorators that attach metadata to classes so that it knows what those classes mean and how they should work）。请在web上[了解更多有关装饰器](https://medium.com/google-developers/exploring-es7-decorators-76ecb65fb841#.x5c2ndtx0)的知识。

`NgModule`是一个取得单个的元数据对象的装饰器函数，该元数据对象的熟悉对被装饰的模块加以描述（`NgModule` is a decorator function that takes a single metadata object whose properties describe the module）。下面是一些最重要的属性：

- `declarations` -- 指明那些属于该模块的*视图类*。而Angular有着以下三种的视图类：[组件](#components)、[指令](#directives)与[管道](https://angular.io/docs/ts/latest/guide/pipes.html)。
- `exports` -- 这是`declarations`的子集，指明其它模块的组件[模板](#templates)中可见和可用的视图类。
- `imports` -- 指明一些其它模块，*本*模块中所声明的一些组件模板需要那些模块所导出的类（other modules whose exported classes are needed by component templates declared in *this* module）。
- `providers` -- 指明一些本模块贡献到全局服务集合的[服务](#services)创建器；这些服务在该app的所有部分成为可用的了（creators of [services](#services) that this module contributes to the global collection of services; they become accesible in all parts of the app）。
- `bootstrap` -- 指明主要应用视图，也叫做*根组件（the root component）*，该组件保存着所有其它的应用视图。注意只有*根模块*应设置此`bootstrap`属性（the main application view, called the *root component*, that hosts all other app views. Only the *root module* should set this `bootstrap` property）。

下面是一个简单的根模块：

`app/app.module.ts`

```typescript
import { NgModule } from '@angular/core'
import { BrowserModule } from '@angular/platform-browser'

@NgModule({
    imports: [ BrowserModule ],
    providers: [ Logger ],
    declarations: [ AppComponent ],
    exports: [ AppComponent ],
    bootstrap: [ AppComponent ]
})

export class AppModule {}
```

> 这里`AppComponent`的`export`仅是作为展示如何来导出；在本示例中并不是必要的。根模块没有任何理由去*导出*什么，因为其它组件并不需要*导入*根模块（a root module has no reason to *export* anything because other components don't need to *import* the root module, *译者注：* 对与根模块是这样，那么对于特性模块还是这样吗? 这个问题留待以后分析）。


