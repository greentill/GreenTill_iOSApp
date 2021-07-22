//
//	UserLoginModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserLoginModel : NSObject, NSCoding{

	var countyid : String! = ""
	var countyname : String! = ""
	var email : String! = ""
	var firstname : String! = ""
	var irano : String! = ""
	var isEnabled : String! = ""
	var lastname : String! = ""
	var mobileno : String! = ""
	var uname : String! = ""
	var userPhoto : String! = ""
    
    override init() {
        super .init()
    }


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        
        let utilityObject = CommonUtility()
        
        if let countyid = dictionary["countyid"]
        {
            if(utilityObject.hasValue(object: countyid as AnyObject))
            {
                self.countyid = countyid as? String
            }
        }
        if let countyname = dictionary["countyname"]
        {
            if(utilityObject.hasValue(object: countyname as AnyObject))
            {
                self.countyname = countyname as? String
            }
        }
        if let email = dictionary["email"]
        {
            if(utilityObject.hasValue(object: email as AnyObject))
            {
                self.email = email as? String
            }
        }
        if let firstname = dictionary["firstname"]
        {
            if(utilityObject.hasValue(object: firstname as AnyObject))
            {
                self.firstname = firstname as? String
            }
        }
        if let irano = dictionary["irano"]
        {
            if(utilityObject.hasValue(object: irano as AnyObject))
            {
                self.irano = irano as? String
            }
        }
        if let isEnabled = dictionary["is_enabled"]
        {
            if(utilityObject.hasValue(object: isEnabled as AnyObject))
            {
                self.isEnabled = isEnabled as? String
            }
        }
        if let lastname = dictionary["lastname"]
        {
            if(utilityObject.hasValue(object: lastname as AnyObject))
            {
                self.lastname = lastname as? String
            }
        }
        if let mobileno = dictionary["mobileno"]
        {
            if(utilityObject.hasValue(object: mobileno as AnyObject))
            {
                self.mobileno = mobileno as? String
            }
        }
        if let uname = dictionary["uname"]
        {
            if(utilityObject.hasValue(object: uname as AnyObject))
            {
                self.uname = uname as? String
            }
        }
        if let userPhoto = dictionary["user_photo"]
        {
            if(utilityObject.hasValue(object: userPhoto as AnyObject))
            {
                self.userPhoto = userPhoto as? String
            }
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if countyid != nil{
			dictionary["countyid"] = countyid
		}
		if countyname != nil{
			dictionary["countyname"] = countyname
		}
		if email != nil{
			dictionary["email"] = email
		}
		if firstname != nil{
			dictionary["firstname"] = firstname
		}
		if irano != nil{
			dictionary["irano"] = irano
		}
		if isEnabled != nil{
			dictionary["is_enabled"] = isEnabled
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if mobileno != nil{
			dictionary["mobileno"] = mobileno
		}
		if uname != nil{
			dictionary["uname"] = uname
		}
		if userPhoto != nil{
			dictionary["user_photo"] = userPhoto
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         countyid = aDecoder.decodeObject(forKey: "countyid") as? String
         countyname = aDecoder.decodeObject(forKey: "countyname") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstname = aDecoder.decodeObject(forKey: "firstname") as? String
         irano = aDecoder.decodeObject(forKey: "irano") as? String
         isEnabled = aDecoder.decodeObject(forKey: "is_enabled") as? String
         lastname = aDecoder.decodeObject(forKey: "lastname") as? String
         mobileno = aDecoder.decodeObject(forKey: "mobileno") as? String
         uname = aDecoder.decodeObject(forKey: "uname") as? String
         userPhoto = aDecoder.decodeObject(forKey: "user_photo") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if countyid != nil{
			aCoder.encode(countyid, forKey: "countyid")
		}
		if countyname != nil{
			aCoder.encode(countyname, forKey: "countyname")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstname != nil{
			aCoder.encode(firstname, forKey: "firstname")
		}
		if irano != nil{
			aCoder.encode(irano, forKey: "irano")
		}
		if isEnabled != nil{
			aCoder.encode(isEnabled, forKey: "is_enabled")
		}
		if lastname != nil{
			aCoder.encode(lastname, forKey: "lastname")
		}
		if mobileno != nil{
			aCoder.encode(mobileno, forKey: "mobileno")
		}
		if uname != nil{
			aCoder.encode(uname, forKey: "uname")
		}
		if userPhoto != nil{
			aCoder.encode(userPhoto, forKey: "user_photo")
		}

	}

}
