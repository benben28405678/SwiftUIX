//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

/// An internal structure used to manage cell preferences for `CocoaList` and `CollectionView`.
@usableFromInline
struct _CollectionOrListCellPreferences: Equatable {
    var isFocusable = true
    var isHighlightable = true
    var isReorderable = true
    var isSelectable = true
}

extension _CollectionOrListCellPreferences {
    /// An internal preference key that defines a list row's preferences.
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static let defaultValue = _CollectionOrListCellPreferences()
        
        static func reduce(value: inout _CollectionOrListCellPreferences, nextValue: () -> _CollectionOrListCellPreferences) {
            value = nextValue()
        }
    }
}

extension View {
    public func cellFocusable(_ focusable: Bool) -> some View {
        transformPreference(_CollectionOrListCellPreferences.PreferenceKey.self) { value in
            value.isFocusable = focusable
        }
    }
    
    public func cellHighlightable(_ highlightable: Bool) -> some View {
        transformPreference(_CollectionOrListCellPreferences.PreferenceKey.self) { value in
            value.isHighlightable = highlightable
        }
    }
    
    public func cellReorderable(_ reorderable: Bool) -> some View {
        transformPreference(_CollectionOrListCellPreferences.PreferenceKey.self) { value in
            value.isReorderable = reorderable
        }
    }
    
    public func cellSelectable(_ selectable: Bool) -> some View {
        transformPreference(_CollectionOrListCellPreferences.PreferenceKey.self) { value in
            value.isSelectable = selectable
        }
    }
}

// MARK: - Auxiliary Implementation -

extension EnvironmentValues {
    private struct IsCellFocused: EnvironmentKey {
        static let defaultValue = false
    }

    private struct IsCellHighlighted: EnvironmentKey {
        static let defaultValue = false
    }
    
    private struct IsCellSelected: EnvironmentKey {
        static let defaultValue = false
    }
    
    public var isCellFocused: Bool {
        get {
            self[IsCellFocused]
        } set {
            self[IsCellFocused] = newValue
        }
    }
    
    public var isCellHighlighted: Bool {
        get {
            self[IsCellHighlighted]
        } set {
            self[IsCellHighlighted] = newValue
        }
    }

    public var isCellSelected: Bool {
        get {
            self[IsCellSelected]
        } set {
            self[IsCellSelected] = newValue
        }
    }
}