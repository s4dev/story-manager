package std.board

class Capability {
    String name
    
    static constraints = {
        name unique: true, size: 1..100
    }
}
