//
//  Repository.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 25.02.22.
//

import Foundation
import RxSwift
import RealmSwift

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    var uid: String {get}
    func asRealm() -> RealmType
}

protocol RepositoryType {
    func query<T: RealmRepresentable>(entit: T.Type, with predicate: NSPredicate?) -> Observable<[T]> where T == T.RealmType.DomainType, T.RealmType: Object

    func query<T: RealmRepresentable>(entit: T.Type, with predicate: NSPredicate?) -> Single<T> where T == T.RealmType.DomainType, T.RealmType: Object

    func save<T: RealmRepresentable>(entity: T) -> Observable<Void> where T == T.RealmType.DomainType, T.RealmType: Object
    
    func delete<T: RealmRepresentable>(entity: T) -> Observable<Void> where T == T.RealmType.DomainType, T.RealmType: Object
}
