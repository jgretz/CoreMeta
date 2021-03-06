//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class CMContainerRegistrationMap {
    var classRegistrations: Dictionary<String, CMContainerClassRegistration>
    var classMaps: Dictionary<String, CMContainerClassRegistrationMap>
    var protocolMaps: Dictionary<String, CMContainerProtocolRegistrationMap>

    init() {
        self.classRegistrations = Dictionary<String, CMContainerClassRegistration>()
        self.classMaps = Dictionary<String, CMContainerClassRegistrationMap>()
        self.protocolMaps = Dictionary<String, CMContainerProtocolRegistrationMap>()
    }

    //*******
    // Build
    //*******

    func addRegistration(_ registration: CMContainerClassRegistration) {
        self.classRegistrations[self.keyFromType(registration.type)] = registration
    }

    func addTypeMap(_ typeMap: CMContainerClassRegistrationMap) {
        if (!self.isTypeRegistered(typeMap.returnedClass)) {
            self.addRegistration(CMContainerClassRegistration(type: typeMap.returnedClass, cache: false, onCreate: nil))
        }

        self.classMaps[self.keyFromType(typeMap.replacedClass)] = typeMap
    }

    func addProtocolMap(_ protocolMap: CMContainerProtocolRegistrationMap) {
        if (!self.isTypeRegistered(protocolMap.returnedClass)) {
            self.addRegistration(CMContainerClassRegistration(type: protocolMap.returnedClass, cache: false, onCreate: nil))
        }

        self.protocolMaps[self.keyFromProtocol(protocolMap.forProtocol)] = protocolMap
    }

    //*****
    // Get
    //*****

    func isTypeRegistered(_ type: AnyClass) -> Bool {
        return self.classRegistrations.hasKey(self.keyFromType(type))
    }

    func isProtocolRegistered(_ p: Protocol) -> Bool {
        return self.protocolMaps.hasKey(self.keyFromProtocol(p))
    }

    func registrationForType(_ type: AnyClass) -> CMContainerClassRegistration? {
        let reqKey = keyFromType(type)
        if (!classMaps.hasKey(reqKey)) {
            return self.classRegistrations[reqKey]
        }

        let map = self.classMaps[reqKey];
        return self.classRegistrations[keyFromType(map!.returnedClass)]
    }

    func registrationForProtocol(_ p: Protocol) -> CMContainerProtocolRegistrationMap? {
        return self.protocolMaps[keyFromProtocol(p)]
    }

    //******
    // Keys
    //******

    fileprivate func keyFromType(_ type: AnyClass) -> String {
        return NSStringFromClass(type)
    }

    fileprivate func keyFromProtocol(_ p: Protocol) -> String {
        return NSStringFromProtocol(p)
    }
}
