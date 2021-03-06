module ThunkedStoreProvider =
  Reductive.MakeProvider {
    type state = ThunkedStore.appState;
    type action = ReduxThunk.thunk ThunkedStore.appState;
  };

ReactDOMRe.renderToElementWithId
  <ThunkedStoreProvider store=ThunkedStore.store component=DataRenderer.createElement /> "index";
