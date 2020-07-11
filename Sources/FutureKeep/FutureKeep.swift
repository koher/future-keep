import Combine

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Future {
    @_disfavoredOverload
    public func get(_ body: @escaping (Result<Output, Failure>) -> Void) {
        let keep: Keep<AnyCancellable> = .init()
        keep.value = sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                body(.failure(error))
            }
            keep.value = nil
        }, receiveValue: { output in
            body(.success(output))
        })
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Future where Failure == Never {
    public func get(_ body: @escaping (Output) -> Void) {
        let keep: Keep<AnyCancellable> = .init()
        keep.value = sink { output in
            body(output)
            keep.value = nil
        }
    }
}

private class Keep<Value> {
    var value: Value?
}
