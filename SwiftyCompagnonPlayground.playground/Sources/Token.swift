import Foundation

public class Token {
    fileprivate var accessToken : String!
    fileprivate var tokenType : String!
    fileprivate var expires : Int!
    fileprivate var scope : String!
    fileprivate var created : Int!
    private var isSet = false
    private var expireTimestamp : Int!

    public var bearerToken : String {
        return accessToken ?? "UNVALID TOKEN"
    }
    
    public var valid : Bool {
        if isSet {
            let currentTimestamp = Int(Date().timeIntervalSinceNow)
            return expireTimestamp - currentTimestamp > 0
        }
        return false
    }
    
    public func setToken(AccessToken token:String, Type type:String, TimeExpire timeExpire:Int, Scope scope:String, Created created:Int)
    {
        self.accessToken = token
        self.tokenType = type
        self.expires = timeExpire
        self.scope = scope
        self.created = created
        self.isSet = true
        self.expireTimestamp = Int(Date().timeIntervalSinceNow) + timeExpire
    }
}

extension Token : CustomStringConvertible {
    
    public var description: String {
        return "token = \(accessToken)" +
        "\nType = \(tokenType)" +
        "\nExpire in = \(expires)" +
        "\nScope = \(scope)" +
        "\nCreated at = \(created)"
    }
}
