//
//  TransactionsDatabaseService.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import CoreData

protocol TransactionsDatabaseServiceProtocol {
    func save(orders: [OrderDto]) throws
    func fetchOrderDtos() -> Result<[OrderDto], Error>
}

final class TransactionsDatabaseService: TransactionsDatabaseServiceProtocol {

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Transactions")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func save(orders: [OrderDto]) throws {
        let context = persistentContainer.newBackgroundContext()
        let entity = NSEntityDescription.entity(
            forEntityName: "UserOrder",
            in: context
        )!
        
        orders.forEach { orderDto in
            let userOrder = NSManagedObject(
                entity: entity,
                insertInto: context
            )

            userOrder.setValue(orderDto.id, forKeyPath: "id")
            userOrder.setValue(orderDto.currency, forKeyPath: "currency")
            userOrder.setValue(orderDto.amount, forKeyPath: "amount")
            userOrder.setValue(orderDto.orderType, forKeyPath: "orderType")
            userOrder.setValue(orderDto.orderStatus, forKeyPath: "orderStatus")
            userOrder.setValue(orderDto.createdAt, forKeyPath: "createdAt")
        }
        
        if context.hasChanges {
            try context.save()
            context.reset()
        }
    }

    func fetchOrderDtos() -> Result<[OrderDto], Error> {
        let context = persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserOrder")

        do {
            if let orders = try context.fetch(fetchRequest) as? [DBOrder] {
                let orderDtos = orders.map { $0.toDto() }
                return .success(orderDtos)

            } else {
                return .failure(DatabaseError.generic)
            }

        } catch let error {
            return .failure(error)
        }
    }
}

extension TransactionsDatabaseService {
    enum DatabaseError: Error {
        case generic
    }
}
