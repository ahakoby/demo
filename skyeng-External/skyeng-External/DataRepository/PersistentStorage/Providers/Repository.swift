//
//  Repository.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 25.02.22.
//

import Foundation
import Alamofire
import RxSwift
import Realm
import RealmSwift
import RxRealm

final class Repository: RepositoryType {

    func query<T>(entit: T.Type, with
                  predicate: NSPredicate?) -> Observable<[T]>
    where T : RealmRepresentable, T == T.RealmType.DomainType, T.RealmType : RealmSwiftObject {
        return Observable.deferred {
                    let realm = self.realm
                    var objects = realm.objects(T.RealmType.self)
                    if predicate != nil {
                        objects = objects.filter(predicate!)
                    }
                    
                    return Observable.array(from: objects)
                            .mapToDomain()
                            
                }
                .subscribeOn(scheduler)
    }
    
    func query<T>(entit: T.Type,
                  with predicate: NSPredicate?) -> Single<T>
    where T : RealmRepresentable, T == T.RealmType.DomainType, T.RealmType : RealmSwiftObject {
        return Single<T>.create { [weak self](single) -> Disposable in
                var objects = self?.realm.objects(T.RealmType.self)
                if predicate != nil {
                    objects = objects?.filter(predicate!)
                }
            
                if let object = objects?.last {
                    single(.success(object.asDomain()))
                } else {                    
                    single(.error(RmError(reason: .entityNotFound(key: predicate?.description ?? "Word"))))
                }
                return Disposables.create {}
            }
            .asObservable()
            .asSingle()
            .subscribeOn(scheduler)
    }
    
    func save<T>(entity: T) -> Observable<Void>
    where T : RealmRepresentable, T == T.RealmType.DomainType, T.RealmType : RealmSwiftObject {
        return Observable.deferred {
            return self.realm.rx.save(entity: entity)
        }.subscribeOn(scheduler)
    }
    
    func delete<T>(entity: T) -> Observable<Void>
    where T : RealmRepresentable, T == T.RealmType.DomainType, T.RealmType : RealmSwiftObject {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
        }.subscribeOn(scheduler)
    }
    


    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        let name = "com.skyeng.RealmPlatform.Repository"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        Log.debug("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }
}
