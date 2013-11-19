package std.defect

class Area {

	String name

	// longest found in spreadsheet: "View/Edit Min Rates and Final Min Rates Excluding Wind" - 54 chars
	// setting to 100 - anything longer should probably go in description field

    static constraints = {
    	name( blank:false, maxSize:100, unique: true )
    }

    static mapping = {
    	sort "name"
    }

    String toString() {
    	"$name"
    }

}
