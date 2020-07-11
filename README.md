# FutureKeep

FutureKeep makes it possible to keep subscriptions of `Future`s in [Combine](https://developer.apple.com/documentation/combine) until those `Future`s are completed. It is useful to replace completion handlers with `Future`s when cancellations are not required.

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

When the `Failure` type of a `Future` is `Never`, closures receive an `Output` as its argument. Otherwise, closures receive a `Result<Output, Failure>`.

## License

[MIT](LICENSE)
