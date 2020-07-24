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

struct RealmQueue {
    static let label = DispatchQueue(label: "com.tobikuyoro.Dreadmill.realQueue")
}
