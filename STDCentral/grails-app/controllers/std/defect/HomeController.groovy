package std.defect

import std.board.*

class HomeController {

    def index() {
    	def totalDefects = Defect.count()
        def totalStories = Story.count()

    	def defectsByState = [:]
        def storiesByState = [:]
        def openDefects = [:]
        def openStories = [:]
    	def defectsByUser = [:]
        def storiesByUser = [:]

        def categories = BoardStateCategory.values()
        def states = BoardState.list()

    	states?.each { state ->
    		defectsByState.put( state, Defect.countByState( state ) )
            storiesByState.put( state, Story.countByState( state ) )
    	}

    	def openStates = BoardState.findAllByCategory(BoardStateCategory.ITERATION)

        openDefects['open'] = Defect.countByStateInList(openStates)
        openStories['open'] = Story.countByStateInList(openStates)

    	def severities = Severity.list()
    	severities?.each { severity ->
    		openDefects.put( severity,
    			Defect.countBySeverityAndStateInList( severity, openStates ) )
    	}

        def priorities = Priority.values()
        priorities?.each { priority ->
            openStories.put ( priority,
                Story.countByPriorityAndStateInList( priority, openStates ) )
        }

    	def users = User.list()
    	if ( users && openStates ) {
	    	users.each { user ->
	    		defectsByUser.put( user,
	    			Defect.countByAssignedToAndStateInList( user, openStates ) )
                storiesByUser.put( user,
                    Story.countByAssignedToAndStateInList( user, openStates ) )
	    	}
	    }

    	return [totalDefects:totalDefects,
                totalStories: totalStories,
                allStates:states,
    			defectStateMap:defectsByState,
                storyStateMap:storiesByState,
                openStates:openStates,
                severities: severities,
    			defectOpenMap:openDefects,
                priorities: priorities,
                storyOpenMap:openStories,
                allUsers:users,
    			defectUserMap:defectsByUser,
                storyUserMap:storiesByUser]
    }

}
