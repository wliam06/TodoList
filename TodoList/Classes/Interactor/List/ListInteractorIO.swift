//
//  ListInteractorIO.swift
//  TodoList
//
//  Created by William on 18/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol ListInteractorInput: class {
  func fetchTodoList()
}

protocol ListInteractorOutput: class {
  func getTodoList(todo: [TodoList])
}
