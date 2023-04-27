//
//  App.swift
//  TemplatePlugin
//
//  Created by 김찬수 on 2023/03/29.
//

import ProjectDescription

let AppName: Template.Attribute = .required("name")
//let author: Template.Attribute = .required("author")
//let currentDate: Template.Attribute = .required("currentDate")

let App = Template(
    description: "This Template is for making App files",
    attributes: [
        AppName,
    ],
    items: [
        .file(
            path: "App/Project.swift",
            templatePath: "AppProject.stencil"
        ),
        .file(
            path: "App/Sources/AppDelegate.swift",
            templatePath: "AppDelegate.stencil"
        ),
//        .file(
//            path: "App/Sources/SceneDelegate.swift",
//            templatePath: "SceneDelegate.stencil"
//        ),
        .file(
            path: "App/Resources/LaunchScreen.storyboard",
            templatePath: "LaunchScreen.stencil"
        ),
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Project+Templates.swift",
            templatePath: "Project+Templates.stencil"
        ),
        .file(
            path: "Tuist/Dependencies.swift",
            templatePath: "Dependencies.stencil"
        ),
        .file(
            path: "App/Sources/AppComponent.swift",
            templatePath: "AppComponent.stencil"
        ),
    ]
)

//extension String {
//    static var appBasePath: Self {
//        return "Features/\(name)"
//    }
//}
