//
//  ArtistViewController.swift
//  Spotify Artists Viewer
//
//  Created by Asaph Yuan on 9/22/16.
//  Copyright © 2016 Asaph Yuan. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    var query: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = query
    }
}
