//
//  AddressBook.swift
//  VaporAddressBook
//
//  Created by Wei Huang on 5/24/17.
//
//

import Vapor
import FluentProvider
import Foundation

/// AddressBook model
final class AddressBook: Model {
    var id: String
    var firstName: String
    var lastName: String
    var emailAddress: String
    var phoneNumber: String
    var storage = Storage()
    
    /// Custom initialization
    init(firstName: String, lastName: String, emailAddress: String, phoneNumber: String) {
        self.id = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
    }
    
    /// Custom initialation
    /*
     init(node: Node, in context: Context) throws {
     id = try node.extract("id")
     firstName = try node.extract("firstname")
     lastName = try node.extract("lastname")
     emailAddress = try node.extract("emailaddress")
     phoneNumber = try node.extract("phonenumber")
     }
     */
    
    init(row: Row) throws {
        id = try row.get("id")
        firstName = try row.get("firstname")
        lastName = try row.get("lastname")
        emailAddress = try row.get("emailaddress")
        phoneNumber = try row.get("phonenumber")
    }
    
    /// Convert our internal class to a Node (Fluent ORM)
    /*
     func makeNode(context: Context) throws -> Node {
     return try Node(node: [
     "id": id,
     "firstname": firstName,
     "lastname": lastName,
     "emailaddress": emailAddress,
     "phonenumber": phoneNumber
     ])
     }
     */
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("firstname", firstName)
        try row.set("lastname", lastName)
        try row.set("emailaddress", emailAddress)
        try row.set("phonenumber", phoneNumber)
        return row
    }
    
    /*
     /// Create database entry
     static func prepare(_ database: Database) throws {
     try database.create("addressBookItems") { addressBookItems in
     addressBookItems.id()
     addressBookItems.string("firstname")
     addressBookItems.string("lastname")
     addressBookItems.string("emailaddress")
     addressBookItems.string("phonenumber")
     }
     }
     
     /// Delete the entire database
     /// - Note: This will delete the entire db
     static func revert(_ database: Database) throws {
     try database.delete("addressBookItems")
     }
     */
}

extension AddressBook: Preparation {
    /// Create database entry
    static func prepare(_ database: Database) throws {
        try database.create(self) { addresses in
            addresses.id()
            addresses.string("firstname")
            addresses.string("lastname")
            addresses.string("emailaddress")
            addresses.string("phonenumber")
        }
    }
    
    /// Delete the entire database
    /// - Note: This will delete the entire db
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
