//
//  APIDataModels.swift
//  grokkoli
//
//  Created by Jen on 11/7/24.
//


	struct TestGlucoseDataModel: Decodable, Equatable{
		let id: String
		let glucoseLevel: Int
		let riskStatus: String
		let timestamp: String
	}

	struct TestUserDataModel: Decodable, Equatable {
		let name: String
		let id: String
		let age: Int
		let healthStatus: String
	}
