//
//	UserCameraUploadedBillModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserCameraUploadedBillModel : NSObject, NSCoding{

	var billImg : String!
	var billStore : String!
	var billTimestamp : String!
	var billname : String!
	var irano : String!
	var isEnabled : String!
	var uploadBy : String!


    override init() {
        super .init()
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        
        let utilityObject = CommonUtility()
        
        if let billImg = dictionary["bill_img"]
        {
            if(utilityObject.hasValue(object: billImg as AnyObject))
            {
                self.billImg = billImg as? String
            }
        }
        if let billStore = dictionary["bill_store"]
        {
            if(utilityObject.hasValue(object: billStore as AnyObject))
            {
                self.billStore = billStore as? String
            }
        }
        if let billTimestamp = dictionary["bill_timestamp"]
        {
            if(utilityObject.hasValue(object: billTimestamp as AnyObject))
            {
                self.billTimestamp = billTimestamp as? String
            }
        }
        if let billname = dictionary["billname"]
        {
            if(utilityObject.hasValue(object: billname as AnyObject))
            {
                self.billname = billname as? String
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
        if let uploadBy = dictionary["upload_by"]
        {
            if(utilityObject.hasValue(object: uploadBy as AnyObject))
            {
                self.uploadBy = uploadBy as? String
            }
        }
        
		
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if billImg != nil{
			dictionary["bill_img"] = billImg
		}
		if billStore != nil{
			dictionary["bill_store"] = billStore
		}
		if billTimestamp != nil{
			dictionary["bill_timestamp"] = billTimestamp
		}
		if billname != nil{
			dictionary["billname"] = billname
		}
		if irano != nil{
			dictionary["irano"] = irano
		}
		if isEnabled != nil{
			dictionary["is_enabled"] = isEnabled
		}
		if uploadBy != nil{
			dictionary["upload_by"] = uploadBy
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         billImg = aDecoder.decodeObject(forKey: "bill_img") as? String
         billStore = aDecoder.decodeObject(forKey: "bill_store") as? String
         billTimestamp = aDecoder.decodeObject(forKey: "bill_timestamp") as? String
         billname = aDecoder.decodeObject(forKey: "billname") as? String
         irano = aDecoder.decodeObject(forKey: "irano") as? String
         isEnabled = aDecoder.decodeObject(forKey: "is_enabled") as? String
         uploadBy = aDecoder.decodeObject(forKey: "upload_by") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if billImg != nil{
			aCoder.encode(billImg, forKey: "bill_img")
		}
		if billStore != nil{
			aCoder.encode(billStore, forKey: "bill_store")
		}
		if billTimestamp != nil{
			aCoder.encode(billTimestamp, forKey: "bill_timestamp")
		}
		if billname != nil{
			aCoder.encode(billname, forKey: "billname")
		}
		if irano != nil{
			aCoder.encode(irano, forKey: "irano")
		}
		if isEnabled != nil{
			aCoder.encode(isEnabled, forKey: "is_enabled")
		}
		if uploadBy != nil{
			aCoder.encode(uploadBy, forKey: "upload_by")
		}

	}

}
