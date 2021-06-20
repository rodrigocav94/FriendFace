//
//  FriendCore+CoreDataProperties.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//
//

import Foundation
import CoreData


extension FriendCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCore> {
        return NSFetchRequest<FriendCore>(entityName: "FriendCore")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var friendOf: UserCore?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
}

extension FriendCore : Identifiable {

}
