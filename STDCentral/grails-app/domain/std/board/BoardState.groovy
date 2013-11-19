package std.board

class BoardState {

    String name
    Integer sortOrder
    BoardStateCategory category

    static hasMany = [stories: Story]

    static constraints = {
        name unique: true, size: 1..50
    }

    static mapping = {
        sort "sortOrder"
    }

    void setCategory(String category) {
        def enumCategory = BoardStateCategory.valueOf(category)
        println enumCategory.class

        this.category = enumCategory
    }

    void setCategory(BoardStateCategory category) {

        this.category = category
    }

    String toString() {
        name
    }
}

enum BoardStateCategory {
    PRE_ITERATION, ITERATION, POST_ITERATION
}
