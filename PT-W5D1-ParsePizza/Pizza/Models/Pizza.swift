//
//  Pizza.swift
//  Pizza
//
//  Created by Paige Sun on 2018-10-22.
//  Copyright © 2018 Curtis Mak. All rights reserved.
//

import Parse

class Pizza : PFObject, PFSubclassing {
	@NSManaged var pizzaName: String
	
	static func parseClassName() -> String {
		return "Pizza"
	}
}
