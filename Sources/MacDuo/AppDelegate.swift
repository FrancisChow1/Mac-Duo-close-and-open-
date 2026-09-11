import AppKit
import CoreGraphics
import ServiceManagement

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {

    private var controller: LidController?
    private var statusItemController: StatusItemController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let hasScreenPermission = CGPreflightScreenCaptureAccess()
        Diagnostics.geometry.notice("launched, screen recording granted: \(hasScreenPermission)")
        // The operating system owns this consent flow. Request it once rather
        // than attempting to change Privacy & Security settings ourselves.
        if !hasScreenPermission { _ = CGRequestScreenCaptureAccess() }
        enableLaunchAtLogin()
        let preferences = Preferences.shared
        let controller = LidController(preferences: preferences)
        self.controller = controller
        statusItemController = StatusItemController(controller: controller, preferences: preferences)
        controller.start()
    }

    func applicationWillTerminate(_ notification: Notification) {
        controller?.stop()
    }

    /// Use the project's native login-item API only after the app has been
    /// installed in /Applications and signed. macOS remains the authority for
    /// showing, approving, or disabling this item in Login Items.
    private func enableLaunchAtLogin() {
        let service = SMAppService.mainApp
        guard service.status != .enabled else { return }
        do {
            try service.register()
            Diagnostics.geometry.notice("registered launch at login")
        } catch {
            Diagnostics.geometry.error("launch at login registration failed: \(String(describing: error), privacy: .public)")
        }
    }
}
