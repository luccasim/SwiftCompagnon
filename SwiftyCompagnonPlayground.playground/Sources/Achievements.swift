import Foundation

public struct Achievement{
    public let name : String
    public let description : String
    public let imageUrl : String
}

public struct Achievements {
    public var achievements = [Achievement]()
    
    mutating func addAchivement(Name name:String, Description description:String, Image image:String)
    {
        var fullUrlImage = image
        if let rang = image.range(of: "/achi"){
            let newstr = image.substring(from: rang.lowerBound)
            fullUrlImage = "https://cdn.intra.42.fr\(newstr)"
        }
        let new = Achievement(name: name, description: description, imageUrl: fullUrlImage)
        self.achievements.append(new)
    }
}
