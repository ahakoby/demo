//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle

  let reuseIdentifier = reuseIdentifier()

  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func nib(bundle: Foundation.Bundle) -> nib {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.nib.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.localizable` struct is generated, and contains static references to 2 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source

      /// en translation: Meanings
      ///
      /// Key: title_meaning
      ///
      /// Locales: en, ru
      var title_meaning: RswiftResources.StringResource { .init(key: "title_meaning", tableName: "Localizable", source: source, developmentValue: "Meanings", comment: nil) }

      /// en translation: skyeng
      ///
      /// Key: title_skyeng
      ///
      /// Locales: en, ru
      var title_skyeng: RswiftResources.StringResource { .init(key: "title_skyeng", tableName: "Localizable", source: source, developmentValue: "skyeng", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 1 colors, and 2 namespaces.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
    var dark: dark { .init(bundle: bundle) }
    var light: light { .init(bundle: bundle) }

    func dark(bundle: Foundation.Bundle) -> dark {
      .init(bundle: bundle)
    }
    func light(bundle: Foundation.Bundle) -> light {
      .init(bundle: bundle)
    }


    /// This `_R.color.dark` struct is generated, and contains static references to 0 darks, and 1 namespaces.
    struct dark {
      let bundle: Foundation.Bundle
      var colors: colors { .init(bundle: bundle) }

      func colors(bundle: Foundation.Bundle) -> colors {
        .init(bundle: bundle)
      }


      /// This `_R.color.dark.colors` struct is generated, and contains static references to 2 colorss.
      struct colors {
        let bundle: Foundation.Bundle

        /// Color `dark/colors/BG`.
        var bG: RswiftResources.ColorResource { .init(name: "dark/colors/BG", path: ["dark", "colors"], bundle: bundle) }

        /// Color `dark/colors/Text`.
        var text: RswiftResources.ColorResource { .init(name: "dark/colors/Text", path: ["dark", "colors"], bundle: bundle) }
      }
    }

    /// This `_R.color.light` struct is generated, and contains static references to 0 lights, and 1 namespaces.
    struct light {
      let bundle: Foundation.Bundle
      var colors: colors { .init(bundle: bundle) }

      func colors(bundle: Foundation.Bundle) -> colors {
        .init(bundle: bundle)
      }


      /// This `_R.color.light.colors` struct is generated, and contains static references to 2 colorss.
      struct colors {
        let bundle: Foundation.Bundle

        /// Color `light/colors/BG`.
        var bG: RswiftResources.ColorResource { .init(name: "light/colors/BG", path: ["light", "colors"], bundle: bundle) }

        /// Color `light/colors/Text`.
        var text: RswiftResources.ColorResource { .init(name: "light/colors/Text", path: ["light", "colors"], bundle: bundle) }
      }
    }
  }

  /// This `_R.image` struct is generated, and contains static references to 0 images, and 2 namespaces.
  struct image {
    let bundle: Foundation.Bundle
    var dark: dark { .init(bundle: bundle) }
    var light: light { .init(bundle: bundle) }

    func dark(bundle: Foundation.Bundle) -> dark {
      .init(bundle: bundle)
    }
    func light(bundle: Foundation.Bundle) -> light {
      .init(bundle: bundle)
    }


    /// This `_R.image.dark` struct is generated, and contains static references to 0 darks, and 1 namespaces.
    struct dark {
      let bundle: Foundation.Bundle
      var images: images { .init(bundle: bundle) }

      func images(bundle: Foundation.Bundle) -> images {
        .init(bundle: bundle)
      }


      /// This `_R.image.dark.images` struct is generated, and contains static references to 1 imagess.
      struct images {
        let bundle: Foundation.Bundle

        /// Image `dark/images/SkyengNew`.
        var skyengNew: RswiftResources.ImageResource { .init(name: "dark/images/SkyengNew", path: ["dark", "images"], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
      }
    }

    /// This `_R.image.light` struct is generated, and contains static references to 0 lights, and 1 namespaces.
    struct light {
      let bundle: Foundation.Bundle
      var images: images { .init(bundle: bundle) }

      func images(bundle: Foundation.Bundle) -> images {
        .init(bundle: bundle)
      }


      /// This `_R.image.light.images` struct is generated, and contains static references to 1 imagess.
      struct images {
        let bundle: Foundation.Bundle

        /// Image `light/images/SkyengNew`.
        var skyengNew: RswiftResources.ImageResource { .init(name: "light/images/SkyengNew", path: ["light", "images"], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
      }
    }
  }

  /// This `_R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    let bundle: Foundation.Bundle

    /// Nib `TableViewCell`.
    var tableViewCell: RswiftResources.NibReferenceReuseIdentifier<TableViewCell, TableViewCell> { .init(name: "TableViewCell", bundle: bundle, identifier: "tableViewCell") }

    func validate() throws {

    }
  }

  /// This `_R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {

    /// Reuse identifier `MeaningCell`.
    let meaningCell: RswiftResources.ReuseIdentifier<MeaningTableViewCell> = .init(identifier: "MeaningCell")

    /// Reuse identifier `tableViewCell`.
    let tableViewCell: RswiftResources.ReuseIdentifier<TableViewCell> = .init(identifier: "tableViewCell")

    /// Reuse identifier `TitleTableViewCell`.
    let titleTableViewCell: RswiftResources.ReuseIdentifier<TitleTableViewCell> = .init(identifier: "TitleTableViewCell")
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }
    var loading: loading { .init(bundle: bundle) }
    var search: search { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func loading(bundle: Foundation.Bundle) -> loading {
      .init(bundle: bundle)
    }
    func search(bundle: Foundation.Bundle) -> search {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
      try self.loading.validate()
      try self.search.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {
        if UIKit.UIImage(named: "SkyengNew", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'SkyengNew' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
    }

    /// Storyboard `Loading`.
    struct loading: RswiftResources.StoryboardReference {
      let bundle: Foundation.Bundle

      let name = "Loading"

      var loadingViewController: RswiftResources.StoryboardViewControllerIdentifier<LoadingViewController> { .init(identifier: "LoadingViewController", storyboard: name, bundle: bundle) }

      func validate() throws {
        if loadingViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'loadingViewController' could not be loaded from storyboard 'Loading' as 'LoadingViewController'.") }
      }
    }

    /// Storyboard `Search`.
    struct search: RswiftResources.StoryboardReference {
      let bundle: Foundation.Bundle

      let name = "Search"

      var detailsViewController: RswiftResources.StoryboardViewControllerIdentifier<DetailsViewController> { .init(identifier: "DetailsViewController", storyboard: name, bundle: bundle) }
      var resultViewController: RswiftResources.StoryboardViewControllerIdentifier<ResultViewController> { .init(identifier: "ResultViewController", storyboard: name, bundle: bundle) }
      var searchViewController: RswiftResources.StoryboardViewControllerIdentifier<SearchViewController> { .init(identifier: "SearchViewController", storyboard: name, bundle: bundle) }

      func validate() throws {
        if detailsViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'detailsViewController' could not be loaded from storyboard 'Search' as 'DetailsViewController'.") }
        if resultViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'resultViewController' could not be loaded from storyboard 'Search' as 'ResultViewController'.") }
        if searchViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'searchViewController' could not be loaded from storyboard 'Search' as 'SearchViewController'.") }
      }
    }
  }
}