package std.board

class Assumption {
    
    String statement
    boolean provedFalse = false
    Story story
    
    static belongsTo = [Story]

    static constraints = {
        statement blank: null
        story nullable: true
    }
    
    static mapping = {
        statement type: "text"
    }
    
    String toString() {
        if (provedFalse)
            "FALSE!!! - $statement"
        else
            "$statement"
    }
}
