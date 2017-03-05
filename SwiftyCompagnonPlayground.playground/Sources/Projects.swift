import Foundation

public struct Project {
    public let note : Double
    public let name : String
    public let slug : String
    public let validated : Bool
}

public struct Projects {
    public var projects = [Project]()
    
    mutating func add(Note note:Double, Name name: String, Validated valid:Bool, Slug slug:String)
    {
        let new = Project(note: note, name: name, slug: slug, validated: valid)
        self.projects.append(new)
    }
}
