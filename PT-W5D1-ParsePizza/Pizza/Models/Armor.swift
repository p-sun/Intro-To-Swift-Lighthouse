//
//  Armor.swift
//  Pizza
//
//  Created by Paige Sun on 2018-10-22.
//  Copyright © 2018 Curtis Mak. All rights reserved.
//

import Parse

class Armor : PFObject, PFSubclassing {
	@NSManaged var displayName: String
	@NSManaged var hitPoints: NSNumber
	@NSManaged var needsRepair: Bool
	@NSManaged var material: [String]
	@NSManaged var dateForged: Date
	@NSManaged var attributes: [String: Any]
	@NSManaged var pizza: Pizza
	
	static func parseClassName() -> String {
		return "Armor"
	}
}


class Pizza : PFObject, PFSubclassing {
	@NSManaged var pizzaName: String
	
	static func parseClassName() -> String {
		return "Pizza"
	}
}

