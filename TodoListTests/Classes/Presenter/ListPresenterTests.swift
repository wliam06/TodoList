//
//  ListPresenterTests.swift
//  TodoListTests
//
//  Created by William on 18/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TodoList
class ListPresenterTests: XCTestCase {
  var mockRouter: MockListRouter?
  var mockView: MockListView?
  var mockInteractor: MockListInteractorInput?

  var mockPersistentContainer: MockPersistentContainer?
  var mockCoreDataManager: MockCoreDataManager?
  var presenter: ListPresenter?

  override func setUp() {
    mockPersistentContainer = MockPersistentContainer()
    mockCoreDataManager = MockCoreDataManager(persistentContainer: mockPersistentContainer!.container)

    mockRouter = MockListRouter()
    mockView = MockListView()
    mockInteractor = MockListInteractorInput()

    presenter = ListPresenter(view: mockView!, interactor: mockInteractor!, router: mockRouter!)
    presenter?.view = mockView
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
    mockCoreDataManager?.deleteData(TodoList.entityName())
  }

  func testFetchTodoList() {
    presenter?.fetchTodoList()

    XCTAssert(mockInteractor?.invokedFetchTodoList == true, "Expect fetch todo list is called")
    XCTAssert(mockInteractor?.invokedFetchTodoListCount == 1, "Expect fetch todo list is called once")
  }

  func testGetTodoList() {
    let id: Int64 = 1
    let sampleData: [String: Any] = [TodoListKey.id.rawValue: id,
                                 TodoListKey.title.rawValue: "Test"]
    let context = mockPersistentContainer?.container.viewContext

    guard let todo = TodoList.parse(json: sampleData, context: context!) as? TodoList else {
      XCTFail("Failed creating TodoList Entity")
      return
    }

    presenter?.getTodoList(todo: [todo])

    XCTAssert(mockView?.invokedShowTodoList == true, "Expect show todo list is called")
    XCTAssert(mockView?.invokedShowTodoListCount == 1, "Expect show todo list is called once")
    XCTAssert(mockView?.invokedShowTodoListParameters?.todoList == [todo], "Expect todo list parameters is same with todo")
    XCTAssert(mockView?.invokedShowTodoListParameters?.todoList.contains(todo) ?? false, "Expect todo list parameters contains is same with todo")
  }

  func testPerformanceExample() {
      // This is an example of a performance test case.
    self.measure {
        // Put the code you want to measure the time of here.
    }
  }

}