package std.board

class FunctionalArea {

    String name
    Integer sortOrder

    static hasMany = [stories: Story, builds: Build]

    static constraints = {
        name unique: true, size: 1..100
        stories nullable: true
    }

    static mapping = {
        sort "sortOrder"
    }

    String toString() {
        name
    }
}
