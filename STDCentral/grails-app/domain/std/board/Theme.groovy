package std.board

class Theme {
    
    String deliverable
    Integer build
    FunctionalArea functionalArea
    
    static belongsTo = [FunctionalArea]

    static constraints = {
        deliverable size: 1..1500
    }
    
    String toString() {
        deliverable
    }
}
