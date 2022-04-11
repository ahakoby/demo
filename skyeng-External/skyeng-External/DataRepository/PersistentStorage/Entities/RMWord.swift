//
//  RMWord.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 10.04.22.
//

import Foundation
import RealmSwift

final class RMWords: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var word: String = ""
    let items = List<RMWord>()// [RMWord] = []
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMWords: DomainConvertibleType {
    func asDomain() -> Words {
        return Words(items: items.map({$0.asDomain()}),
                     text: word)
    }
}

extension Words: RealmRepresentable {
    var uid: String {
        return ""
    }
    
    func asRealm() -> RMWords {
        return RMWords.build { object in
            object.uid = UUID.init().uuidString
            object.word = text ?? ""
            items?.forEach({
                object.items.append($0.asRealm())
            })
        }
    }
}

final class RMWord: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var text: String = ""
    let meanings = List<RMMeaning>()
        
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMWord: DomainConvertibleType {
    func asDomain() -> Word {
        return Word(id: Int(uid),
                    text: text,
                    meanings: meanings.map({ $0.asDomain() }))
    }
}

extension Word: RealmRepresentable {
    var uid: String {
        ""
    }
    
    func asRealm() -> RMWord {
        return RMWord.build { object in
            object.uid = "\(String(describing: id))"
            object.text = text ?? ""
            meanings?.forEach({object.meanings.append($0.asRealm())})
        }
    }
}

final class RMMeaning: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var partOfSpeechCode: String = ""
    @objc dynamic var translation: RMMITranslation?
    @objc dynamic var previewUrl: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var transcription: String = ""
    @objc dynamic var soundUrl: String = ""
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMMeaning: DomainConvertibleType {
    func asDomain() -> Meaning {
        return Meaning(id: Int(uid),
                       partOfSpeechCode: partOfSpeechCode,
                       translation: translation?.asDomain(),
                       previewUrl: previewUrl,
                       imageUrl: imageUrl,
                       transcription: transcription,
                       soundUrl: soundUrl)
    }
}

extension Meaning: RealmRepresentable {
    var uid: String {
        ""
    }
    
    func asRealm() -> RMMeaning {
        return RMMeaning.build { object in
            object.uid = "\(String(describing: id))"
            object.partOfSpeechCode = partOfSpeechCode ?? ""
            object.translation = translation?.asRealm()
            object.previewUrl = previewUrl ?? ""
            object.imageUrl = imageUrl ?? ""
            object.transcription = transcription ?? ""
            object.soundUrl = soundUrl ?? ""
        }
    }
}

final class RMMITranslation: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var note: String = ""
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMMITranslation: DomainConvertibleType {
    func asDomain() -> MITranslation {
        return MITranslation(text: text,
                             note: note)
    }
}

extension MITranslation: RealmRepresentable {
    var uid: String {
        ""
    }
    
    func asRealm() -> RMMITranslation {
        return RMMITranslation.build { object in
            object.uid = UUID.init().uuidString
            object.text = text ?? ""
            object.note = note ?? ""
        }
    }
}
