# FutureKeep

FutureKeep keeps subscriptions of `Future`s in [Combine](https://developer.apple.com/documentation/combine) when the `get` method is called until those `Future`s are completed. It makes it easier to use `Future`s instead of completion handlers when we do not need to cancel those asynchronous operations.

```swift
// Keeps a reference to the subscription
// until it is complete.
future.get { value in
    // Uses `value` here
}
```

`get` can be used instead of `sink`. When we use `sink`, subscriptions are cancelled unless references to cancellables are kept.

```swift
// Subscriptions are cancelled
// just after the `sink` is called.
_ = future.sink { value in
    // Uses `value` here
}
```

When the `Failure` type of a `Future` instance is `Never`, the closure receives `Output` as its argument. Otherwise, the closure receives `Result<Output, Failure>`.

## License

[MIT](LICENSE)
