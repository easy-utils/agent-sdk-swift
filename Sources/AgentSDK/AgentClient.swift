// Agent typed client SDK for Swift over easy-rpc (agent.v1.AgentService).
// AgentServiceClient (generated) wraps an easyRpc Transport; this adds a Bearer
// token attached to every request.
import easyRpc
import Foundation

/// Adds an Authorization header to every outbound request.
final class AuthTransport: Transport, @unchecked Sendable {
    private let inner: any Transport
    private let value: String
    init(_ inner: any Transport, _ value: String) { self.inner = inner; self.value = value }
    func send(_ req: Request) async throws -> Response {
        try await inner.send(headered(req))
    }
    func openStream(_ req: Request) async throws -> any easyRpc.Stream {
        try await inner.openStream(headered(req))
    }
    private func headered(_ req: Request) -> Request {
        var h = req.headers
        h["Authorization"] = [value]
        return Request(url: req.url, method: req.method, headers: h, body: req.body)
    }
}

/// Strong-typed agent client: generated surface + Bearer auth.
public final class AgentClient {
    public let client: AgentServiceClient
    public init(baseUrl: String, token: String = "", transport: (any Transport)? = nil) {
        let t = transport ?? URLSessionTransport(base: baseUrl)
        self.client = token.isEmpty
            ? AgentServiceClient(t)
            : AgentServiceClient(AuthTransport(t, "Bearer \(token)"))
    }
}
