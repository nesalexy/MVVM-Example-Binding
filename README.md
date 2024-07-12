# Tech task - Engenious

> Build a simple iOS application that fetches and displays a list of repositories for a specific GitHub user, using the provided design.

### Requirements:
- MVVM
- UIKit
- Combine, async/await, and callbacks in the networking layer
- Unit tests specifically for the network layer
- Not use any third-party libraries

### Architecture:

The project uses MVVM + Coordinator + DataSources. 

- **Base**. Contains base classes.
- **Screens**. Contains the application screens. Each screen contains its own **ViewController**, **View** and **ViewModel**.
- **Services**. Contains **dataSources** for a particular scinarius (for example, for working with the github repository list). Contains **HTTPClient**.
- **Coordinators**. Contains navigation.
- **Helpers**. Extensions, general Views.
- **Resources**. Assets, etc.

### HTTP Layour:
Abstraction that will allow to easily substitute the implementation for different cases. 

```
protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error>
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse)
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ())
}
```

implementation in `extension` of `URLSession`. This gives us the ability to substitute HTTPClient. For example, it will be convenient for testing.

```
extension URLSession: HTTPClient  {
    
    // HTTPClient implementation based on Combine
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        ...
    }
    
    // HTTPClient implementation based on Async/Await
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        ...
    }
    
    // HTTPClient implementation based on Callback
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ()) {
        ...
    }
}
```

**HTTPProvider**
Provides the ability to generate a query with data in a specific scenario.

### Testing

The testing covers **HTTPClient**(with Combine, Swift Concurrency, Closure), **HTTPProvider**, **RepositoryDataSource** with a different cases(with Combine, Swift Concurrency, Closure)

### Demo

- Success case 
<img src="SuccessCase.gif" width="50%" height="50%">
- Empty list case
<img src="EmptyCase.png" width="50%" height="50%">
- Error case
<img src="ErrorCase.gif" width="50%" height="50%">


