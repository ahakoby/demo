//
//  Words.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation

struct Words: DecodableModel {

    var text: String?
    let items: [Word]?
    
    private enum CodingKeys: String, CodingKey {
        case items = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.items = try? container.decode([Word].self)
    }
    
    init(items: [Word], text: String) {
        self.items = items
        self.text = text
    }
}

struct Word: DecodableModel {
    let id: Int?
    let text: String?
    var meanings: [Meaning]?
    
    private enum CodingKeys: String, CodingKey {
        case id, text, meanings
    }
}

extension Word {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.text = try? container.decode(String.self, forKey: .text)
        self.meanings = try? container.decode([Meaning].self, forKey: .meanings)
    }
    
}

struct Meaning: DecodableModel {
    let id: Int?
    let partOfSpeechCode: String?
    let translation: MITranslation?
    let previewUrl: String?
    let imageUrl: String?
    let transcription: String?
    let soundUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, partOfSpeechCode, translation, previewUrl, imageUrl, transcription, soundUrl
    }
}

extension Meaning {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.partOfSpeechCode = try? container.decode(String.self, forKey: .partOfSpeechCode)
        self.previewUrl = try? container.decode(String.self, forKey: .previewUrl)
        self.imageUrl = try? container.decode(String.self, forKey: .imageUrl)
        self.transcription = try? container.decode(String.self, forKey: .transcription)
        self.soundUrl = try? container.decode(String.self, forKey: .soundUrl)
        self.translation = try? container.decode(MITranslation.self, forKey: .translation)
    }
}
