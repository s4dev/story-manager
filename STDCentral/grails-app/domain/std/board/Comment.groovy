package std.board

class Comment {
    
    String content
    String username
    Story story
    
    static belongsTo = [Story]

    static constraints = {
        content blank: false
    }
    
    static mapping = { 
        content type: "text"
    }
    
    String toString() {
        "$content"
    }
}
