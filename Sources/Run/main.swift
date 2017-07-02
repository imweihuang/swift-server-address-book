import App
import Vapor
import FluentProvider
import PostgreSQLProvider

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands,
/// if no command is given, it will default to "serve"

// - Attribution: postgresql-provider - https://github.com/vapor-community/postgresql-provider

let config = try Config()
try config.addProvider(PostgreSQLProvider.Provider.self)
config.preparations.append(AddressBook.self) // Documentation is incorrect - drop.preparations.append(Pet.self)
try config.setup()

let drop = try Droplet(config)
try drop.setup()

let postgresqlDriver = try drop.postgresql()

drop.get {
    req in
    return "Hello Vapor Address Book"
}

drop.get("version") {
    req in
    let version = try postgresqlDriver.raw("SELECT version()")
    return JSON(node: version)
}

drop.get("instruction") {
    req in
    var instruction = "Welcome to Vapor Address Book\n"
    instruction += "\n"
    instruction += "- To create an adddress:\n"
    instruction += "http://localhost:8080/create/<First Name>/<Last Name>/<Email Address>/<Phone Number>\n"
    instruction += "> Example:\n"
    instruction += "http://localhost:8080/create/Wei/Huang/weihuang@uchicago.edu/312-315-7168\n"
    instruction += "\n"
    instruction += "- To update an adddress:\n"
    instruction += "http://localhost:8080/update/<ID>/<First Name>/<Last Name>/<Email Address>/<Phone Number>\n"
    instruction += "> Example:\n"
    instruction += "http://localhost:8080/update/2/Wei2/Huang2/weihuang@uchicago.edu/312-315-7168\n"
    instruction += "\n"
    instruction += "- To delete an adddress:\n"
    instruction += "http://localhost:8080/delete/<ID>\n"
    instruction += "> Example:\n"
    instruction += "http://localhost:8080/delete/2\n"
    instruction += "\n"
    instruction += "- To retrieve all adddresses:\n"
    instruction += "http://localhost:8080/retrieve\n"
    instruction += "> Example:\n"
    instruction += "http://localhost:8080/retrieve\n"
    instruction += "\n"
    
    return instruction
}

drop.get("create", String.parameter, String.parameter, String.parameter, String.parameter) {
    req in
    let firstName = try req.parameters.next(String.self)
    let lastName = try req.parameters.next(String.self)
    let emailAddress = try req.parameters.next(String.self)
    let phoneNumber = try req.parameters.next(String.self)
    let address = AddressBook(firstName: firstName, lastName: lastName, emailAddress: emailAddress, phoneNumber: phoneNumber)
    try address.save()
    // Return all
    var addressesString = "ID | First Name | Last Name | Email | Phone\n"
    for address in try AddressBook.all() {
        print(address.firstName)
        addressesString += "\(String(describing: address.id)) | \(address.firstName) | \(address.lastName) | \(address.emailAddress) | \(address.phoneNumber)\n"
    }
    return addressesString
}

drop.get("update", String.parameter, String.parameter, String.parameter, String.parameter, String.parameter) {
    req in
    let id = try req.parameters.next(String.self)
    let firstName = try req.parameters.next(String.self)
    let lastName = try req.parameters.next(String.self)
    let emailAddress = try req.parameters.next(String.self)
    let phoneNumber = try req.parameters.next(String.self)
    // Select
    guard var address = try AddressBook.makeQuery().filter("id", .equals, id).first() else { return "#\(id) not exist"}
    // Update
    address.firstName = firstName
    address.lastName = lastName
    address.emailAddress = emailAddress
    address.phoneNumber = phoneNumber
    try address.save()
    // Return all
    var addressesString = "ID | First Name | Last Name | Email | Phone\n"
    for address in try AddressBook.all() {
        print(address.firstName)
        addressesString += "\(String(describing: address.id)) | \(address.firstName) | \(address.lastName) | \(address.emailAddress) | \(address.phoneNumber)\n"
    }
    return addressesString
}

drop.get("retrieve") {
    req in
    var addressesString = "ID | First Name | Last Name | Email | Phone\n"
    for address in try AddressBook.all() {
        print(address.firstName)
        addressesString += "\(String(describing: address.id)) | \(address.firstName) | \(address.lastName) | \(address.emailAddress) | \(address.phoneNumber)\n"
    }
    return addressesString
}

drop.get("delete", String.parameter) {
    req in
    let id = try req.parameters.next(String.self)
    // Select
    guard var address = try AddressBook.makeQuery().filter("id", .equals, id).first() else { return "#\(id) not exist"}
    // Delete
    try address.delete()
    // Return all
    var addressesString = "ID | First Name | Last Name | Email | Phone\n"
    for address in try AddressBook.all() {
        print(address.firstName)
        addressesString += "\(String(describing: address.id)) | \(address.firstName) | \(address.lastName) | \(address.emailAddress) | \(address.phoneNumber)\n"
    }
    return addressesString
}

try drop.run()


