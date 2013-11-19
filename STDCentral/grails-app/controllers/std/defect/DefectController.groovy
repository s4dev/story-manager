package std.defect

import org.springframework.dao.DataIntegrityViolationException
import std.board.Story

class DefectController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(DefectSearchCmd cmd) {
        def results = Defect.search(params, cmd)
        return [defectInstanceList: results,
                defectInstanceTotal: results?.totalCount ?: 0]
    }

    def create() {
        def storyList = Story.activeStories()
        if (params?.story?.id) {
            if (!storyList.collect{it.id}.contains(params.story.id)) {
                storyList << Story.findById(params.story.id)
            }
        }

        [defectInstance: new Defect(params), storyList: storyList]
    }

    // TODO: move to service
    def save() {
        def areaName = params.remove('area')
        def areaId = params.remove('areaId')
        def area

        if (areaId) {
            area = Area.findById(areaId)
        } else {
            area = Area.findOrSaveByName(areaName.trim())
        }

        def defectInstance = new Defect(params)
        defectInstance.area = area
        //defectInstance.createDefectId()

        if (!defectInstance.save(flush: true)) {
            render(view: "create", model: [defectInstance: defectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'defect.label', default: 'Defect'), defectInstance.id])
        redirect(action: "show", id: defectInstance.id)
    }

    def show(Long id) {
        def defectInstance = Defect.get(id)
        if (!defectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'defect.label', default: 'Defect'), id])
            redirect(action: "list")
            return
        }

        [defectInstance: defectInstance]
    }

    def edit(Long id) {
        def defectInstance = Defect.get(id)
        if (!defectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'defect.label', default: 'Defect'), id])
            redirect(action: "list")
            return
        }

        def storyList = Story.activeStories()
        if (defectInstance?.story?.id) {
            if (!storyList.collect{it.id}.contains(defectInstance.story.id)) {
                storyList << Story.findById(defectInstance.story.id)
            }
        }

        [defectInstance: defectInstance, storyList: storyList]
    }

    // TODO: move to service
    def update(Long id, Long version) {
        def defectInstance = Defect.get(id)
        if (!defectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'defect.label', default: 'Defect'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (defectInstance.version > version) {
                defectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'defect.label', default: 'Defect')] as Object[],
                          "Another user has updated this Defect while you were editing")
                render(view: "edit", model: [defectInstance: defectInstance])
                return
            }
        }

        def areaName = params.remove('area')
        def areaId = params.remove('areaId')
        def area

        if (areaId) {
            area = Area.findById(areaId)
        } else {
            area = Area.findOrSaveByName(areaName.trim())
        }

        //manage removal of Story assignment
        if (!params?.story?.id) {
            params.remove('story.id')
            params.remove('story')
            defectInstance.story = null
        }

        defectInstance.properties = params
        defectInstance.updateDT = new Date()
        defectInstance.area = area

        if (!defectInstance.save(flush: true)) {
            render(view: "edit", model: [defectInstance: defectInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'defect.label', default: 'Defect'), defectInstance.id])
        redirect(action: "show", id: defectInstance.id)
    }

    def delete(Long id) {
        def defectInstance = Defect.get(id)
        if (!defectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'defect.label', default: 'Defect'), id])
            redirect(action: "list")
            return
        }

        try {
            defectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'defect.label', default: 'Defect'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'defect.label', default: 'Defect'), id])
            redirect(action: "show", id: id)
        }
    }
}


class DefectSearchCmd {
    Integer max
    String area
    Status status //= Status.findByName( 'Open' ) // default: show open defects
    Severity severity
    String description
    String developerNotes
    String qaNotes
    User assignedTo
    User reportedBy
    Long id
    Story story
    Date targetDate
    Date targetDateFrom
    Date targetDateTo
}
