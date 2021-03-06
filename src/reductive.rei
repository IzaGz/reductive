module Store: {
  type t 'action 'state;
  let create:
    reducer::('state => 'action => 'state) =>
    preloadedState::'state =>
    enhancer::(t 'action 'state => ('action => unit) => 'action => unit)? =>
    unit =>
    t 'action 'state;
  let unsubscribe: t 'action 'state => (unit => unit) => unit => unit;
  let subscribe: t 'action 'state => (unit => unit) => unit => unit;
  /* skips all middleware and applies an update directly to the store */
  let nativeDispatch: t 'action 'state => 'action => unit;
  let dispatch: t 'action 'state => 'action => unit;
  let getState: t 'action 'state => 'state;
  let replaceReducer: t 'action 'state => ('state => 'action => 'state) => unit;
};

module MakeProvider:
  (StoreTypes: {type state; type action;}) =>
  {
    let createElement:
      store::Store.t StoreTypes.action StoreTypes.state =>
      component::(
        state::StoreTypes.state =>
        dispatch::(StoreTypes.action => unit) =>
        children::list ReactRe.reactElement =>
        ref::(ReactRe.reactRef => unit)? =>
        key::string? =>
        unit =>
        ReactRe.reactElement
      ) =>
      children::list ReactRe.reactElement =>
      ref::(ReactRe.reactRef => unit)? =>
      key::string? =>
      unit =>
      ReactRe.reactElement;
  };


/** These are all visible apis of Redux that aren't needed in Reason.
 * When used, build tools will provide explaination of alternatives.
 */
let compose:
  _ => unit

    [@@ocaml.deprecated
      {|
Use the |> as an infix operator to chain the
result of one function into another:

`compose(f, g, h)(x)`
in JS goes to
`x |> h |> g |> f`
in Reason.
|}
    ];


let combineReducers:
  _ => unit

    [@@ocaml.deprecated
      {|
combineReducers uses some introspection to determine
the shape of your state. Instead, consider a declarative pattern like:

type counterAction =
| Increment
| Decrement;
type stringAction =
| A
| B;
type action =
| StringAction stringAction
| CounterAction counterAction;
type state = {string, counter};

let combinedReducer state action => {
| StringAction action => {...state, string: stringReducer state action}
| CounterAction action => {...state, counter: counterReducer state action}
};

this pattern gives you full control over the shape of your state.
|}
    ];


let applyMiddleware:
  _ => unit

    [@@ocaml.deprecated
      {|
The enhancer attribute in Redux allows you
to provide a custom dispatch method (to perform more
actions before or after the dispatch function). You can simply pass in
a function directly which handles the exact actions you're looking for.

To chain middlewares you can do something like:

let thunkedLoggedTimeTravelLogger store next =>
  Middleware.thunk store @@
  Middleware.logger store @@
  Middleware.timeTravel store @@
  next;
|}
    ];


let bindActionCreators:
  list 'a => ('a => 'b) => list (unit => 'b)

    [@@ocaml.deprecated
      {|
bindActionCreators is not as useful in Reason,
since action creators are types, not functions.
The code is implemented as:

let bindActionCreators actions dispatch =>
List.map (fun action () => dispatch action) actions;

Instead - you are free to build the action data type at dispatch time.
|}
    ];
