

import Foundation
import UIKit

public enum ActionStyle {
    case `default`
    case cancel
    case destructive
}

public struct Action<T> {

    public var enabled: Bool
    public var executeImmediatelyOnTouch = false

    public fileprivate(set) var data: T?
    public fileprivate(set) var style = ActionStyle.default
    public fileprivate(set) var handler: ((Action<T>) -> Void)?

    public init(_ data: T?, style: ActionStyle, executeImmediatelyOnTouch: Bool = false, handler: ((Action<T>) -> Void)?) {
        enabled = true
        self.executeImmediatelyOnTouch = executeImmediatelyOnTouch
        self.data = data
        self.style = style
        self.handler = handler
    }

}
