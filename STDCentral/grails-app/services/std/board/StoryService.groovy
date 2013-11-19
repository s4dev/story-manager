package std.board

import std.defect.*

class StoryService {

    def updateStory(storyInstance, params) {
        //get new estimates -- this totally sucks and is due to some really crappy implementation of databinding by grails
        //for some reason, it is not picking up associated child objects properly
        //Here's a new one:  In the commented code, the existingEstimates object(s) are changed to be identical to the newEstimate objects
        //  however, the source of why this is happening is arcane and requires a cray to determine...
        /*
                def existingEstimates = storyInstance.estimates.collect{it}
                println existingEstimates
                def storyInstance2 = new Story()
                //bindData(storyInstance2, params, [exclude: ['id']])

                //oh yeah, you can't call bindData in a Service object so here's a handy PITA approach2
                org.codehaus.groovy.grails.web.metaclass.BindDynamicMethod bind = new org.codehaus.groovy.grails.web.metaclass.BindDynamicMethod()
                def args = [storyInstance2, params, [exclude:['id']]]
                bind.invoke(storyInstance2,'bind',(Object[]) args)

                def newEstimates = storyInstance2.estimates.findAll{it.amount && it.amount >= 0}.collect{it}
                println newEstimates
                println existingEstimates //these are now the same as the new.....
        */

        //remove all estimates
        def oldEstimates = Estimate.findAllByStory(storyInstance)
        oldEstimates.each {
            storyInstance.removeFromEstimates(it)
            it.delete()
        }

        //remove estimates from existing story if they are in the parameter map
        def listParamElement = params["estimates[0]"]
        def newElements = []
        for (int i = 1; listParamElement != null; i++){
            listParamElement.remove('id')
            def instanceElement = new Estimate(listParamElement)
            //println "instanceElement: ${instanceElement}"
            if (instanceElement.amount != null)
                newElements << instanceElement
            listParamElement = params["estimates[${i}]"]
        }

        def killKeys = params.collect { key, value ->
            if (key.startsWith('estimates'))
                return key
        }
        killKeys.each {params.remove(it)}

        //update from parameters
        storyInstance.properties = params
        newElements.each { storyInstance.addToEstimates(it) }

        storyInstance.save(flush:true)
    }

    def saveOrUpdateStory(params, cmd) {

        def storyInstance

        if (params?.id) {
            storyInstance = Story.get(params.id)
            if (!storyInstance) {
                return null
            }
            //TODO: fix this to return command
            if (params.version) {
                def version = params.version.toLong()
                if (storyInstance.version > version) {
                    storyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                              [message(code: 'story.label', default: 'Story')] as Object[],
                              "Another user has updated this Story while you were editing")
                    return storyInstance
                }
            }

            //def assignedTo = User.findById(cmd.story?.assignedTo?.id)

            storyInstance.statement = cmd.story.statement
            storyInstance.state = cmd.story.state
            storyInstance.priority = cmd.story.priority
            storyInstance.functionalArea = cmd.story.functionalArea
            storyInstance.topic = cmd.story.topic
            storyInstance.epic = cmd.story.epic
            storyInstance.build = cmd.story.build
            storyInstance.phase = cmd.story.phase
            storyInstance.assignedTo = cmd.story.assignedTo

        } else {
            storyInstance = new Story(cmd.story)
        }

        if (!storyInstance.validate()) {
            println "ERRORS!!!"
            println storyInstance.errors
            return storyInstance
        }

        storyInstance.save(validate: false, flush: true)

        storyInstance
    }

    def saveOrUpdateStoryEstimates(estimates, storyInstance) {
        def oldEstimates = Estimate.findAllByStory(storyInstance)
        def newEstimates = estimates.findAll{ ! oldEstimates?.collect{ it.id }.contains( it.id ) }
        def updateEstimates = estimates - newEstimates
        def removedEstimates = oldEstimates - estimates
        def addedEstimates = []

        println "estimates: $estimates"
        println "new estimates: $newEstimates"
        println "updated estimates: $updateEstimates"
        println "removed estimates: $removedEstimates"
        println "added estimates: $addedEstimates"



        updateEstimates.each { e ->
            def updateEstimate = Estimate.findById(e.id)
            if (updateEstimate) {
                updateEstimate.amount = e.amount
                updateEstimate.amountType = e.amountType
                updateEstimate.type = e.type
                updateEstimate.story = storyInstance
                updateEstimate.save(flush: true)
            } else {
                //could not find estimate for id so add to new estimates
                newEstimates << e
            }
        }

        newEstimates.each { e ->
            def newEstimate = new Estimate(amount:e.amount,
                                           amountType:e.amountType,
                                           type:e.type,
                                           story:storyInstance)
            addedEstimates << newEstimate
        }

        removedEstimates.each { e ->
            storyInstance.removeFromEstimates(e)
            e.delete()
        }

        addedEstimates.each { e ->
            storyInstance.addToEstimates(e)
        }

        storyInstance.save(flush: true)

    }
}
