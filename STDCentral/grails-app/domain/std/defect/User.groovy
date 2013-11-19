package std.defect

class User {

	String firstName
	String lastName
	String email
    String imageFilename

    static constraints = {
    	firstName( blank:false, maxSize:40 )
    	lastName( blank:false, maxSize:60 )
    	email( blank:false, email:true, maxSize:100 )
        imageFilename( nullable: true )
    }

    static mapping = {
        sort "firstName"
    }

    String toString() {
    	"$firstName $lastName"
    }

}
