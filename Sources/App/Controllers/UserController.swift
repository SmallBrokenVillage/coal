//
//  File.swift
//  
//
//  Created by 方泓睿 on 2021-01-17.
//

import Foundation
import Vapor
import Fluent

extension User{
    struct Create: Content{
        var name: String
        var email: String
        var password: String
        var confirmPassword: String
    }
}

extension User.Create: Validatable{
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

struct UserController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let router = routes.grouped("user")
        router.post("create", use: create)
    }
    
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        try User.Create.validate(content: req)
        let create = try req.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else{
            throw Abort(.badRequest, reason: "Password did not match")
        }
        let user = try User(name: create.name,
                            email: create.email,
                            passwordHash: Bcrypt.hash(create.password))
        
        return user.save(on: req.db)
            .map{
                HTTPStatus.ok
            }
    }
}
