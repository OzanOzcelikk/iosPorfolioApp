//
//  DataController.swift
//  PortfolioApp
//
//  Created by Ozan Ozcelik on 31.10.2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    @Published var selectedFilter: Filter? = Filter.all
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        container.persistentStoreDescriptions.first?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        NotificationCenter.default.addObserver(forName: .NSPersistentStoreRemoteChange, object: container.persistentStoreCoordinator, queue: .main, using: remoteStoreChanged)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func remoteStoreChanged(_ notification: Notification){
        objectWillChange.send()
    }
    
    
    func createSampleData() {
        let viewContext = container.viewContext
        
        for i in 1..<6 {
            let tag = Tag(context: viewContext)
            tag.id = UUID()
            tag.name = "Tag \(i)"
            
            for j in 1..<6 {
                let issue = Issue(context: viewContext)
                issue.title = "Issue \(i)-\(j)"
                issue.content = "This is a test issue."
                issue.creationDate = Date()
                issue.completed = Bool.random()
                issue.priority = Int16.random(in: 0...2)
                tag.addToIssues(issue)
            }
        }
        
        try? viewContext.save()
        
    }
    
    func save(){
        if container.viewContext.hasChanges{
            try? container.viewContext.save()
        }
    }
        
    func delete(_ object: NSManagedObject){
        objectWillChange.send()
        container.viewContext.delete(object)
        save()
    }

    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>){
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        if let result = try? container.viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult{
            let changes = [NSDeletedObjectsKey: result.result as? [NSManagedObjectID] ?? []]
            
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [container.viewContext])
        }
    }
        
        func deleteAll(){
            let request1: NSFetchRequest<NSFetchRequestResult> = Tag.fetchRequest()
            delete(request1)
            
            let request2: NSFetchRequest<NSFetchRequestResult> = Issue.fetchRequest()
            delete(request2)
            
            save()
        }
}
