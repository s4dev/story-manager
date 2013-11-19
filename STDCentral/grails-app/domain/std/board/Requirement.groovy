package std.board

class Requirement {

    String filename
    String content
    String referenceId
    Story story

    static belongsTo = [Story]

    static constraints = {
        content size: 1..1000
        referenceId blank: false
        //filename blank: false
        story nullable: true
    }

    String toString() {
        "$content [$filename:$referenceId]"
    }
}
