package std.defect

class Severity {

	String name

	// probable values: high, low, medium, moderate, critical, etc
	// 20 chars should be enough

    static constraints = {
    	name( blank:false, maxSize:20 )
    }

    String toString() {
    	"$name"
    }

}
