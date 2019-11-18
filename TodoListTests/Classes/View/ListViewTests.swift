//
//  ListViewTests.swift
//  TodoListTests
//
//  Created by William on 18/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TodoList
class ListViewTests: XCTestCase {
  var mockEvent: MockListEvent?
  var view: ListViewController?

  var mockPersistentContainer: MockPersistentContainer?
  var mockCoreDataManager: MockCoreDataManager?

  override func setUp() {
    mockPersistentContainer = MockPersistentContainer()
    mockCoreDataManager = MockCoreDataManager(persistentContainer: mockPersistentContainer!.container)

    mockEvent = MockListEvent()

    view = ListViewController()
    view?.event = mockEvent
  }

  override func tearDown() {
    mockCoreDataManager?.deleteData(TodoList.entityName())
  }

  func testFetchTodoList() {
    view?.viewDidLoad()

    XCTAssert(mockEvent?.invokedFetchTodoList == true, "Expect fetch todo list is called")
    XCTAssert(mockEvent?.invokedFetchTodoListCount == 1, "Expect fetch todo list is called once")
  }

  func testPerformanceExample() {
      // This is an example of a performance test case.
      self.measure {
          // Put the code you want to measure the time of here.
      }
  }

}