//
//  Meanings.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation

struct Meanings: DecodableModel {

    let items: [MeaningItem]?
    
    private enum CodingKeys: String, CodingKey {
        case items = ""
    }
}

extension Meanings {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.items = try? container.decode([MeaningItem].self)
    }
}


struct MeaningItem:DecodableModel {
    let id: String?
    let wordId: Int?
    let difficultyLevel: Int?
    let partOfSpeechCode: String?
    let prefix: String?
    let text: String?
    let soundUrl: String?
    let transcription: String?
    let updatedAt: String?
    let mnemonics: String?
    let translation: MITranslation?
    let images: [MIImage]?
    let definition: MIDefinition?
    let examples: [MIExample]?
    let meaningsWithSimilarTranslation: [MIMeaningsWithSimilarTranslation]?
    let alternativeTranslations: [MIAlternativeTranslations]?
    
    private enum CodingKeys: String, CodingKey {
        case id, wordId, difficultyLevel, partOfSpeechCode, prefix, text, soundUrl, transcription, updatedAt, mnemonics, translation, images, definition, examples, meaningsWithSimilarTranslation, alternativeTranslations
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.wordId = try? container.decode(Int.self, forKey: .wordId)
        self.difficultyLevel = try? container.decode(Int.self, forKey: .difficultyLevel)
        self.partOfSpeechCode = try? container.decode(String.self, forKey: .partOfSpeechCode)
        self.prefix = try? container.decode(String.self, forKey: .prefix)
        self.soundUrl = try? container.decode(String.self, forKey: .soundUrl)
        self.text = try? container.decode(String.self, forKey: .text)
        self.transcription = try? container.decode(String.self, forKey: .transcription)
        self.updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        self.mnemonics = try? container.decode(String.self, forKey: .mnemonics)
        self.translation = try? container.decode(MITranslation.self, forKey: .translation)
        self.images = try? container.decode([MIImage].self, forKey: .images)
        self.definition = try? container.decode(MIDefinition.self, forKey: .definition)
        self.examples = try? container.decode([MIExample].self, forKey: .examples)
        self.meaningsWithSimilarTranslation = try? container.decode([MIMeaningsWithSimilarTranslation].self, forKey: .meaningsWithSimilarTranslation)
        self.alternativeTranslations = try? container.decode([MIAlternativeTranslations].self, forKey: .alternativeTranslations)

    }
}

struct MIImage: DecodableModel {
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try? container.decode(String.self, forKey: .url)
    }
}
struct MITranslation: DecodableModel {
    let text: String?
    let note: String?
    
    private enum CodingKeys: String, CodingKey {
        case text, note
    }
}

extension MITranslation {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try? container.decode(String.self, forKey: .text)
        self.note = try? container.decode(String.self, forKey: .note)
    }
}

struct MIDefinition: DecodableModel {
    let text: String?
    let soundUrl: String?

    private enum CodingKeys: String, CodingKey {
        case text, soundUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try? container.decode(String.self, forKey: .text)
        self.soundUrl = try? container.decode(String.self, forKey: .soundUrl)
    }
}
struct MIExample: DecodableModel {
    let text: String?
    let soundUrl: String?

    private enum CodingKeys: String, CodingKey {
        case text, soundUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try? container.decode(String.self, forKey: .text)
        self.soundUrl = try? container.decode(String.self, forKey: .soundUrl)
    }
}
struct MIMeaningsWithSimilarTranslation: DecodableModel {
    let meaningId: Int?
    let frequencyPercent: String?
    let partOfSpeechAbbreviation: String?
    let translation: MITranslation?

    private enum CodingKeys: String, CodingKey {
        case meaningId, frequencyPercent, partOfSpeechAbbreviation, translation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.meaningId = try? container.decode(Int.self, forKey: .meaningId)
        self.frequencyPercent = try? container.decode(String.self, forKey: .frequencyPercent)
        self.partOfSpeechAbbreviation = try? container.decode(String.self, forKey: .partOfSpeechAbbreviation)
        self.translation = try? container.decode(MITranslation.self, forKey: .translation)

    }
}

struct MIAlternativeTranslations: DecodableModel {
    let text: String?
    let translation: MITranslation?

    private enum CodingKeys: String, CodingKey {
        case text, translation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try? container.decode(String.self, forKey: .text)
        self.translation = try? container.decode(MITranslation.self, forKey: .translation)
    }
}
