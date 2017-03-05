import Foundation

public protocol Api42Delegate: class {
    func userHandle(User user:User)
    func errorHandle(StrErr str:String)
}

public class api42 {
    public static let shared = api42()
    public var currentUser : User?
    public weak var delegate : Api42Delegate?
    
    private init(){}
    private let client = HttpClient()
    private let dataUser = UserManager()
    
    public func getUsers() -> [User]
    {
        return dataUser.getData
    }
    
    public func loginRequest(Login log:String)
    {
        let trimlog = log.trimmingCharacters(in: CharacterSet.whitespaces)
        if let query = trimlog.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            client.getRequest(Login: query){
                us, err in
                if let user = us {
                    if user.profile.login != STRERR {
                        DispatchQueue.main.async {
                            self.currentUser = user
                            self.dataUser.addUser(User: user)
                            self.delegate?.userHandle(User: user)
                        }
                    }
                    else{DispatchQueue.main.async {self.delegate?.errorHandle(StrErr: "UnValid Query")}}
                }
                if let e = err {
                    DispatchQueue.main.async {self.delegate?.errorHandle(StrErr: e)}
                }
            }
        }
    }
}
