import Combine

extension Publisher {
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

extension Publisher where Failure == Never {
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
