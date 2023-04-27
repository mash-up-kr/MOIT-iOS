//
//  Workspace.swift
//  Config
//
//  Created by 김찬수 on 2023/04/27.
//

import ProjectDescription

let appName = "MOIT"

let workspace = Workspace(
    name: appName,
    projects: [
        "./**"
    ]
)
