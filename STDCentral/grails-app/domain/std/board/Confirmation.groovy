package std.board

class Confirmation {

    String text
    Story story

    static belongsTo = [Story]

    static constraints = {
        text size: 1..1000
    }

    String toString() {
        "$text"
    }
}
