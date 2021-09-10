# SwiftUIBloc

![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS-lightgrey) ![](https://github.com/mehdok/SwiftUIBlocPrivate/workflows/build/badge.svg)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mehdok/SwiftUIBloc)
[![License](https://img.shields.io/github/license/mehdok/SwiftUIBloc)](LICENSE) [![codecov](https://codecov.io/gh/mehdok/SwiftUIBloc/branch/master/graph/badge.svg)](https://codecov.io/gh/mehdok/SwiftUIBloc)

The Bloc Pattern is a way to separate UI and Logic in SwiftUI codes.
The Bloc is like a state machine where it accepts an event and produce a state.

## Example

To run the example project, clone this repo, and open iOS Example.xcworkspace from the iOS Example directory.


## Requirements
macOS(.v10_15), iOS(.v13), tvOS(.v14), watchOS(.v6)

## Installation

#### Swift Package Manager

`https://github.com/mehdok/SwiftUIBloc`

#### CocoaPods

`pod 'SwiftUIBloc'`

## Usage

1) Create `Event` and `State` :

````swift
enum CounterEvent: EventBase {
    case increase
    case decrease
}
````

````swift
enum CounterState: StateBase {
    case initial
    case counter(Int)
}
````

2) Extend `Bloc` and override `mapEventToState`  and use `yield` to dispatch states:

````swift
final class CounterBloc: Bloc<CounterEvent, CounterState> {
    private var count = 0
    
    override func mapEventToState(_ event: CounterEvent) {
        switch event {
        case .increase:
            count += 1
            yield(.counter(count))
        case .decrease:
            count -= 1
            yield(.counter(count))
        }
    }
}
````

## Bloc Views

You can easily monitor `bloc.state` in your view's `body` and show the proper view base on that.
To remove some boilerplate there are couple of views you can use:

### BlocBuilderView

`BlocBuilderView` is a `View` which requires a `Bloc` and  a `@ViewBuilder`.   `BlocBuilderView` handles building the view in response to new states. 

````swift
BlocBuilderView(bloc: bloc) { state in
    // return view based on bloc state
}
````

You can control when the builder function should be called by providing `buildWhen` function.

````swift
BlocBuilderView(bloc: bloc, buildWhen: {previousState, currentState in
    // return true/false to determine whether or not
    // to rebuild the view with state
}) {
    // return view  based on bloc's state
}
````
### BlocListenerView

`BlocListener` is a `View` which takes a `bloc` and invokes the `listener` in response to state changes in the bloc.

````swift
BlocListenerView(bloc: bloc, listener: {state in
    // do stuff here based on bloc's state
}) {
    // return view
}
````

You can control when the listener function should be called by providing `listenWhen` function.

````swift
BlocListenerView(bloc: bloc, listener: {state in
    // do stuff here based on bloc's state
}, listenWhen: { (previousState, currentState) -> Bool in
    // return true/false to determine whether or not
    // to call listener with state
}) {
    // return view 
}
````


## Author

Mehdi Sohrabi


## License

SwiftUIBloc is available under the MIT license. See [the LICENSE file](LICENSE) for more information.
