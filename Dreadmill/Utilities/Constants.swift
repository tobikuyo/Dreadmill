//
//  Constants.swift
//  Dreadmill
//
//  Created by Tobi Kuyoro on 23/07/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

struct Identifier {
    static let logCell  = "LogCell"
    static let runSegue = "CurrentRunSegue"
}

struct RealmConstants {
    static let queue = DispatchQueue(label: "com.tobikuyoro.Dreadmill.realQueue")
    static let configuration = "realmRunConfiguration"
}
