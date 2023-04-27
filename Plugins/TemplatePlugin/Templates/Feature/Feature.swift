//
//  Feature.swift
//  TemplatePlugin
//
//  Created by 김찬수 on 2023/03/28.
//

import ProjectDescription
import Foundation

let name: Template.Attribute = .required("name")
let author: Template.Attribute = .required("author")
//let currentDate: Template.Attribute = .required("currentDate")
let currentDate: Template.Attribute = .optional("currentDate", default: DateFormatter().string(from: Date()))
let appName: Template.Attribute = .optional("appName", default: "MyApp")

let Feature = Template(
    description: "This Template is for making default files",
    attributes: [
        name,
        author,
        currentDate
    ],
    items: [
        .file(
            path: .featureBasePath + "/\(name)Data/Project.swift",
            templatePath: "DataProject.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)Data/Implement/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)Data/Interface/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        
        .file(
            path: .featureBasePath + "/\(name)Domain/Project.swift",
            templatePath: "DomainProject.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)Domain/Implement/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)Domain/Interface/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)UserInterface/Project.swift",
            templatePath: "UserInterfaceProject.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)UserInterface/Implement/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)UserInterface/Interface/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        // UserInterface demoApp 추가
        .file(
            path: .featureBasePath + "/\(name)UserInterface/DemoApp/Sources/\(name)UserInterfaceAppDelegate.swift",
            templatePath: "AppDelegate.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)UserInterface/DemoApp/Resources/LaunchScreen.storyboard",
            templatePath: "LaunchScreen.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)UserInterface/DemoApp/Sources/\(name)UserInterfaceViewController.swift",
            templatePath: "ViewController.stencil"
        ),
        // test파일 더미 추가
        .file(
            path: .featureBasePath + "/\(name)Domain/Tests/dummy.swift",
            templatePath: "dummy.stencil"
        ),
        .file(
            path: .featureBasePath + "/\(name)Data/Tests/dummy.swift",
            templatePath: "dummy.stencil"
        ),

    ]
)

extension String {
    static var featureBasePath: Self {
        return "Features/\(name)"
    }
}
