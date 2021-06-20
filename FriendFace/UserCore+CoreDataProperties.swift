//
//  UserCore+CoreDataProperties.swift
//  FriendFace
//
//  Created by Rodrigo Cavalcanti on 19/06/21.
//
//

import Foundation
import CoreData


extension UserCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCore> {
        return NSFetchRequest<UserCore>(entityName: "UserCore")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?
    
    public var wrappedId: UUID {
            id ?? UUID()
        }
        public var wrappedIsActive: Bool {
            isActive
        }
        public var wrappedName: String {
            name ?? "Unknown Name"
        }
        public var wrappedAge: Int {
            Int(age)
        }
        public var wrappedCompany: String {
            company ?? "Unknown Company"
        }
        public var wrappedEmail: String {
            email ?? "Unknown E-mail"
        }
        public var wrappedAddress: String {
            address ?? "Unknown Address"
        }
        public var wrappedAbout: String {
            about ?? "Unknown Information"
        }
        public var wrappedRegistered: Date {
            registered ?? Date()
        }
        public var wrappedTags: [String] {
            tags ?? []
        }
        
        public var friendsArray: [FriendCore] {
            let set = friends as? Set<FriendCore> ?? []
            return set.sorted {
                $0.wrappedName < $1.wrappedName
            }
        }

}

// MARK: Generated accessors for friends
extension UserCore {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendCore)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendCore)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension UserCore : Identifiable {

}
