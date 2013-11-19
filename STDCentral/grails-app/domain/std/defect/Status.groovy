package std.defect

class Status {

	String name

	// probable values: open, closed, ready for test, pending review, 
	// fixed but not checked in, etc
	// more flexibility needed here, setting to 100 chars

    static constraints = {
    	name( blank:false, maxSize:100 )
    }

    String toString() {
    	"$name"
    }

}
