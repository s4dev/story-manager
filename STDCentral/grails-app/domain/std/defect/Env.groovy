package std.defect

class Env {

	String name

	// probable values: development, test, production, qa, performance testing
	// setting to 40 length

    static constraints = {
    	name( blank:false, maxSize:40 )
    }

    static mapping = {
    	sort "name"
    }

    String toString() {
    	"$name"
    }

}
