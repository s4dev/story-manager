package std.defect

import au.com.bytecode.opencsv.CSVReader
import java.text.SimpleDateFormat


/*
usage from debug console:

import std.defect.*

def spreadsheetLoaderService = ctx.getBean("spreadsheetLoaderService")
spreadsheetLoaderService.loadSpreadsheet( "/full/path/to/Current Error Log.csv" )
*/
class SpreadsheetLoaderService {

	static transactional = true


	static def dateFormatter = new SimpleDateFormat("dd-MMM-yyyy")



	def loadSpreadsheet( String csvFile ) {
		if ( ! csvFile ) {
			println "FAIL: no input file"
			return
		}

		def reader = new CSVReader( new FileReader( csvFile ) )

		String[] nextLine
		while ( (nextLine = reader.readNext()) != null ) {
		//for ( int x=0; x < 50; x++ ) {
			nextLine = reader.readNext()
			loadRow( nextLine )
		}
	}


    private void loadRow( String[] line ) {
    	//println line

		def id = line[0]?.trim()
		String dateCreated = line[1]?.trim()
		String screen = line[2]?.trim()
		String description = line[3]?.trim()
		String dateReviewed = line[4]?.trim()
		String resolution = line[5]?.trim()
		String status = line[6]?.trim()
		String severity = line[7]?.trim()
		String assignedTo = line[8]?.trim()
		String developerNotes = line[9]?.trim()
		String qaNotes = line[10]?.trim()
		String environment = line[11]?.trim()

		if ( ! id?.isNumber() ) return
		else id = id as Integer

		Date created = getDate( id, dateCreated )
		Date updated = getDate( id, dateReviewed )
		Area screenObj = getArea( screen )
		Status statusObj = Status.findByNameIlike( status )
		Severity severityObj = Severity.findByNameIlike( severity )
		User assignedObj = User.findByFirstNameIlike( assignedTo )

		User reportedObj
		if ( id % 2 == 0 ) reportedObj = User.findByFirstNameIlike( 'Ali' )
		else reportedObj = User.findByFirstNameIlike( 'Waqas' )

		new Defect( id:id,
					createDT:created,
					updateDT:updated,
					area:screenObj,
					status:statusObj,
					severity:severityObj,
					reportedBy:reportedObj,
					assignedTo:assignedObj,
					description:description,
					developerNotes:developerNotes,
					qaNotes:qaNotes,
					resolution:resolution ).save()

		//if ( id % 100 == 0 )
		//	println "processed id ${id}"
    }


    private Date getDate( id, date ) {
    	if ( date ) {
    		try {
		    	def year = id <= 568 ? 2011 : 2012
		    	date += "-${year}"
		    	return dateFormatter.parse( date )
		    }
		    catch ( e ) {
		    	println "couldn't format [${date}]"
		    }
	    }
	    return new Date()
    }

    private Area getArea( screen ) {
    	def area = Area.findByNameIlike( screen )
    	if ( ! area ) area = new Area( name:screen ).save()
    	area
    }



}
