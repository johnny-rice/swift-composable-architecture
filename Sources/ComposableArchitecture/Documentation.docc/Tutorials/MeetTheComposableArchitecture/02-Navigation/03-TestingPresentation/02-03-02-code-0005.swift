import ComposableArchitecture
import Foundation
import Testing

@testable import ContactsApp

@MainActor
struct ContactsFeatureTests {
  @Test
  func addFlowNonExhaustive() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: {
      $0.uuid = .incrementing
    }
    store.exhaustivity = .off
    
    await store.send(.addButtonTapped)
    await store.send(\.destination.addContact.setName, "Blob Jr.")
    await store.send(\.destination.addContact.saveButtonTapped)
    await store.skipReceivedActions()
  }
}
