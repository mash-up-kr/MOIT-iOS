//
//  MultipartFormData.swift
//  MOITNetworkImpl
//
//  Created by 최혜린 on 2023/05/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct FormData {
	var fieldName: String
	var fileName: String
	var mimeType: String
	var fileData: Data
}

public struct MultipartFormData {
	public typealias FormField = [String: String]

	public init(
		boundary: String = UUID().uuidString,
		formFields: FormField = [:],
		formDatas: [FormData] = []
	) {
		self.boundary = boundary

		formFields.forEach {
			self.body.append(convertToFormField(named: $0, value: $1))
		}

		formDatas.forEach {
			self.body.append(convertToData(formData: $0))
		}

		self.body.appendString("--\(boundary)--")
	}

	public var boundary: String
	public let body = NSMutableData()

	private func convertToFormField(
		named name: String,
		value: String
	) -> Data {
		let data = NSMutableData()

		data.appendString("--\(boundary)")
		data.appendLineBreak()
		data.appendString("Content-Disposition: form-data; name=\"\(name)\"")
		data.appendLineBreak(times: 2)
		data.appendString("\(value)")
		data.appendLineBreak()

		return data as Data
	}

	private func convertToData(
		formData: FormData
	) -> Data {
		let data = NSMutableData()

		data.appendString("--\(boundary)")
		data.appendLineBreak()
		data.appendString("Content-Disposition: form-data; name=\"\(formData.fieldName)\"; filename=\"\(formData.fileName)\"")
		data.appendLineBreak()
		data.appendString("Content-Type: \(formData.mimeType)")
		data.appendLineBreak(times: 2)
		data.append(formData.fileData)
		data.appendLineBreak()

		return data as Data
	}
}

extension NSMutableData {
	func appendString(_ string: String) {
		if let data = string.data(using: .utf8) {
			self.append(data)
		}
	}

	func appendLineBreak(times: Int = 1) {
		for _ in 0..<times {
			self.appendString("\r\n")
		}
	}
}
