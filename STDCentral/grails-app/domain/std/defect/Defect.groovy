package std.defect

import std.board.*

class Defect {

	//Long defectId

	Area area 	// area/screen of the app the defect applies to
	Status status
    BoardState state
	Severity severity
	Env env
    Story story

	User reportedBy
	User assignedTo

	String description
	String developerNotes
	String qaNotes
	String resolution
    Date targetDate

	Date createDT = new Date()
	Date updateDT

    static constraints = {
    	area( nullable:false )
    	status( nullable:true )
        state( nullable:false )
    	severity( nullable:false )
    	env( nullable:true )
    	reportedBy( nullable:false )
    	assignedTo( nullable:true )
    	description( blank:false, maxSize:Integer.MAX_VALUE-1 )
    	developerNotes( nullable:true, maxSize:Integer.MAX_VALUE-1 )
    	qaNotes( nullable:true, maxSize:Integer.MAX_VALUE-1 )
    	resolution( nullable:true, maxSize:Integer.MAX_VALUE-1 )
        targetDate( nullable:true )
    	updateDT( nullable:true )
        story ( nullable:true )
    }


    static mapping = {
    	sort id:"desc"
    }

    def getDefectStatus() {
        def status = []

        if (this.state?.name?.toLowerCase()?.contains('complete'))
            status << StoryStatus.COMPLETED
        else
            status << StoryStatus.OPEN

        return status
    }


    // void createDefectId() {
    // 	def maxId = Defect.executeQuery( "select max(defectId) from Defect" )
    // 	if ( maxId ) {
    // 		this.defectId = maxId[0] + 1
    // 	}
    // }


    static def search( params, DefectSearchCmd cmd ) {
    	params.max = Math.min(cmd.max ?: 10, 100)

    	Defect.createCriteria().list( params ) {
    		if ( cmd.area ) {
	    		area {
	    			ilike( "name", "%${cmd.area}%" )
	    		}
	    	}
	    	if ( cmd.status ) {
	    		status {
	    			eq( "name", cmd.status.name )
	    		}
	    	}
	    	if ( cmd.severity ) {
	    		severity {
	    			eq( "name", cmd.severity.name )
	    		}
	    	}
	    	if ( cmd.assignedTo ) {
	    		eq( "assignedTo.id", cmd.assignedTo.id )
	    	}
	    	if ( cmd.reportedBy ) {
	    		eq( "reportedBy.id", cmd.reportedBy.id )
	    	}
	    	if ( cmd.description ) {
	    		ilike( "description", "%${cmd.description}%" )
	    	}
	    	if ( cmd.developerNotes ) {
	    		ilike( "developerNotes", "%${cmd.developerNotes}%" )
	    	}
            if ( cmd.qaNotes ) {
                ilike( 'qaNotes', "%${cmd.qaNotes}%" )
            }

            if (cmd?.targetDateFrom && cmd?.targetDateTo) {
                between('targetDate', Date.parse('MM/dd/yyyy',cmd.targetDateFrom),
                                      Date.parse('MM/dd/yyyy',cmd.targetDateTo))
            } else if (cmd?.targetDateFrom && !cmd?.targetDateTo) {
                ge('targetDate', Date.parse('MM/dd/yyyy',cmd.targetDateFrom))
            } else if (!cmd?.targetDateFrom && cmd?.targetDateTo) {
                le('targetDate', Date.parse('MM/dd/yyyy',cmd.targetDateTo))
            }

            if (cmd?.targetDate)
                eq('targetDate', Date.parse('MM/dd/yyyy',cmd.targetDate))

            if (cmd.story) {
                if (!cmd.story.id)
                    isNull("story.id")
                else
                    eq( "story.id", cmd.story.id )
            }
	    	if ( cmd.id ) {
	    		eq( "id", cmd.id )
	    	}
    	}
    }

    static def retrieveOrphanedDefects( params ) {

        Defect.createCriteria().list( params ) {
            isNull("story.id")
            if (params.assignedTo?.id)
                eq("assignedTo.id", params.assignedTo.id as Long)
        }
    }

    static def retrieveOpenStoryDefects( params ) {

        Defect.createCriteria().list( params ) {
            isNotNull("story.id")
            state {
                not {
                    ilike("name", '%complete%')
                }
            }
            if (params.assignedTo?.id)
                eq("assignedTo.id", params.assignedTo.id as Long)
        }
    }

    String toString() {
        "$id : $description"
    }
}
