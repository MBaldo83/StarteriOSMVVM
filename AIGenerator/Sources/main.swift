import Foundation

AiderControl().run()


// The abstraction below might be useful if we introduce command line arguments
/*
 let tool = CommandLineTool()
 
 do {
 try tool.run()
 } catch {
 print("Whoops! An error occurred: \(error)")
 }
 
 public final class CommandLineTool {
 public func run() throws {
 AiderControl().run()
 }
 }
 */
