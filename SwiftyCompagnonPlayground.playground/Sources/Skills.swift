import Foundation

public struct Skill {
    public let level : Double
    public let name : String
}

public struct SKills {
    public var skills = [Skill]()
    
    mutating func addSKill(Level level:Double, Name name:String)
    {
        let new = Skill(level: level, name: name)
        self.skills.append(new)
    }
}
