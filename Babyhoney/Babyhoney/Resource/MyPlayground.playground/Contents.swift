import UIKit

class AA {
    var name: String?
    
    init(name: String) {
        self.name = name
        print(self.name! + "init")
    }
    
    deinit {
        print(self.name! + "deinit")
    }
}

var rf1: AA?
var rf2: AA?
var rf3: AA?

rf1 = AA(name: "AA")

rf2 = rf1
rf3 = rf1
