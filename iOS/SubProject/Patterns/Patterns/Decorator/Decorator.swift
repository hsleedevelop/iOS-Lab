//
//  Decorator.swift
//  Patterns
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

/// The base Component interface defines operations that can be altered by
/// decorators.
protocol Component {

    func operation() -> String
}

/// Concrete Components provide default implementations of the operations. There
/// might be several variations of these classes.
class ConcreteComponent: Component {

    func operation() -> String {
        return "ConcreteComponent"
    }
}

/// The base Decorator class follows the same interface as the other components.
/// The primary purpose of this class is to define the wrapping interface for
/// all concrete decorators. The default implementation of the wrapping code
/// might include a field for storing a wrapped component and the means to
/// initialize it.
class Decorator: Component { //Structural

    private var component: Component

    init(_ component: Component) {
        self.component = component
    }

    /// The Decorator delegates all work to the wrapped component.
    func operation() -> String {
        return component.operation()
    }
}

/// Concrete Decorators call the wrapped object and alter its result in some
/// way.
class ConcreteDecoratorA: Decorator {

    /// Decorators may call parent implementation of the operation, instead of
    /// calling the wrapped object directly. This approach simplifies extension
    /// of decorator classes.
    override func operation() -> String {
        return "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

/// Decorators can execute their behavior either before or after the call to a
/// wrapped object.
class ConcreteDecoratorB: Decorator {

    override func operation() -> String {
        return "ConcreteDecoratorB(" + super.operation() + ")"
    }
}

/// The client code works with all objects using the Component interface. This
/// way it can stay independent of the concrete classes of components it works
/// with.
class ClientDecorator {
    // ...
    static func someClientCode(component: Component) {
        print("Result: " + component.operation())
    }
    // ...
}
