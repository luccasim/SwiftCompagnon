import Foundation

let STRERR = "@NoValue"
let INTERR = -42

public class HttpClient{
    private var token = Token()
    private let client = Client()
    
    private func getToken(Callback callback: @escaping (Token?) -> Void){
        if let url = URL(string: client.tokenUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "grant_type=client_credentials&client_id=\(client.uid)&client_secret=\(client.secret)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let d = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            let token = json["access_token"] as? String ?? STRERR
                            let create = json["created_at"] as? Int ?? INTERR
                            let expire = json["expires_in"] as? Int ?? INTERR
                            let scope = json["scope"] as? String ?? STRERR
                            let type = json["token_type"] as? String ?? STRERR
                            DispatchQueue.main.async {
                                self.token.setToken(AccessToken: token, Type: type, TimeExpire: expire, Scope: scope, Created: create)
                                callback(self.token)
                            }
                        }
                    }
                    catch let err {
                        print("ERROR HERE = \(err)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func loginRequest(_ log:String, Callback callback: @escaping (User?, String?)-> Void)
    {
        if let url = URL(string: client.userUrl + log){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token.bearerToken)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                    if let d = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                let profile = self.parseProfile(Json: json)
                                let skills = self.parseSkills(Json: json)
                                let projects = self.parseProjects(Json: json)
                                let achievements = self.parseAchievement(Json: json)
                                let user = User(Profile: profile, Skills: skills, Projects: projects, Achievements: achievements)
                                callback(user, nil)
                            }
                        }
                        catch {
                            callback(nil, "UnValid Query")
                        }
                    }
                }
            task.resume()
        }
    }
    
    public func getRequest(Login log:String, Callback callback: @escaping (User?, String?)-> Void)
    {
        if token.valid {
            loginRequest(log, Callback: callback)
        }
        else {
            getToken() {
                token in
                if token != nil {
                    self.getRequest(Login: log, Callback: callback)
                }
            }
        }
    }
}

extension HttpClient {
    fileprivate func parseProjects(Json json:NSDictionary) -> Projects
    {
        var projects = Projects()
        if let project = json["projects_users"] as? [NSDictionary]{
            for elem in project {
                let validated = elem["validated?"] as? Bool ?? false
                let note = elem["final_mark"] as? Double ?? 0.0
                var name = ""
                var slug = ""
                if let projectName = elem["project"] as? NSDictionary {
                    name = projectName["name"] as? String ?? STRERR
                    slug = projectName["slug"] as? String ?? STRERR
                }
                projects.add(Note: note, Name: name, Validated: validated, Slug: slug)
            }
        }
        return projects
    }
    
    fileprivate func parseSkills(Json json:NSDictionary) -> SKills
    {
        var skills = SKills()
        if let cursus = json["cursus_users"] as? [NSDictionary] {
            for elem in cursus {
                if let skill = elem["skills"] as? [NSDictionary] {
                    for s in skill {
                        let name = s["name"] as? String ?? STRERR
                        let level = s["level"] as? Double ?? -4.2
                        skills.addSKill(Level: level, Name: name)
                    }
                }
            }
        }
        return skills
    }
    
    fileprivate func parseProfile(Json json:NSDictionary) -> Profile
    {
        let login = json["login"] as? String ?? STRERR
        let firstName = json["first_name"] as? String ?? STRERR
        let lastName = json["last_name"] as? String ?? STRERR
        let mail = json["email"] as? String ?? STRERR
        let phone = json["phone"] as? String ?? STRERR
        let correction = json["correction_point"] as? Int ?? INTERR
        let imgUrl = json["image_url"] as? String ?? STRERR
        var level = 0.0
        let wallet = json["wallet"] as? Int ?? INTERR
        var grade = ""
        if let cursus = json["cursus_users"] as? [NSDictionary] {
            for elem in cursus {
                level = elem["level"] as? Double ?? 0.0
                grade = elem["grade"] as? String ?? STRERR
            }
        }
        let profile = Profile(login: login, firstName: firstName, lastName: lastName, mail: mail, phone: phone, grade: grade, level: level, correctionPoint: correction, wallet: wallet, imageUrl: imgUrl)
        return profile
    }
    
    fileprivate func parseAchievement(Json json:NSDictionary) -> Achievements
    {
        var achievements = Achievements()
        if let achievement = json["achievements"] as? [NSDictionary] {
            for elem in achievement {
                let name = elem["name"] as? String ?? STRERR
                let description = elem["description"] as? String ?? STRERR
                let image = elem["image"] as? String ?? STRERR
                achievements.addAchivement(Name: name, Description: description, Image: image)
            }
        }
        return achievements
    }

}

