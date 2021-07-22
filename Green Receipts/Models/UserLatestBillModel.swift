//
//	UserLatestBillModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserLatestBillModel : NSObject, NSCoding{

	var billData : String!
	var billImg : String!
	var billLocation : String!
	var billPdf : String!
	var billStore : String!
	var billStoreno : String!
	var billTimestamp : String!
	var billTxt : String!
	var billname : String!
	var entryDate : String!
	var entryTime : String!
	var irano : String!
	var isDeleted : String!
	var isEnabled : String!
	var qrCode : String!
	var qrPhoto : String!
	var totReceipt : String!


    override init() {
        super .init()
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        let utilityObject = CommonUtility()
        
        if let billData = dictionary["bill_data"]
        {
            if(utilityObject.hasValue(object: billData as AnyObject))
            {
                self.billData = billData as? String
            }
        }
        if let billImg = dictionary["bill_img"]
        {
            if(utilityObject.hasValue(object: billImg as AnyObject))
            {
                self.billImg = billImg as? String
            }
        }
        if let billLocation = dictionary["bill_location"]
        {
            if(utilityObject.hasValue(object: billLocation as AnyObject))
            {
                self.billLocation = billLocation as? String
            }
        }
        if let billPdf = dictionary["bill_pdf"]
        {
            if(utilityObject.hasValue(object: billPdf as AnyObject))
            {
                self.billPdf = billPdf as? String
            }
        }
        if let billStore = dictionary["bill_store"]
        {
            if(utilityObject.hasValue(object: billStore as AnyObject))
            {
                self.billStore = billStore as? String
            }
        }
        if let billStoreno = dictionary["bill_storeno"]
        {
            if(utilityObject.hasValue(object: billStoreno as AnyObject))
            {
                self.billStoreno = billStoreno as? String
            }
        }
        if let billTimestamp = dictionary["bill_timestamp"]
        {
            if(utilityObject.hasValue(object: billTimestamp as AnyObject))
            {
                self.billTimestamp = billTimestamp as? String
            }
        }
        if let billTxt = dictionary["bill_txt"]
        {
            if(utilityObject.hasValue(object: billTxt as AnyObject))
            {
                self.billTxt = billTxt as? String
            }
        }
        if let billname = dictionary["billname"]
        {
            if(utilityObject.hasValue(object: billname as AnyObject))
            {
                self.billname = billname as? String
            }
        }
        if let entryDate = dictionary["entry_date"]
        {
            if(utilityObject.hasValue(object: entryDate as AnyObject))
            {
                self.entryDate = entryDate as? String
            }
        }
        if let entryTime = dictionary["entry_time"]
        {
            if(utilityObject.hasValue(object: entryTime as AnyObject))
            {
                self.entryTime = entryTime as? String
            }
        }
        if let irano = dictionary["irano"]
        {
            if(utilityObject.hasValue(object: irano as AnyObject))
            {
                self.irano = irano as? String
            }
        }
        if let isDeleted = dictionary["is_deleted"]
        {
            if(utilityObject.hasValue(object: isDeleted as AnyObject))
            {
                self.isDeleted = isDeleted as? String
            }
        }
        if let isEnabled = dictionary["is_enabled"]
        {
            if(utilityObject.hasValue(object: isEnabled as AnyObject))
            {
                self.isEnabled = isEnabled as? String
            }
        }
        if let qrCode = dictionary["qr_code"]
        {
            if(utilityObject.hasValue(object: qrCode as AnyObject))
            {
                self.qrCode = qrCode as? String
            }
        }
        if let qrPhoto = dictionary["qr_photo"]
        {
            if(utilityObject.hasValue(object: qrPhoto as AnyObject))
            {
                self.qrPhoto = qrPhoto as? String
            }
        }
		if let totReceipt = dictionary["totReceipt"]
        {
            if(utilityObject.hasValue(object: totReceipt as AnyObject))
            {
                self.totReceipt = totReceipt as? String
            }
        }
		
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if billData != nil{
			dictionary["bill_data"] = billData
		}
		if billImg != nil{
			dictionary["bill_img"] = billImg
		}
		if billLocation != nil{
			dictionary["bill_location"] = billLocation
		}
		if billPdf != nil{
			dictionary["bill_pdf"] = billPdf
		}
		if billStore != nil{
			dictionary["bill_store"] = billStore
		}
		if billStoreno != nil{
			dictionary["bill_storeno"] = billStoreno
		}
		if billTimestamp != nil{
			dictionary["bill_timestamp"] = billTimestamp
		}
		if billTxt != nil{
			dictionary["bill_txt"] = billTxt
		}
		if billname != nil{
			dictionary["billname"] = billname
		}
		if entryDate != nil{
			dictionary["entry_date"] = entryDate
		}
		if entryTime != nil{
			dictionary["entry_time"] = entryTime
		}
		if irano != nil{
			dictionary["irano"] = irano
		}
		if isDeleted != nil{
			dictionary["is_deleted"] = isDeleted
		}
		if isEnabled != nil{
			dictionary["is_enabled"] = isEnabled
		}
		if qrCode != nil{
			dictionary["qr_code"] = qrCode
		}
		if qrPhoto != nil{
			dictionary["qr_photo"] = qrPhoto
		}
		if totReceipt != nil{
			dictionary["totReceipt"] = totReceipt
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         billData = aDecoder.decodeObject(forKey: "bill_data") as? String
         billImg = aDecoder.decodeObject(forKey: "bill_img") as? String
         billLocation = aDecoder.decodeObject(forKey: "bill_location") as? String
         billPdf = aDecoder.decodeObject(forKey: "bill_pdf") as? String
         billStore = aDecoder.decodeObject(forKey: "bill_store") as? String
         billStoreno = aDecoder.decodeObject(forKey: "bill_storeno") as? String
         billTimestamp = aDecoder.decodeObject(forKey: "bill_timestamp") as? String
         billTxt = aDecoder.decodeObject(forKey: "bill_txt") as? String
         billname = aDecoder.decodeObject(forKey: "billname") as? String
         entryDate = aDecoder.decodeObject(forKey: "entry_date") as? String
         entryTime = aDecoder.decodeObject(forKey: "entry_time") as? String
         irano = aDecoder.decodeObject(forKey: "irano") as? String
         isDeleted = aDecoder.decodeObject(forKey: "is_deleted") as? String
         isEnabled = aDecoder.decodeObject(forKey: "is_enabled") as? String
         qrCode = aDecoder.decodeObject(forKey: "qr_code") as? String
         qrPhoto = aDecoder.decodeObject(forKey: "qr_photo") as? String
         totReceipt = aDecoder.decodeObject(forKey: "totReceipt") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if billData != nil{
			aCoder.encode(billData, forKey: "bill_data")
		}
		if billImg != nil{
			aCoder.encode(billImg, forKey: "bill_img")
		}
		if billLocation != nil{
			aCoder.encode(billLocation, forKey: "bill_location")
		}
		if billPdf != nil{
			aCoder.encode(billPdf, forKey: "bill_pdf")
		}
		if billStore != nil{
			aCoder.encode(billStore, forKey: "bill_store")
		}
		if billStoreno != nil{
			aCoder.encode(billStoreno, forKey: "bill_storeno")
		}
		if billTimestamp != nil{
			aCoder.encode(billTimestamp, forKey: "bill_timestamp")
		}
		if billTxt != nil{
			aCoder.encode(billTxt, forKey: "bill_txt")
		}
		if billname != nil{
			aCoder.encode(billname, forKey: "billname")
		}
		if entryDate != nil{
			aCoder.encode(entryDate, forKey: "entry_date")
		}
		if entryTime != nil{
			aCoder.encode(entryTime, forKey: "entry_time")
		}
		if irano != nil{
			aCoder.encode(irano, forKey: "irano")
		}
		if isDeleted != nil{
			aCoder.encode(isDeleted, forKey: "is_deleted")
		}
		if isEnabled != nil{
			aCoder.encode(isEnabled, forKey: "is_enabled")
		}
		if qrCode != nil{
			aCoder.encode(qrCode, forKey: "qr_code")
		}
		if qrPhoto != nil{
			aCoder.encode(qrPhoto, forKey: "qr_photo")
		}
		if totReceipt != nil{
			aCoder.encode(totReceipt, forKey: "totReceipt")
		}

	}

}
