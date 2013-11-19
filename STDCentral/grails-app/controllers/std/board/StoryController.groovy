package std.board

import grails.plugins.springsecurity.Secured

import org.springframework.dao.DataIntegrityViolationException
import std.defect.*

class StoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "board", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.offset = params.offset ?: 0
        def storyList = Story.search(params)
        def assignmentList = Story.assignedToSummary(params)

        [storyInstanceList: storyList, storyInstanceTotal: storyList.totalCount,
            storyAssignmentSummary: assignmentList]
    }

    def board() {

        def storyList = Story.search(params)
        def listByState = storyList.groupBy { it.state?.name }
        //def buildNumbers = Story.retrieveAllBuildNumbers()

        def defectList = Defect.retrieveOrphanedDefects(params)
        defectList.addAll(Defect.retrieveOpenStoryDefects(params))
        def defectListByState = defectList.groupBy { it.state?.name }

        [boardStates: BoardState.list(), listByState: listByState, //buildNumbers: buildNumbers,
            storyInstanceTotal: storyList?.size() ?: 0,
            defectInstanceTotal: defectList?.size() ?: 0,
            defectListByState: defectListByState]
    }

    def buildPlan() {
        def builds = Story.createCriteria().list() {
            order "build"
        }.groupBy({it.build}, {it.functionalArea})

        [builds:builds]
    }

    def listByBuild() {
        def build = params.build ?: 0

        def storyList = Story.createCriteria().list() {
            createAlias "functionalArea", "f"
            eq("build", build as Integer)
            state {
                ne('name', 'Cancelled')
            }
            order "f.name"
            order "priority"
            order "id"
        }

        def buildNumbers = Story.retrieveAllBuildNumbers()

        def totalEstimate = storyList*.totalHourEstimate()?.sum() ?: 0

        [storyInstanceList: storyList, totalEstimate: totalEstimate,
            buildNumbers: buildNumbers, build: build]
    }

    def listByUser() {
        def build = params.build ?: 0

        def storyList = Story.createCriteria().list() {
            createAlias "assignedTo", "u"
            if (params?.assignedTo?.id)
                eq("u.id", params.assignedTo.id)

            order "u.first_name"
            order "build"
            order "priority"
            order "id"
        }.groupBy{it.assignedTo}

        def users = User.list()

        def totalEstimate = storyList*.totalHourEstimate()?.sum() ?: 0

        [storyInstanceList: storyList, totalEstimate: totalEstimate,
            buildNumbers: buildNumbers, build: build]
    }

    def listByState() {
        def build = params.build ?: 0

        def storyList = Story.createCriteria().list() {
            createAlias "functionalArea", "f"
            createAlias "state", "s"
            eq("build", build as Integer)
            if (params?.state?.id) {
                eq("s.id", params?.state?.id as Long)
            }
            order "s.sortOrder"
            order "f.name"
            order "priority"
            order "id"
        }.groupBy{it.functionalArea}

        def themeList = Theme.createCriteria().list() {
            createAlias "functionalArea", "f"
            eq("build", build as Integer)
        }.groupBy{it.functionalArea}

        def buildNumbers = Story.retrieveAllBuildNumbers()

        [storyInstanceList: storyList, buildNumbers: buildNumbers,
            themeList: themeList, build: build]
    }

    def storyReport() {
        def build = params.build ?: 0

        def storyList = Story.createCriteria().list() {
            createAlias "functionalArea", "f"
            createAlias "state", "s"
            //eq("build", build as Integer) //list all builds in report
            if (params?.state?.id) {
                eq("s.id", params?.state?.id as Long)
            }
            if (params?.area) {
                eq('f.id', params.area as Long)
            }
            order "phase"
            order "build"
            order "s.sortOrder"
            order "f.name"
            order "priority"
            order "id"
        }.groupBy{it.functionalArea}

        def themeList = Theme.createCriteria().list() {
            createAlias "functionalArea", "f"
            eq("build", build as Integer)
        }.groupBy{it.functionalArea}

        def buildNumbers = Story.retrieveAllBuildNumbers()

        def grandTotalsMap = [:]
 //       def totalsMap = [:]

        EstimateType.each { type ->

/*            totalsMap["$type"] = Estimate.createCriteria().list() {
                eq("type", type)
                if (params?.area) {
                    story {
                        functionalArea {
                            eq("id", params.area as Long)
                        }
                    }
                }
            }*.calculateAmountByType(EstimateAmountType.HOURS).sum() ?: 0
*/
            grandTotalsMap["$type"] = Estimate.findAllByType(type)*.calculateAmountByType(EstimateAmountType.HOURS).sum() ?: 0
        }

        def sum = 0
        grandTotalsMap.each { key, value ->
            sum = sum + value
        }
        grandTotalsMap["All"] = sum

/*        sum = 0
        totalsMap.each { key, value ->
            sum = sum + value
        }
        totalsMap["All"] = sum
*/
        withFormat {
            html {
            }
            xls {
                // set our header and content type
                response.setHeader("Content-disposition", "inline; filename=builds.xls")
                response.contentType = "application/vnd.ms-excel"
            }
        }


        render view:"storyReport", model:[storyInstanceList: storyList,
                    buildNumbers: buildNumbers, themeList: themeList,
//                    totalsMap: totalsMap,
                    grandTotalsMap: grandTotalsMap, build: build]

    }

    def pdfListByState() {
        def build = params.build ?: 0

        def storyList = Story.createCriteria().list() {
            createAlias "functionalArea", "f"
            createAlias "state", "s"
            eq("build", build as Integer)
            if (params?.state?.id) {
                eq("s.id", params?.state?.id as Long)
            }
            order "s.sortOrder"
            order "f.name"
            order "priority"
            order "id"
        }.groupBy{it.functionalArea}

        def themeList = Theme.createCriteria().list() {
            createAlias "functionalArea", "f"
            eq("build", build as Integer)
        }.groupBy{it.functionalArea}

        def buildNumbers = Story.retrieveAllBuildNumbers()

        renderPdf filename: "Build_${build}.pdf", template: "/story/pdfListByState",
            model:[storyInstanceList: storyList, buildNumbers: buildNumbers,
                    themeList: themeList, build: build]
    }

    def create() {
        [storyInstance: new Story(params)]
    }

    def save() {
        def storyInstance = new Story(params)
        if (!storyInstance.save(flush: true)) {
            render(view: "create", model: [storyInstance: storyInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'story.label', default: 'Story'), storyInstance.id])
        redirect(action: "show", id: storyInstance.id)
    }

    def show() {
        def storyInstance = Story.get(params.id)
        if (!storyInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'story.label', default: 'Story'), params.id])
            redirect(action: "list")
            return
        }

        [storyInstance: storyInstance]
    }

    def edit() {
        def storyInstance = Story.get(params.id)
        if (!storyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'story.label', default: 'Story'), params.id])
            redirect(action: "list")
            return
        }

        [storyInstance: storyInstance]
    }

    def update() {
        def storyInstance = Story.get(params.id)
        if (!storyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'story.label', default: 'Story'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (storyInstance.version > version) {
                storyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'story.label', default: 'Story')] as Object[],
                          "Another user has updated this Story while you were editing")
                render(view: "edit", model: [storyInstance: storyInstance])
                return
            }
        }

        //assigned to is not operating as expected when removing value - PITA
        if (!params?.assignedTo?.id) {
            params.remove('assignedTo.id')
            params.remove('assignedTo')
            storyInstance.assignedTo = null
        }

        storyInstance.properties = params

        if (!storyInstance.save(flush: true)) {
            render(view: "edit", model: [storyInstance: storyInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'story.label', default: 'Story'), storyInstance.id])
        redirect(action: "show", id: storyInstance.id)
    }

    def updateAssignedTo() {

        def storyInstance = Story.get(params.id)
        def assignedTo = User.findById(params?.story?.assignedTo?.id)

        if (!storyInstance) {
            render "not saved"
            return
        }

        storyInstance.assignedTo = assignedTo
        if (storyInstance.save())
            render "updated"
        else
            render "error"
    }

    def delete() {
        def storyInstance = Story.get(params.id)
        if (!storyInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'story.label', default: 'Story'), params.id])
            redirect(action: "list")
            return
        }

        try {
            storyInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'story.label', default: 'Story'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'story.label', default: 'Story'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
