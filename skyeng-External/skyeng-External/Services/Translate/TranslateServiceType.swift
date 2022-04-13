//
//  TranslateService.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import RxSwift

protocol TranslateServiceType {

    func meanings(ids: String) -> Single<Meanings>?
    func search(text: String) -> Single<Words>

}

// Online
protocol TranslateOnlineServiceType: TranslateServiceType,
                                     TranslateStorableServiceType {}


// Offline
protocol TranslateOfflineServiceType: TranslateServiceType {

    @discardableResult func save(_ meanings: Meanings) -> Observable<Void>?
    @discardableResult func save(_ words: Words) -> Observable<Void>?
    
}

//Mediator DataRepository (online, offline, mock, ...)
protocol AnyExecutableTranslateService {
    associatedtype T
    func make() -> T//TranslateServiceType
}

enum AnyTranslateExecutable: String {
    case online
    case offline
}

extension AnyTranslateExecutable: AnyExecutableTranslateService {
    func make() -> TranslateServiceType {
        switch self {
        case .online:
            return Dependency.shared.resolver.resolve(TranslateOnlineServiceType.self)!
        case .offline:
            return Dependency.shared.resolver.resolve(TranslateOfflineServiceType.self)!
        }
    }
}

// RealmRepresentable
protocol TranslateStorableServiceType {
    var translateOfflieService: TranslateOfflineServiceType {get}
}

extension TranslateStorableServiceType {
    var translateOfflieService: TranslateOfflineServiceType {
        return AnyTranslateExecutable.offline.make() as! TranslateOfflineServiceType
    }
}



// sourcery:autoinject
final class TranslateOnlineService: TranslateOnlineServiceType {
    
    private let provider: NetworkProviderType
    
    init(provider: NetworkProviderType) {
        self.provider = provider
    }
    
    func meanings(ids: String) -> Single<Meanings>? {
        
        return self.provider.createResponseSingle(route: TranslateRouter.meanings(ids: ids))
            .do(onSuccess: { meenings in
                self.translateOfflieService.save(meenings)
            })
    }
    
    func search(text: String) -> Single<Words> {
        return self.provider.createResponseSingle(route: TranslateRouter.search(text: text))
            .do(onSuccess: { words in
                var _words = words
                _words.text = text.lowercased()
                self.translateOfflieService.save(_words)
            })
    }
}

final class TranslateOfflineService: TranslateOfflineServiceType {
    
    private let repository: RepositoryType
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    func meanings(ids: String) -> Single<Meanings>? {
        return nil
    }
    
    func search(text: String) -> Single<Words> {
        return self.repository.query(entit: Words.self,
                                     with: NSPredicate(format: "word = %@", text.lowercased()))
    }
    
    @discardableResult func save(_ meanings: Meanings) -> Observable<Void>? {
        return nil
    }
    
    @discardableResult func save(_ words: Words) -> Observable<Void>? {
        return self.repository.save(entity: words)
    }
    
}
