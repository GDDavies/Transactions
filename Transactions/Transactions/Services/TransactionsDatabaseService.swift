//
//  TransactionsDatabaseService.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import CoreData

protocol TransactionsDatabaseServiceProtocol {
    func save(orderDtos: [OrderDto], completion: ((Result<Void, Error>) -> Void)?) // should be consistent e.g. DBOrder
    func fetchOrderDtos(completion: @escaping () -> Void)
    func numberOfOrders() -> Int
    func order(at row: Int) -> DBOrder?
}

final class TransactionsDatabaseService: NSObject, TransactionsDatabaseServiceProtocol {

    private lazy var fetchedResultsController: NSFetchedResultsController<DBOrder> = {
        let context = persistentContainer.newBackgroundContext()

        let request = NSFetchRequest<DBOrder>(entityName: "UserOrder")
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20

        return NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Transactions")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func save(orderDtos: [OrderDto], completion: ((Result<Void, Error>) -> Void)?) {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        context.perform {
            var index = 0
            let total = orderDtos.count
            let batchInsert = NSBatchInsertRequest(
                entity: DBOrder.entity()
            ) { (managedObject: NSManagedObject) -> Bool in
                guard
                    index < total,
                    let dbOrder = managedObject as? DBOrder
                else {
                    return true
                }

                let order = orderDtos[index]
                dbOrder.id = order.id
                dbOrder.amount = order.amount
                dbOrder.currency = order.currency
                dbOrder.orderStatus = order.orderStatus
                dbOrder.orderType = order.orderType
                dbOrder.createdAt = order.createdAt

                index += 1
                return false
            }
            
            do {
                try context.execute(batchInsert)
                try! context.save()
                completion?(.success(Void()))
            } catch let error {
                completion?(.failure(error))
            }
        }
    }

    func fetchOrderDtos(completion: @escaping () -> Void) {
        let context = fetchedResultsController.managedObjectContext
        context.perform { [weak fetchedResultsController] in
            do {
                try fetchedResultsController?.performFetch()
                completion()
            } catch {
                print("Fetch failed")
            }
        }
    }

    func numberOfOrders() -> Int {
        guard let section = fetchedResultsController.sections?.first else { return 0 }
        return section.numberOfObjects
    }

    func order(at row: Int) -> DBOrder? {
        fetchedResultsController.object(at: IndexPath(row: row, section: 0))
    }
}

extension TransactionsDatabaseService {
    enum DatabaseError: Error {
        case generic
    }
}
